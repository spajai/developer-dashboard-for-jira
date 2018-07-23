 use File::FindLib 'lib'; use Core;
 use Report::Data;
 
 my $r = Report::Data->new();
 
 $r->get_data_for_graph();
 
 
 
# print  Core->new->get_report_logger_conf('dashboard_logger_name');

