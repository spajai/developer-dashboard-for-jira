package Run;

use strict;
use warnings;
use File::FindLib 'lib';

use SQL::Abstract;
use Core;
use Conf;
use Utils;
use Report::Csv;
use Report;

sub new {
    bless({}, shift);
}

sub process_report {
    my ($self) = @_;

    my $conf         = Conf->new();
    my $log          = Core->new->dashboard_logger;
    my $db           = DB->new->connect_db();
    my $upload_dir   = $conf->{upload_dir};
    my $finished_dir = $conf->{finished_dir};
    my $max          = $conf->{reports_cleanup_threshold};
    my $utils        = Utils->new();
    my $sql          = SQL::Abstract->new;

    my @name     = $utils->get_files_to_process($upload_dir);
    my @finished = $utils->get_files_to_process($finished_dir);

    foreach my $file (@name) {
        my $rep = Report->new();
        my $res = chmod 0777, ($file);
        $file = $rep->rename_file($file);
        $rep->update_report_processor('processing');
        my $id = $rep->get_inserted_id();    #return
        $log->info("Report id '$id' generated for file '$file'");
        my $csv = Report::Csv->new($file);
        $csv->process_csv_rows();
        $rep->update_report_processor('finished');
    }

    #Clean up old reports
    if (scalar @finished > $max) {
        foreach (@finished) {
            my ($stmt, @bind) =
              $sql->update('report_processor', { 'deleted' => 1 }, { report_name => basename($_), 'path' => $_ });
            my $sth = $db->prepare($stmt);
            eval {
                unlink($_);
                $sth->execute(@bind);
                $log->info("Report file '$_' has been deleted successfully & updated in DB");
            };
            if ($@) {
                $utils->log_db_error($@);
                $utils->log_db_error($db->errstr());
            }
        }
    }

    return 1;
}

1;
