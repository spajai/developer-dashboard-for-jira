use strict;
use warnings;
use Data::Dumper;

use File::FindLib 'lib';
use File::FindLib 'cpanlib';

use Run;

my $run = Run->new();
print Dumper $run->process_report();