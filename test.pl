use strict;
use warnings;
use Data::Dumper;

use File::FindLib 'lib';
use File::FindLib 'cpanlib';

use Custom::Report;
use JSON;

my $run = Custom::Report->new();
#print Dumper $run->process_custom_report();

my $result = decode_json($run->get_trend_data('report_wptc'));
#delete $result->{time_stamp};

print encode_json($result->{time_stamp});
