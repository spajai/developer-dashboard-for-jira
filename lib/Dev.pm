package Dev;

use strict;
use warnings;
use File::FindLib 'lib';

use SQL::Abstract;
use DB;
use Core;

sub new {
    my $self  = shift;
    my $class = {
        _sql => SQL::Abstract->new,
        _db  => DB->new->connect_db,
        _log => Core->new->dashboard_logger,
    };

    return bless($class, $self);
}

sub add_dev {
    my ($self, $data) = @_;
    my $db  = $self->{_db};
    my $sql = $self->{_sql};
    my $log = $self->{_log};
    my $res = $db->prepare('select 1 from users where  user_id= ?')->execute($data->{user_id});
    if ($res == 1) {
        $log->warn("User already exist with user_id $data->{user_id}");
        return -1;
    }
    eval {
        my ($stmt, @bind) = $sql->insert('users', $data);
        my $sth_ut = $db->prepare($stmt);
        $sth_ut->execute(@bind);
    };

    if ($@) {
        $log->error("execution failed DB error: $db->errstr()\n SYSTEM capture: $@");
        return 0;
    }
    return 1;
}

1;
