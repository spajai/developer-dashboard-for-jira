package Report;

use strict;
use warnings;

use File::FindLib 'lib';
use Cwd qw(abs_path cwd);
use File::Find;
use File::Copy;
use File::Basename;
use File::Path qw(make_path);
use SQL::Abstract;

use Core;
use Conf;

sub new {
    my $class = shift;
    my $conf  = Conf->new();
    my $self  = {
        _log  => Core->new->dashboard_logger,
        _db   => DB->new->connect_db(),
        _up   => $conf->{upload_dir},
        _fin  => $conf->{finished_dir},
        _sql  => SQL::Abstract->new,
    };
    return bless($self, $class);
}

sub get_files_to_process {
    my $self = shift;
    my $dir = shift || $self->{_up};
    opendir(DIR, $dir) or $self->{_log}->logconfess($!);
    my @file_name;
    while (my $file = readdir(DIR)) {
        my $loc = "$dir/$file";
        next unless (-f $loc);
        push(@file_name, $loc);
    }
    return @file_name;
}

sub generate_unique_name {
    my ($self) = @_;
    my $rand = join('', map { ('a' .. 'z')[ rand(26) ] } 1 .. 7);
    return $self->{file_unique} = "uploaded_" . $rand . ".csv";
}

sub rename_file {
    my ($self, $old_name) = @_;
    my $log = $self->{_log};
    $log->logconfess("old name not present") unless (-f $old_name);
    $self->generate_unique_name() unless (exists $self->{file_unique});
    $self->{new_file} = dirname($old_name) . '/' . $self->{file_unique};

    # rename($old_name, $self->{new_file}) or( $log->fatal("error occured while file rename : $!") and die "$!");
    rename($old_name, $self->{new_file}) or $log->logconfess("error occured while file rename : $!");
    $log->info("$old_name has been renamed to $self->{new_file}");
    return $self->{new_file};
}

sub update_report_processor {
    my ($self, $status) = @_;
    my $db          = $self->{_db};
    my $upload_path = $self->{_up};
    my $finish_path = $self->{_fin} || $self->{_up} . '/finished';
    my $log         = $self->{_log};
    my $sql         = $self->{_sql};
    my $data        = {
        report_name => basename($self->{new_file}),
        path        => $self->{new_file},
        status      => lc($status),
    };
    my ($stmt, @bind);

    if ($status eq 'finished') {
        if ($self->{report_id}) {
            if ($data->{path}) {
                my $new_path = "$finish_path/" . basename($data->{path});
                eval {
                    make_path($finish_path, { chmod => 0744, }) unless (-d $finish_path);
                    move($data->{path}, $new_path);
                    $data->{path} = $new_path;
                    $log->info("File moved successfully new path '$new_path'");
                };
                if ($@) {
                    $log->fatal("System error while moving file $@");
                }
            }
            $log->info("Report procesessor id '$self->{report_id}' being updated to Finished");
            ($stmt, @bind) = $sql->update('report_processor', $data, { id => $self->{report_id} });
        }
    } else {
        ($stmt, @bind) = $sql->insert('report_processor', $data);
        $log->info("Report procesessor being inserted for '$self->{new_file}'");
    }

    my $sth = $db->prepare($stmt);
    eval {
        $sth->execute(@bind);
        $self->{report_id} = $sth->{'mysql_insertid'} || undef;
        $log->info("Report ID generated '$self->{report_id}'") if ($self->{report_id});
    };
    if ($@) {
        $log->fatal("Unable to process report $@");
        $log->error("Unable to process report $@");
        return 0;
    }
    $log->info("Report '$self->{report_id}' has been procesesed sucessfully") if ($self->{report_id});
    return 1;
}

sub get_inserted_id {
    return shift->{report_id} || undef;
}

sub last_report {
    return { 'lastmodified' =>
          (shift->{_db}->selectrow_array("select max(last_modfied) from report_processor where status = 'finished'"))[0] || '' };
}

sub report_status {
    return { 'status' =>
          (shift->{_db}->selectrow_array("select upper(status) from report_processor where id = ?", undef, shift))[0] || undef };
}

1;

