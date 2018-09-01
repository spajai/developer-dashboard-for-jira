package Utils;

use strict;
use warnings;

use File::FindLib 'lib';
use File::FindLib 'cpanlib';
use DateTime;
use DateTime::Format::Flexible;
# use URL::Encode qw (url_encode);
use URL::Encode;

use Core;
use DB;
use Conf;
sub new {
    return bless(
        {
            _db   => DB->new->connect_db(),
            _log  => Core->new->dashboard_logger,
            _logd => Core->new->db_logger,
            _conf => Conf->new,
        },
        shift
    );
}

sub get_files_to_process {
    my $self = shift;
    my $dir  = shift;
    return unless ($dir);
    opendir(DIR, $dir) or die $!;
    my @file_name;
    while (my $file = readdir(DIR)) {
        my $loc = "$dir/$file";
        next unless (-f $loc);
        push(@file_name, $loc);
    }
    return @file_name;
}

sub hit {
    my $self  = shift;
    my $type  = shift || '';
    my $db    = $self->{_db};
    my $table = {
        'dev'    => 'users',
        'ticket' => 'tickets',
        'hidden' => 'hidden_tickets',
        'dsr'    => 'daily_reports',
        'report' => 'report_processor',
    };
    if ($type) {
        $type = lc($type);
        if ($type eq 'counter') {
            #my ($total) = $db->selectrow_array("select count from counter");
            my ($total) = $db->selectcol_arrayref("select count from counter", { Columns => [ 1] }) || [];
            return { 'count' => $total };
        }
        return { 'error' => 'Not Valid param' } if (!$table->{$type});
        #my $res = $db->selectrow_hashref("select count(*) as count from $table->{$type}");
        my ($res ) = $db->selectcol_arrayref("select count(*) as count from $table->{$type}", { Columns => [ 1] }) || [];
        return { 'count' => $res };
    }
    $db->do('update counter set count = count + 1');
    return;
}

sub validate_credential {
    my $self = shift;
    my $user = shift || undef;
    my $pass = shift || undef;
    my $db   = $self->{_db};

    my ($user_db, $pass_db) = $db->selectrow_array("select user_id,pass from dashboard_admin where user_id = '$user'");
    my $valid = Core->new->valid_pass($pass_db, $pass);
    return ($user_db, $valid);

}

sub today {
    my $self   = shift;
    my $method = shift || 0;
    my $dt     = DateTime->today;
    return $method ? $dt : $dt->date;
}

sub parse_datetime {
    my ($self, $date) = (@_);
    return DateTime::Format::Flexible->parse_datetime($date);
}

sub to_db_timestamp {
    return shift->parse_datetime(@_)->datetime;
}

sub month_num_to_text {
    my ($self, $month) = (@_);

    my $month_map = {
        1  => 'Jan',
        2  => 'Feb',
        3  => 'Mar',
        4  => 'Apr',
        5  => 'May',
        6  => 'Jun',
        7  => 'Jul',
        8  => 'Aug',
        9  => 'Sep',
        10 => 'Oct',
        12 => 'Nov',
        12 => 'Dec',
    };

    return $month_map->{$month};

}

sub get_join_query {
    my ($self, $team, $status) = (@_);
    $team   = [$team]   if ref $team ne 'ARRAY';
    $status = [$status] if ref $status ne 'ARRAY';
    my $st = join(',', map { "'$_'" } @$status);
    my $tm = join(',', map { "'$_'" } @$team);
    return <<SQL;
select 
    t.ticket_id,
    u.name,
    t.summary,
    t.last_viewed,
    t.updated,
    t.eta
from
    user_tickets ut
        inner join
    users u
        on ut.user_id = u.user_id
        inner join 
    tickets t
        on ut.ticket_id = t.ticket_id
where 
        t.status in ($st)
    and 
        u.team in ($tm)
    and 
        t.ticket_id not in (select ticket_id from hidden_tickets where hidden = true)
SQL

}

sub log_db_error {
    my $self  = shift;
    my $error = shift;
    $self->{_log}->fatal("DB ERROR execution failed: $error");
    $self->{_logd}->error("DB ERROR execution failed: $error");
}

sub get_org_email {
    my $self = shift;
    return (defined $self->{_conf}->{org_bug_report_email}) ? join (';', @{$self->{_conf}->{org_bug_report_email}}) : '';
}

sub get_ticket_query {
    my $self = shift;
    my @dev = $self->get_users();
    my $dev_sting = join (',' , @dev);
    my $custom =  $self->{_conf}->{custom_jira_jql};
    my $query = 'assignee was in ('. $dev_sting.' ) or reporter was in ('.$dev_sting.') or creator was in ('.$dev_sting.')';
    my $url = $self->{_conf}->{org_jira_url};

    return $url.URL::Encode::url_encode_utf8($custom.$query);
    # return $url.url_encode($custom.$query);
}

sub get_users {
    my $self = shift;
    my $type = shift || 'name';

    my $dev = $self->{_db}->selectcol_arrayref("select user_id,name from users", { Columns => [ 1, 2 ] }) || [];
    my %dev_hash = @$dev;

    my @dev_list = (lc($type) eq 'id') ? (sort keys %dev_hash) : (sort values %dev_hash);

    return wantarray ? @dev_list : \%dev_hash;
}

sub csv_db_field_map {
    return shift->{_conf}->{csv_db_field_map};
}

1;
