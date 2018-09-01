use strict;
use warnings;
use File::FindLib 'lib';
use File::FindLib 'cpanlib';
use Report::Data;
use Data::Dumper;
use JSON;
my $r = Report::Data->new();

# print Dumper $r->get_ticket_meta();
print encode_json( $r->get_trend_data());
# print  $r->get_trend_data();
