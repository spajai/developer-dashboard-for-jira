package Report::Data;

use strict;
use warnings;
use File::FindLib 'lib';
use File::FindLib 'cpanlib';

use SQL::Abstract;
use DB;
use JSON;
use Utils;
use Conf;
use Core;

our $self = undef;

sub new {
    my $this = shift;

    if (!$self) {
        my $class = {
            _db   => DB->new->connect_db(),
            _util => Utils->new,
            _conf => Conf->new,
            _sql  => SQL::Abstract->new(),
            _log  => Core->new->dashboard_logger,
            _logd => Core->new->db_logger,
        };
        $self = bless($class, $this);
    }

    return $self;
}

sub get_ticket_by_month {
    my $self  = shift;
    my $year  = shift || 'YEAR(CURDATE())';
    my $db    = $self->{_db};
    my $util  = $self->{_util};
    my $query = <<SQL;
select count(*) as total, month(created) as month from tickets where year(created) = $year group by year(created), month(created)
SQL
    my $data = {};
    my $sth  = $db->prepare($query);
    $sth->execute;

    while (my $r = $sth->fetchrow_hashref()) {
        $data->{ $util->month_num_to_text($r->{month}) } = $r->{total};
        $data->{year} += $r->{total} || 0;
    }

    return $data;

}

sub get_ticket_count {
    my $self    = shift;
    my $user_id = shift || undef;
    my $db      = $self->{_db};
    my $query   = <<SQL;
select count(*) as count,u.name,ut.type,u.user_id from user_tickets as ut inner join users as u on ut.user_id = u.user_id  group by ut.type ,u.name,user_id order by u.name
SQL
    my $data = {};
    my $sth  = $db->prepare($query);
    $sth->execute;
    while (my $r = $sth->fetchrow_hashref()) {

        if ($user_id) {
            next unless ($r->{user_id} eq $user_id);
        }
        $data->{ lc($r->{name}) }->{ $r->{type} } = $r->{count};
        $data->{ lc($r->{name}) }->{total} += $r->{count};
        $data->{total} += $r->{count};
    }
    return $data;

}

sub get_project_health {
    my $self   = shift;
    my $team   = shift || '';
    my $status = $self->{_conf}->{status_for_health_bar};

    my $query = $self->{_util}->get_join_query($team, $status);
    my $total = $self->{_db}->selectall_array($query) + 0;

    return $self->get_health($total) || undef;
}

sub get_health {
    my $self = shift;
    my $total = shift || 0;
    my %map;
    my @state = qw(critical bad good);
    @map{@state} = @{ $self->{_conf}->{health_bar_threshold} };
    my $res = { 'val' => int(($total / $map{'critical'}) * 100), };

    foreach (@state) {
        return $res->{state} = lc($_) if ($total >= $map{$_});
    }

    return;
}

# sub get_data_for_horizontal_bar {
sub get_data_for_graph {
    my $self = shift;
    my $db   = $self->{_db};

    # my @type = $db->selectall_array('select distinct type from user_tickets');
    my %data;
    my @type = @{ $db->selectcol_arrayref('select distinct type from user_tickets') };
    my @dev  = @{ $db->selectcol_arrayref('select distinct name from users') };
    my $query = "select count(ut.ticket_id) as count ,u.name ,ut.type from user_tickets as ut,users as u where type in (select distinct(type) from user_tickets) and u.user_id = ut.user_id group by ut.user_id,type";

    my $sth = $db->prepare($query);
    $sth->execute;

    @data{@type} = map { }, @type;

    foreach my $t (@type) {
        foreach my $d (@dev) {
            $data{$t}->{$d} = 0;
        }
    }

    while (my $r = $sth->fetchrow_hashref()) {

        $data{ $r->{type} }->{ $r->{name} } += $r->{count};
    }
    return \%data;

    #select DISTINCT type from user_tickets

# select count(ticket_id),user_id,type from user_tickets where type in (select DISTINCT(type) from user_tickets) group by user_id,type

}

sub get_hidden_tickets {
    my $self = shift;
    my $id = shift || 0;

    my $query = 'select id,ticket_id,hidden from hidden_tickets';
    $query .= " where ticket_id = '$id'" if ($id);
    my $data = [];
    my $sth  = $self->{_db}->prepare($query);
    $sth->execute || $self->{_util}->log_db_error($self->{_db}->errstr());

    while (my $r = $sth->fetchrow_hashref()) {
        push @$data, $r;
    }

    return $data;

}

sub set_hidden_tickets {
    my $self = shift;
    my $id   = shift || 0;
    my $val  = shift;
    $val = 1 if (!defined $val || $val ne '0');
    my $res   = 0;
    my $db    = $self->{_db};
    my $exist = $self->get_hidden_tickets($id);
    my $stmt;
    my @bind;
    my $data = {
        'ticket_id' => $id,
        'hidden'    => $val,
    };

    if (scalar @$exist > 0) {
        ($stmt, @bind) = $self->{_sql}->update('hidden_tickets', $data, { ticket_id => $id });
        $self->{_log}->info("Ticket $id being updated with hidden value $val");
    } else {
        ($stmt, @bind) = $self->{_sql}->insert('hidden_tickets', $data);
        $self->{_log}->info("Ticket $id being inserted with hidden value $val");
    }

    my $sth = $db->prepare($stmt);

    eval {
        $sth->execute(@bind);
        $res = 1;
    };

    if ($@) {
        $self->{_util}->log_db_error($db->errstr());
        $self->{_util}->log_db_error($@);
    }

    return $res;
}

sub last_report {
    return { 'lastmodified' =>
          (shift->{_db}->selectrow_array("select max(last_modfied) from report_processor where status = 'finished'"))[0]
          || '' };
}

sub get_ticket_meta {
    my $self   = shift;
    my $id     = shift || undef;
    my $offset = shift || 0;
    my $res    = {};
    my $query  = "select metadata,id from tickets";

    if (defined $id) {
        $query .=
          " where ticket_id = '$id'";    #using since not dealing with sensitive data(no need to handle sql injection)
    } else {
        $query .= " limit 100 offset $offset ";
    }

    my $sth = $self->{_db}->prepare($query);
    $sth->execute() || $self->{_util}->log_db_error($self->{_db}->errstr());
    while (my $r = $sth->fetchrow_hashref()) {
        $res->{ $r->{id} } = from_json($r->{metadata});
    }

    return $res;

}

sub get_trend_data {
    my $self = shift;
    my $res  = {};

    my $query = {
        'project'  => 'project as x from tickets group by project',
        'status'   => 'status as x from tickets group by status',
        'year'     => 'year(created) as x from tickets group by year(created)',
        'month'    => 'month(created) as x from tickets group by month(created) ',
        'day'      => 'day(created) as x from tickets group by day(created) ',
        'priority' => 'priority  as x from tickets group by priority',
    };

    foreach my $data (keys %$query) {
        my $sth = $self->{_db}->prepare('select count(*) as y,' . $query->{$data});
        $sth->execute() || $self->{_util}->log_db_error($self->{_db}->errstr());
        $res->{$data} = $sth->fetchall_arrayref({});
        # while (my $row = $sth->fetchrow_hashref()) {# push (@{$res->{$data}} , $row); }
    }

    return $res;
}

1;
