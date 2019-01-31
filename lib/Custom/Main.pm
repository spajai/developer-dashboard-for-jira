package Custom::Main;

use strict;
use warnings;
use File::FindLib 'lib';
use File::FindLib 'cpanlib';

use SQL::Abstract;
use DB;
use Core;
use Utils;
use JSON;
my $state = ['In Progress', 'Ready for Review', 'New Deploy Plan', 'Approved', 'To Do', 'Investigate', 'New'];
my $tem = [''];

sub new {
   return bless({
        _db  => DB->new->connect_db(),
        _sql => SQL::Abstract->new(),
        _log => Core->new->dashboard_logger,
        _util=> Utils->new,
    }, shift);
}



############################# Work in progress incomplete module do not use it #######################





sub get_report {
    my ($self,$team,$date) = (@_);
    my $util = $self->{_util};
    my $type = ['fetch','update','pdf','genrate'];
    my $db = $self->{_db};
    my $log = $self->{_log};
    my $sql = $self->{_sql};
    # my $id = $self->report_exists($util->today(),$team); #use this later
    my $data = $self->existing_report($util->today(),$tem->[0]);

    if ($data) {
        #report exist and fetched successfully
        $log->info("Report for '$date' present in DB ID :- '$data->{id}' team :- '$team'");
        return { 'metadata' => $data->{metadata}, 'generated' => $data->{created}, 'lastmodified' => $data->{last_modfied}, 'ID' => $data->{id}};
    } else {
        #report not exists so generate and insert
        $log->info("No Report available for Date :- '$date'  and team:- '$team' in DB Generating now...");
        my $query = $util->get_join_query($tem,$state);
        $data->{metadata} = encode_json $db->selectall_hashref($query,'ticket_id');
        $data->{team} = $tem->[0];
        $data->{for_date} = $util->today;
        my ($stmt,@bind) = $sql->insert('daily_reports',$data);
        my $sth = $db->prepare($stmt);
        $sth->execute(@bind);
        # $data = $self->existing_report($util->today(),$tem->[0]);
        $data = $self->existing_report($util->today(),$tem->[0]);

        return  { 'metadata' => $data->{metadata}, 'generated' => $data->{created}, 'lastmodified' => $data->{last_modfied} , 'id' => $data->{id}}; 
    }

}

sub update_dsr {
    my ($self,$team,$date) = (@_);
    my $util = $self->{_util};

    # my $db = $self->{_db};
    # my $log = $self->{_log};
    my $sql = $self->{_sql};
    # my $id = $self->report_exists($util->today(),$team); #use this later
    my $data = $self->existing_report($util->today(),$tem->[0]);
    #Return since data does not exists
    return {'status' => 'Error' ,'messagge' => 'No Data Available For ID'} unless($data);

    my ($stmt,@bind) = $sql->insert('daily_reports',$data);
}


sub existing_report {
    my ($self,$date,$team) = @_;
    return $self->{_db}->selectrow_hashref("select * from daily_reports where date(for_date) ='$date' and team = '$team'") || undef;
}
1;
