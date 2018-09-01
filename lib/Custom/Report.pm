package Custom::Report;

use strict;
use warnings;
use File::FindLib 'lib';
use File::FindLib 'cpanlib';
use File::Basename;
use File::Copy;
use File::Path qw(make_path);

use DateTime::Format::MySQL;
use DateTime::Format::Flexible;
use Parse::CSV;
use SQL::Abstract;
use DB;
use JSON;
use Utils;
use Conf;
use Core;
use Report::Csv;

use Data::Dumper;


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

sub process_custom_report {
    my $self   = shift;
    my $conf         = Conf->new();
    my $db           = DB->new->connect_db();
    my $upload_dir   = $conf->{cust_upload_dir};
    my $finished_dir = $conf->{cust_finished_dir};
    my $max          = $conf->{cust_reports_cleanup_threshold};
    my $utils        = Utils->new();
    my $sql          = SQL::Abstract->new;

    my @name     = $utils->get_files_to_process($upload_dir);
    my @finished = $utils->get_files_to_process($finished_dir);

    foreach my $file (@name) {
        chmod 0777, ($file);

        #triple HHH (triple sure)
        `dos2unix $file`;
        qx{dos2unix $file};

        my $tname = basename($file);
        $self->{table_name} = $tname;
        my $ok = 0;
        if($self->update_custom_reports($tname)) {
            my $def = $self->get_table_def($tname);
            eval {
                $self->create_table($def);
                $ok = 1;
            };
            if($@) {
                $self->{_log}->error($@);
            }
        }
        if($ok) {
            my $csv = Parse::CSV->new(
                file  => $file,
                names => 1,
            );
            #magic
            $csv->{csv_xs}->{detect_bom} = 1;
            my $i =0;
            while(my $row = $csv->fetch) {
                eval{
                    $self->check_and_insert_report($row,$tname);
                    $i++;
                };
                if($@) {
                    $self->{_log}->error($@);
                }
            }
            $self->{_log}->info("Inserted $i records into table '$tname'");
        }
        my $new_path = "$finished_dir"."/". basename($file);

        eval {
            make_path($finished_dir, { chmod => 0744, }) unless (-d $finished_dir);
            move($file, $new_path );
            $self->{_log}->info("File moved successfully new path '$new_path'");
        };

        if($@) {
            $self->{_log}->error("File move error".$@);
        }

    }
    return;
}

sub check_and_insert_report {
    my ($self,$data,$table) = (@_);
    my $dt = DateTime::Format::Flexible->parse_datetime($data->{x});
    $data->{x} = DateTime::Format::MySQL->format_datetime($dt);
    my $res = 0;
    my ($stmt, @bind) = $self->{_sql}->insert($table,$data);;
    my $sth = $self->{_db}->prepare($stmt);

    eval {
        $sth->execute(@bind);
        $res = 1;
    };

    if ($@) {
        $self->{_log}->error($@);
    }

    return $res;
}

sub create_table{
    my ($self,$def) = (@_);
    return $self->{_db}->do($def);
}

sub get_table_def {
    my ($self , $name) = (@_);
return <<SQL;
create table if not exists $name (
  y mediumtext not null,
  x timestamp
) engine=innodb
default charset=utf8
collate=utf8_general_ci;
SQL

}

sub update_custom_reports {
    my ($self, $name) = (@_);
    my $res = 0;
    my ($stmt, @bind) = $self->{_sql}->insert('custom_reports',{ name => $name } );
    $self->{_log}->info("custom_reports '$name' being inserted into the record");
    my $sth = $self->{_db}->prepare($stmt);

    eval {
        $sth->execute(@bind);
        $res = 1;
    };

    if ($@) {
        $self->{_log}->error($@);
    }

    return $res;

}


sub get_custom_reports {

    my $ary_ref = shift->{_db}->selectcol_arrayref("select id, name from custom_reports", { Columns=>[1,2] });
    my %hash = @$ary_ref;
    return \%hash

}

sub get_custom_report_count {
    return { 'count' => (shift->{_db}->selectrow_array("select count(*) from custom_reports"))[0] || '' };
}


sub get_trend_data {
    my ( $self,$table ) = (@_);
    my $res  = {};
    my $query = {
        'year'  => 'select year(x) as x,sum(y) as y from '.$table.' group by  year(x)',
        'month' => 'select month(x) as x,sum(y) as y from '.$table.' group by month(x)',
        'week'  => 'select week(x) as x,sum(y) as y from '.$table.' group by week(x)',
        'day'   => 'select day(x) as x,sum(y) as y from '.$table.' group by day(x)',
        'time_stamp' => 'select x,y from '.$table,
    };

    foreach my $data (keys %$query) {
        my $sth = $self->{_db}->prepare($query->{$data});
        $sth->execute() || $self->{_util}->log_db_error($self->{_db}->errstr());
        $res->{$data} = $sth->fetchall_arrayref({});
    }

    return $res;
}

1;

=pod

create table if not exists developer_dashboard.custom_reports (
    id int not null auto_increment,
    name varchar(20) not null unique,
    created timestamp default now() not null,
    primary key (id)
)
engine=innodb
default charset=utf8
collate=utf8_general_ci;
create unique index custom_reports_id_idx using btree on developer_dashboard.custom_reports (id,name);