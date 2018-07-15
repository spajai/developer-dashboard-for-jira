package Utils;

use strict;
use warnings;
use File::FindLib 'lib';
use DateTime;
use DateTime::Format::Flexible;

use Core;
use DB;

sub new {
    return bless(
        {
            _db   => DB->new->connect_db(),
            _log  => Core->new->dashboard_logger,
            _logd => Core->new->db_logger,
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
            my $total = $db->selectrow_array("SELECT count from counter");
            return { 'COUNT' => $total };
        }
        return { 'ERROR' => 'Not Valid param' } if (!$table->{$type});
        my $total = $db->selectrow_array("SELECT count(*) from " . $table->{$type});
        return { 'COUNT' => $total };
    }
    $db->do('update counter set count = count + 1');
    return;
}

sub validate_credential {
    my $self = shift;
    my $user = shift || undef;
    my $pass = shift || undef;
    my $db   = $self->{_db};

    my ($user_db, $pass_db) = $db->selectrow_array("SELECT user_id,pass from dashboard_admin where user_id = '$user'");
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
        1  => 'JAN',
        2  => 'FEB',
        3  => 'MAR',
        4  => 'APR',
        5  => 'MAY',
        6  => 'JUN',
        7  => 'JUL',
        8  => 'AUG',
        9  => 'SEP',
        10 => 'OCT',
        12 => 'NOV',
        12 => 'DEC',
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

1;
