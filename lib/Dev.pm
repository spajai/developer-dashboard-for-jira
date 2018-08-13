package Dev;

use strict;
use warnings;

use File::FindLib 'lib';
use File::FindLib 'cpanlib';

use JSON;
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
    my $res = $self->check_dev($data->{user_id});
    if ($res == 1) {
        $self->{_log}->warn("User already exist with user_id $data->{user_id}");
        return -1;
    }
    eval {
        my ($stmt, @bind) = $self->{_sql}->insert('users', $data);
        my $sth_ut = $db->prepare($stmt);
        $sth_ut->execute(@bind);
        $self->{_log}->info("User user_id '$data->{user_id}' has been added sucessfully data".encode_json($data) );
    };

    if ($@) {
        $self->{_log}->error("execution failed DB error:". $db->errstr()."\n SYSTEM capture: $@");
        return 0;
    }

    return 1;
}

sub update_dev {
    my ($self, $data) = @_;
    my $db  = $self->{_db};
    my $res = $self->check_dev($data->{user_id});
    if ($res != 1) {
        $self->{_log}->warn("User with user_id '$data->{user_id}' does not exist ");
        return -1;
    }

    eval {
        my ($stmt, @bind) = $self->{_sql}->update('users', $data,{ 'user_id' => $data->{user_id} });
        $self->{_log}->info("User with user_id '$data->{user_id}' updated sucessfully data ". encode_json ($data));
        my $sth_ut = $db->prepare($stmt);
        $sth_ut->execute(@bind);
    };

    if ($@) {
        $self->{_log}->error("execution failed DB error:".$db->errstr()."\n SYSTEM capture: $@");
        return 0;
    }

    return 1;

}

sub delete_dev {
    my ($self, $data) = @_;
    my $db  = $self->{_db};
    my $log = $self->{_log};
    my $res = $self->check_dev($data->{user_id});

    if ($res != 1) {
        $self->{_log}->warn("User with user_id '$data->{user_id}' does not exist ");
        return -1;
    }

    eval {
        my ($stmt, @bind) = $self->{_sql}->delete('users', {'user_id' => $data->{user_id} });
        my $sth_ut = $db->prepare($stmt);
        $sth_ut->execute(@bind);
        $self->{_log}->info("user_id '$data->{user_id}' has been deleted sucessfully");
    };

    if ($@) {
        $log->error("execution failed DB error: ".$db->errstr()."\n SYSTEM capture: $@");
        return 0;
    }

    return 1;
}


sub check_dev {
    return shift->{_db}->prepare('select 1 from users where user_id= ?')->execute(shift)
}
1;
