package Report::Csv;

use strict;
use warnings;

use File::FindLib 'lib';
use File::FindLib 'cpanlib';
use Parallel::ForkManager;
use Parse::CSV;
use SQL::Abstract;

use DB;
use JSON;
use Core;
use Utils;

our $self = undef;

sub new {
    my $this = shift;
    my $file = shift;
    die "Unable to open file '$file' use fullpath" unless (-f $file);
    my $csv = Parse::CSV->new(
        file  => $file,
        names => 1,
    );
    if (!$self) {
        my $class = {
            _csv  => $csv,
            _sql  => SQL::Abstract->new(),
            _db   => DB->new->connect_db(),
            _log  => Core->new->dashboard_logger,
            _util => Utils->new,
        };
        $self = bless($class, $this);
    }

    return $self;
}

sub process_csv_rows {
    my ($self) = @_;
    my $sql    = $self->{_sql};
    my $csv    = $self->{_csv};
    my $log    = $self->{_log};
    my $count  = 0;
    my $result = {
        'ticket'       => {},
        'user_tickets' => {},
    };
    while (my $row = $csv->fetch) {
        ++$count;

        # my $pm = new Parallel::ForkManager(5); # does weired behavior when set on
        # $pm->start and next;  #fork and forgot
        my $data = $self->get_mapped_data($row);
        $data->{'status'} ||= 'UNKNOWN';
        $self->check_and_insert_or_update_tickets($data, $result->{ticket});
        $self->check_and_insert_or_update_user_tickets($data, $result->{user_tickets});

        # $pm->finish;
    }

    $result->{total} = $count;
    $log->info("Proccessed Total: $count Rows");

    return $result;
}

sub check_and_insert_or_update_tickets {
    my ($self, $data, $result) = @_;
    my $db   = $self->{_db};
    my $sql  = $self->{_sql};
    my $log  = $self->{_log};
    my $util = $self->{_util};
    my $res  = $db->prepare('select 1 from tickets where  ticket_id= ?')->execute($data->{ticket_id});
    $res or ($log->logconfess("execution failed: " . $db->errstr()));

    foreach (qw/last_viewed created updated eta resolved/) {
        if (exists $data->{$_}) {    #correct timestamp
            if ($data->{$_} ne '') {
                $data->{$_} = $util->to_db_timestamp($data->{$_});

                # $data->{$_} .=':00';
            } else {
                $data->{$_} = '2000-01-01 00:00:01';
            }
        }
    }

    #update the info for now
    my ($stmt, @bind);
    if ($res ne '0E0') {
        ($stmt, @bind) = $sql->update('tickets', $data, { ticket_id => $data->{ticket_id} });
        $result->{update}++;
    } else {
        ($stmt, @bind) = $sql->insert('tickets', $data);
        $result->{insert}++;
    }
    my $sth = $db->prepare($stmt);
    eval { $sth->execute(@bind); } or do {
        $result->{error}++;
        $log->logconfess("Execution failed:" . $db->errstr());
    };

    $log->info("Tickets table has been updated successfully");
    return;
}

sub check_and_insert_or_update_user_tickets {
    my ($self, $data, $result) = @_;
    my $db     = $self->{_db};
    my $sql    = $self->{_sql};
    my $log    = $self->{_log};
    my $dev    = '';
    my $update = 0;
    my $sth    = $db->prepare("select user_id from users");
    $sth->execute();
    my @dev_list = @{ $db->selectcol_arrayref('select user_id from users') };

    #Took lot of efforts can't be optimized
    #dev is assignee ?
    foreach (@dev_list) {
        $dev = $data->{assignee} if (lc($data->{assignee}) eq lc($_));
    }

    #dev is creator ?

    foreach (@dev_list) {
        $dev = $data->{creator} if (lc($data->{creator}) eq lc($_) and $dev eq '');
    }

    #dev is reporter ?
    foreach (@dev_list) {
        $dev = $data->{reporter} if (lc($data->{reporter}) eq lc($_) and $dev eq '');
    }

    #dev is certainly from this org
    $dev = 'unknown-dev' if ($dev eq '');

    my @type = split('-', $data->{ticket_id});
    my $record = {
        ticket_id => $data->{ticket_id},
        user_id   => $dev,
        type      => $data->{project} || $type[0],
    };

    my $res = $db->prepare('select 1 from user_tickets where  ticket_id= ? and user_id = ?')->execute($data->{ticket_id}, $dev);
    if ($res == 1) {
        $result->{skipped}++;
        $log->debug("SKIPPED Ticket '$data->{ticket_id}' for user '$dev' already exists");
        return;
    }

    my $ticket_query = $db->prepare('select id,user_id,ticket_id from user_tickets where ticket_id= ?');
    $ticket_query->execute($data->{ticket_id});
    my $dev_row = $ticket_query->fetchrow_hashref();

    if (defined $dev_row && exists $dev_row->{ticket_id}) {

        #ticket has been transitioned update the dev
        if ($dev_row->{user_id} ne $dev && $dev_row->{ticket_id} eq $data->{ticket_id}) {
            $update = 1;
            delete $record->{ticket_id};    #dont need to update ticket_id
            delete $record->{type};         #dont need to update type
            $log->info("UPDATED Ticket '$data->{ticket_id}' has been TRANSITIONED from '$dev_row->{user_id}' to '$dev' and updated in DB");
        }
    }
    my ($stmt, @bind);

    if ($update) {
        ($stmt, @bind) = $sql->update('user_tickets', $record, { id => $dev_row->{id} });
        $result->{update}++;
    } else {
        ($stmt, @bind) = $sql->insert('user_tickets', $record);
        $result->{insert}++;
    }
    my $sth_ut = $db->prepare($stmt);

    eval {
        $sth_ut->execute(@bind);
        $log->info("Ticket $data->{ticket_id} has been added for user '$dev'") if (!$update);
    };

    if ($@) {
        $result->{error}++;
        $log->error("ERROR execution failed DB error:" . $db->errstr() . " \n SYSTEM capture: $@");
        return;
    }

}

sub get_mapped_data {
    my ($self, $raw_data) = @_;
    my $data = {};
    $data->{metadata} = encode_json $raw_data;
    my $csv_fileds_map = $self->{_util}->csv_db_field_map;

    foreach my $k (keys %$raw_data) {
        no warnings;
        next unless (exists $raw_data->{$k});
        $data->{ $csv_fileds_map->{$k} } = $raw_data->{$k};
    }
    delete $data->{''};    #weired key deletion
    return $data;
}

sub get_ticket_type {
    return split('-', $_[1]);
}

1;
