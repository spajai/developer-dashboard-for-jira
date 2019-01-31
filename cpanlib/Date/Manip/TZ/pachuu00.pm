package #
Date::Manip::TZ::pachuu00;
# Copyright (c) 2008-2018 Sullivan Beck.  All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

# This file was automatically generated.  Any changes to this file will
# be lost the next time 'tzdata' is run.
#    Generated on: Wed May 30 14:49:44 EDT 2018
#    Data version: tzdata2018e
#    Code version: tzcode2018e

# This module contains data from the zoneinfo time zone database.  The original
# data was obtained from the URL:
#    ftp://ftp.iana.org/tz

use strict;
use warnings;
require 5.010000;

our (%Dates,%LastRule);
END {
   undef %Dates;
   undef %LastRule;
}

our ($VERSION);
$VERSION='6.72';
END { undef $VERSION; }

%Dates         = (
   1    =>
     [
        [ [1,1,2,0,0,0],[1,1,2,10,7,8],'+10:07:08',[10,7,8],
          'LMT',0,[1900,12,31,13,52,51],[1900,12,31,23,59,59],
          '0001010200:00:00','0001010210:07:08','1900123113:52:51','1900123123:59:59' ],
     ],
   1900 =>
     [
        [ [1900,12,31,13,52,52],[1900,12,31,23,52,52],'+10:00:00',[10,0,0],
          '+10',0,[9999,12,31,0,0,0],[9999,12,31,10,0,0],
          '1900123113:52:52','1900123123:52:52','9999123100:00:00','9999123110:00:00' ],
     ],
);

%LastRule      = (
);

1;
