package Report::Data;

use strict;
use warnings;
use File::FindLib 'lib';
use SQL::Abstract;
use DB;
use JSON;
use Utils;
use Conf;
use Core;

sub new {
    my $self = shift;
    my $class = {
        _db   => DB->new->connect_db(),
        _util => Utils->new,
        _conf => Conf->new,
        _sql => SQL::Abstract->new(),
        _log => Core->new->dashboard_logger,
        _logd => Core->new->db_logger,
    }; 
    return bless($class, $self);
}

sub get_ticket_by_month {
    my $self = shift;
    my $year = shift || 'YEAR(CURDATE())';
    my $db = $self->{_db};
    my $util = $self->{_util};
    my $logd = $self->{_logd};
    my $query = <<SQL;
SELECT COUNT(*) as TOTAL, MONTH(created) as MONTH FROM tickets WHERE YEAR(created) = $year GROUP BY YEAR(created), MONTH(created)
SQL
    my $data = {};
    my $sth = $db->prepare($query);
    $sth->execute;
    while(my $r = $sth->fetchrow_hashref()) {
        $data->{$util->month_num_to_text($r->{MONTH})} = $r->{TOTAL};
        $data->{YEAR} += $r->{TOTAL} || 0;
    }
    return $data;  

}

sub get_ticket_count {
    my $self = shift;
    my $user_id = shift || undef;
    my $db = $self->{_db};
    my $query = <<SQL;
SELECT  COUNT(*) as count,u.name,ut.type,u.user_id FROM user_tickets as ut INNER JOIN users as u on ut.user_id = u.user_id  GROUP BY ut.type ,u.name,user_id order by u.name
SQL
    my $data = {};
    my $sth = $db->prepare($query);
    $sth->execute;
    while(my $r = $sth->fetchrow_hashref()) {
        if($user_id) {
            next unless ($r->{user_id} eq $user_id);
        }
        $data->{uc($r->{name})}->{$r->{type}} = $r->{count};
        $data->{uc($r->{name})}->{TOTAL} += $r->{count};
        $data->{TOTAL} += $r->{count};
    }
    return $data;

}

sub get_project_health {
    my $self = shift;
    my $team = shift || '';
    my $status = $self->{_conf}->{status_for_health_bar};
    my $db = $self->{_db};
    my $query = $self->{_util}->get_join_query($team,$status);
    my $total = $db->selectall_array($query) + 0;

    return $self->get_health($total) || undef;
}

sub get_health {
    my $self  = shift;
    my $total = shift || 0;
    my %map;
    my @state = qw(critical bad good);
    @map{@state} = @{$self->{_conf}->{health_bar_threshold}};
    foreach (@state) {
        return uc($_) if ($total >= $map{$_});
    }
    return;
}


sub get_data_for_horizontal_bar {


  # select count(ticket_id),user_id,type from user_tickets where type in (select DISTINCT(type) from user_tickets) group by user_id,type  

}


sub get_hidden_tickets {
    my $self = shift;
    my $id  = shift || 0;
    my $db = $self->{_db};
    my $sql = $self->{_sql};
    my $log = $self->{_log};
    my $logd = $self->{_logd};
    my $util = $self->{_util};
    my $query = 'select id,ticket_id,hidden from hidden_tickets';
    $query .= " where ticket_id = '$id'" if($id);
    my $data = [];
    my $sth = $db->prepare($query);
    $sth->execute || $util->log_db_error($db->errstr());

    while(my $r = $sth->fetchrow_hashref()) {
        push @$data,$r;
    }
    return $data;  

}

sub set_hidden_tickets {
    my $self = shift;
    my $id  = shift || 0;
    my $val = shift;
    $val = 1 if (!defined $val || $val ne '0');
    my $res = 0;
    my $db  = $self->{_db};
    my $sql  = $self->{_sql};
    my $log  = $self->{_log};
    my $util = $self->{_util};
    my $exist = $self->get_hidden_tickets($id);
    my $stmt;
    my @bind;
    my $data = {
        'ticket_id' => $id,
        'hidden'    => $val,
    };

    if (scalar @$exist > 0) {
       ($stmt, @bind) = $sql->update('hidden_tickets',$data , {ticket_id => $id});
        $log->info("Ticket $id being updated with hidden value $val");
    } else {
        ($stmt, @bind) = $sql->insert('hidden_tickets',$data );
        $log->info("Ticket $id being inserted with hidden value $val");
    }

    my $sth = $db->prepare($stmt);

    eval {
        $sth->execute(@bind);
        $res = 1;
    };

    if ($@) {
        $util->log_db_error($db->errstr());
        $util->log_db_error($@);
    }

    return $res;
}

1;