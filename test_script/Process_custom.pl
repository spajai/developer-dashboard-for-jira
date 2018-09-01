use strict;
use warnings;
use Data::Dumper;

use File::FindLib 'lib';
use File::FindLib 'cpanlib';

use Custom::Report;

my $run = Custom::Report->new();
print Dumper $run->process_custom_report();
# my $reports =  $run->get_custom_reports('report_rrcz');
# foreach(keys %$reports) {

# print Dumper $run->get_custom_report_count($reports->{$_});
# print Dumper $run->get_trend_data($reports->{$_});
    

# }
