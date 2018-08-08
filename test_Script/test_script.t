
use strict;
use warnings;
use lib '/developer_dashboard/lib';
use lib '/developer_dashboard/cpanlib';
use File::FindLib 'lib';

use Data::Dumper;

use Core;
use DB;
use Conf;
use Utils;
use JSON;

my $util = Utils->new();
# my @res = $util->get_users();
# print Dumper encode_json \@res;
print Dumper $util->get_ticket_query();
