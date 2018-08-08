package #
Date::Manip::TZ::asanad00;
# Copyright (c) 2008-2018 Sullivan Beck.  All rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

# This file was automatically generated.  Any changes to this file will
# be lost the next time 'tzdata' is run.
#    Generated on: Wed May 30 14:49:32 EDT 2018
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
        [ [1,1,2,0,0,0],[1,1,2,11,49,56],'+11:49:56',[11,49,56],
          'LMT',0,[1924,5,1,12,10,3],[1924,5,1,23,59,59],
          '0001010200:00:00','0001010211:49:56','1924050112:10:03','1924050123:59:59' ],
     ],
   1924 =>
     [
        [ [1924,5,1,12,10,4],[1924,5,2,0,10,4],'+12:00:00',[12,0,0],
          '+12',0,[1930,6,20,11,59,59],[1930,6,20,23,59,59],
          '1924050112:10:04','1924050200:10:04','1930062011:59:59','1930062023:59:59' ],
     ],
   1930 =>
     [
        [ [1930,6,20,12,0,0],[1930,6,21,1,0,0],'+13:00:00',[13,0,0],
          '+13',0,[1981,3,31,10,59,59],[1981,3,31,23,59,59],
          '1930062012:00:00','1930062101:00:00','1981033110:59:59','1981033123:59:59' ],
     ],
   1981 =>
     [
        [ [1981,3,31,11,0,0],[1981,4,1,1,0,0],'+14:00:00',[14,0,0],
          '+14',1,[1981,9,30,9,59,59],[1981,9,30,23,59,59],
          '1981033111:00:00','1981040101:00:00','1981093009:59:59','1981093023:59:59' ],
        [ [1981,9,30,10,0,0],[1981,9,30,23,0,0],'+13:00:00',[13,0,0],
          '+13',0,[1982,3,31,10,59,59],[1982,3,31,23,59,59],
          '1981093010:00:00','1981093023:00:00','1982033110:59:59','1982033123:59:59' ],
     ],
   1982 =>
     [
        [ [1982,3,31,11,0,0],[1982,4,1,0,0,0],'+13:00:00',[13,0,0],
          '+13',1,[1982,9,30,10,59,59],[1982,9,30,23,59,59],
          '1982033111:00:00','1982040100:00:00','1982093010:59:59','1982093023:59:59' ],
        [ [1982,9,30,11,0,0],[1982,9,30,23,0,0],'+12:00:00',[12,0,0],
          '+12',0,[1983,3,31,11,59,59],[1983,3,31,23,59,59],
          '1982093011:00:00','1982093023:00:00','1983033111:59:59','1983033123:59:59' ],
     ],
   1983 =>
     [
        [ [1983,3,31,12,0,0],[1983,4,1,1,0,0],'+13:00:00',[13,0,0],
          '+13',1,[1983,9,30,10,59,59],[1983,9,30,23,59,59],
          '1983033112:00:00','1983040101:00:00','1983093010:59:59','1983093023:59:59' ],
        [ [1983,9,30,11,0,0],[1983,9,30,23,0,0],'+12:00:00',[12,0,0],
          '+12',0,[1984,3,31,11,59,59],[1984,3,31,23,59,59],
          '1983093011:00:00','1983093023:00:00','1984033111:59:59','1984033123:59:59' ],
     ],
   1984 =>
     [
        [ [1984,3,31,12,0,0],[1984,4,1,1,0,0],'+13:00:00',[13,0,0],
          '+13',1,[1984,9,29,13,59,59],[1984,9,30,2,59,59],
          '1984033112:00:00','1984040101:00:00','1984092913:59:59','1984093002:59:59' ],
        [ [1984,9,29,14,0,0],[1984,9,30,2,0,0],'+12:00:00',[12,0,0],
          '+12',0,[1985,3,30,13,59,59],[1985,3,31,1,59,59],
          '1984092914:00:00','1984093002:00:00','1985033013:59:59','1985033101:59:59' ],
     ],
   1985 =>
     [
        [ [1985,3,30,14,0,0],[1985,3,31,3,0,0],'+13:00:00',[13,0,0],
          '+13',1,[1985,9,28,13,59,59],[1985,9,29,2,59,59],
          '1985033014:00:00','1985033103:00:00','1985092813:59:59','1985092902:59:59' ],
        [ [1985,9,28,14,0,0],[1985,9,29,2,0,0],'+12:00:00',[12,0,0],
          '+12',0,[1986,3,29,13,59,59],[1986,3,30,1,59,59],
          '1985092814:00:00','1985092902:00:00','1986032913:59:59','1986033001:59:59' ],
     ],
   1986 =>
     [
        [ [1986,3,29,14,0,0],[1986,3,30,3,0,0],'+13:00:00',[13,0,0],
          '+13',1,[1986,9,27,13,59,59],[1986,9,28,2,59,59],
          '1986032914:00:00','1986033003:00:00','1986092713:59:59','1986092802:59:59' ],
        [ [1986,9,27,14,0,0],[1986,9,28,2,0,0],'+12:00:00',[12,0,0],
          '+12',0,[1987,3,28,13,59,59],[1987,3,29,1,59,59],
          '1986092714:00:00','1986092802:00:00','1987032813:59:59','1987032901:59:59' ],
     ],
   1987 =>
     [
        [ [1987,3,28,14,0,0],[1987,3,29,3,0,0],'+13:00:00',[13,0,0],
          '+13',1,[1987,9,26,13,59,59],[1987,9,27,2,59,59],
          '1987032814:00:00','1987032903:00:00','1987092613:59:59','1987092702:59:59' ],
        [ [1987,9,26,14,0,0],[1987,9,27,2,0,0],'+12:00:00',[12,0,0],
          '+12',0,[1988,3,26,13,59,59],[1988,3,27,1,59,59],
          '1987092614:00:00','1987092702:00:00','1988032613:59:59','1988032701:59:59' ],
     ],
   1988 =>
     [
        [ [1988,3,26,14,0,0],[1988,3,27,3,0,0],'+13:00:00',[13,0,0],
          '+13',1,[1988,9,24,13,59,59],[1988,9,25,2,59,59],
          '1988032614:00:00','1988032703:00:00','1988092413:59:59','1988092502:59:59' ],
        [ [1988,9,24,14,0,0],[1988,9,25,2,0,0],'+12:00:00',[12,0,0],
          '+12',0,[1989,3,25,13,59,59],[1989,3,26,1,59,59],
          '1988092414:00:00','1988092502:00:00','1989032513:59:59','1989032601:59:59' ],
     ],
   1989 =>
     [
        [ [1989,3,25,14,0,0],[1989,3,26,3,0,0],'+13:00:00',[13,0,0],
          '+13',1,[1989,9,23,13,59,59],[1989,9,24,2,59,59],
          '1989032514:00:00','1989032603:00:00','1989092313:59:59','1989092402:59:59' ],
        [ [1989,9,23,14,0,0],[1989,9,24,2,0,0],'+12:00:00',[12,0,0],
          '+12',0,[1990,3,24,13,59,59],[1990,3,25,1,59,59],
          '1989092314:00:00','1989092402:00:00','1990032413:59:59','1990032501:59:59' ],
     ],
   1990 =>
     [
        [ [1990,3,24,14,0,0],[1990,3,25,3,0,0],'+13:00:00',[13,0,0],
          '+13',1,[1990,9,29,13,59,59],[1990,9,30,2,59,59],
          '1990032414:00:00','1990032503:00:00','1990092913:59:59','1990093002:59:59' ],
        [ [1990,9,29,14,0,0],[1990,9,30,2,0,0],'+12:00:00',[12,0,0],
          '+12',0,[1991,3,30,13,59,59],[1991,3,31,1,59,59],
          '1990092914:00:00','1990093002:00:00','1991033013:59:59','1991033101:59:59' ],
     ],
   1991 =>
     [
        [ [1991,3,30,14,0,0],[1991,3,31,2,0,0],'+12:00:00',[12,0,0],
          '+12',1,[1991,9,28,14,59,59],[1991,9,29,2,59,59],
          '1991033014:00:00','1991033102:00:00','1991092814:59:59','1991092902:59:59' ],
        [ [1991,9,28,15,0,0],[1991,9,29,2,0,0],'+11:00:00',[11,0,0],
          '+11',0,[1992,1,18,14,59,59],[1992,1,19,1,59,59],
          '1991092815:00:00','1991092902:00:00','1992011814:59:59','1992011901:59:59' ],
     ],
   1992 =>
     [
        [ [1992,1,18,15,0,0],[1992,1,19,3,0,0],'+12:00:00',[12,0,0],
          '+12',0,[1992,3,28,13,59,59],[1992,3,29,1,59,59],
          '1992011815:00:00','1992011903:00:00','1992032813:59:59','1992032901:59:59' ],
        [ [1992,3,28,14,0,0],[1992,3,29,3,0,0],'+13:00:00',[13,0,0],
          '+13',1,[1992,9,26,13,59,59],[1992,9,27,2,59,59],
          '1992032814:00:00','1992032903:00:00','1992092613:59:59','1992092702:59:59' ],
        [ [1992,9,26,14,0,0],[1992,9,27,2,0,0],'+12:00:00',[12,0,0],
          '+12',0,[1993,3,27,13,59,59],[1993,3,28,1,59,59],
          '1992092614:00:00','1992092702:00:00','1993032713:59:59','1993032801:59:59' ],
     ],
   1993 =>
     [
        [ [1993,3,27,14,0,0],[1993,3,28,3,0,0],'+13:00:00',[13,0,0],
          '+13',1,[1993,9,25,13,59,59],[1993,9,26,2,59,59],
          '1993032714:00:00','1993032803:00:00','1993092513:59:59','1993092602:59:59' ],
        [ [1993,9,25,14,0,0],[1993,9,26,2,0,0],'+12:00:00',[12,0,0],
          '+12',0,[1994,3,26,13,59,59],[1994,3,27,1,59,59],
          '1993092514:00:00','1993092602:00:00','1994032613:59:59','1994032701:59:59' ],
     ],
   1994 =>
     [
        [ [1994,3,26,14,0,0],[1994,3,27,3,0,0],'+13:00:00',[13,0,0],
          '+13',1,[1994,9,24,13,59,59],[1994,9,25,2,59,59],
          '1994032614:00:00','1994032703:00:00','1994092413:59:59','1994092502:59:59' ],
        [ [1994,9,24,14,0,0],[1994,9,25,2,0,0],'+12:00:00',[12,0,0],
          '+12',0,[1995,3,25,13,59,59],[1995,3,26,1,59,59],
          '1994092414:00:00','1994092502:00:00','1995032513:59:59','1995032601:59:59' ],
     ],
   1995 =>
     [
        [ [1995,3,25,14,0,0],[1995,3,26,3,0,0],'+13:00:00',[13,0,0],
          '+13',1,[1995,9,23,13,59,59],[1995,9,24,2,59,59],
          '1995032514:00:00','1995032603:00:00','1995092313:59:59','1995092402:59:59' ],
        [ [1995,9,23,14,0,0],[1995,9,24,2,0,0],'+12:00:00',[12,0,0],
          '+12',0,[1996,3,30,13,59,59],[1996,3,31,1,59,59],
          '1995092314:00:00','1995092402:00:00','1996033013:59:59','1996033101:59:59' ],
     ],
   1996 =>
     [
        [ [1996,3,30,14,0,0],[1996,3,31,3,0,0],'+13:00:00',[13,0,0],
          '+13',1,[1996,10,26,13,59,59],[1996,10,27,2,59,59],
          '1996033014:00:00','1996033103:00:00','1996102613:59:59','1996102702:59:59' ],
        [ [1996,10,26,14,0,0],[1996,10,27,2,0,0],'+12:00:00',[12,0,0],
          '+12',0,[1997,3,29,13,59,59],[1997,3,30,1,59,59],
          '1996102614:00:00','1996102702:00:00','1997032913:59:59','1997033001:59:59' ],
     ],
   1997 =>
     [
        [ [1997,3,29,14,0,0],[1997,3,30,3,0,0],'+13:00:00',[13,0,0],
          '+13',1,[1997,10,25,13,59,59],[1997,10,26,2,59,59],
          '1997032914:00:00','1997033003:00:00','1997102513:59:59','1997102602:59:59' ],
        [ [1997,10,25,14,0,0],[1997,10,26,2,0,0],'+12:00:00',[12,0,0],
          '+12',0,[1998,3,28,13,59,59],[1998,3,29,1,59,59],
          '1997102514:00:00','1997102602:00:00','1998032813:59:59','1998032901:59:59' ],
     ],
   1998 =>
     [
        [ [1998,3,28,14,0,0],[1998,3,29,3,0,0],'+13:00:00',[13,0,0],
          '+13',1,[1998,10,24,13,59,59],[1998,10,25,2,59,59],
          '1998032814:00:00','1998032903:00:00','1998102413:59:59','1998102502:59:59' ],
        [ [1998,10,24,14,0,0],[1998,10,25,2,0,0],'+12:00:00',[12,0,0],
          '+12',0,[1999,3,27,13,59,59],[1999,3,28,1,59,59],
          '1998102414:00:00','1998102502:00:00','1999032713:59:59','1999032801:59:59' ],
     ],
   1999 =>
     [
        [ [1999,3,27,14,0,0],[1999,3,28,3,0,0],'+13:00:00',[13,0,0],
          '+13',1,[1999,10,30,13,59,59],[1999,10,31,2,59,59],
          '1999032714:00:00','1999032803:00:00','1999103013:59:59','1999103102:59:59' ],
        [ [1999,10,30,14,0,0],[1999,10,31,2,0,0],'+12:00:00',[12,0,0],
          '+12',0,[2000,3,25,13,59,59],[2000,3,26,1,59,59],
          '1999103014:00:00','1999103102:00:00','2000032513:59:59','2000032601:59:59' ],
     ],
   2000 =>
     [
        [ [2000,3,25,14,0,0],[2000,3,26,3,0,0],'+13:00:00',[13,0,0],
          '+13',1,[2000,10,28,13,59,59],[2000,10,29,2,59,59],
          '2000032514:00:00','2000032603:00:00','2000102813:59:59','2000102902:59:59' ],
        [ [2000,10,28,14,0,0],[2000,10,29,2,0,0],'+12:00:00',[12,0,0],
          '+12',0,[2001,3,24,13,59,59],[2001,3,25,1,59,59],
          '2000102814:00:00','2000102902:00:00','2001032413:59:59','2001032501:59:59' ],
     ],
   2001 =>
     [
        [ [2001,3,24,14,0,0],[2001,3,25,3,0,0],'+13:00:00',[13,0,0],
          '+13',1,[2001,10,27,13,59,59],[2001,10,28,2,59,59],
          '2001032414:00:00','2001032503:00:00','2001102713:59:59','2001102802:59:59' ],
        [ [2001,10,27,14,0,0],[2001,10,28,2,0,0],'+12:00:00',[12,0,0],
          '+12',0,[2002,3,30,13,59,59],[2002,3,31,1,59,59],
          '2001102714:00:00','2001102802:00:00','2002033013:59:59','2002033101:59:59' ],
     ],
   2002 =>
     [
        [ [2002,3,30,14,0,0],[2002,3,31,3,0,0],'+13:00:00',[13,0,0],
          '+13',1,[2002,10,26,13,59,59],[2002,10,27,2,59,59],
          '2002033014:00:00','2002033103:00:00','2002102613:59:59','2002102702:59:59' ],
        [ [2002,10,26,14,0,0],[2002,10,27,2,0,0],'+12:00:00',[12,0,0],
          '+12',0,[2003,3,29,13,59,59],[2003,3,30,1,59,59],
          '2002102614:00:00','2002102702:00:00','2003032913:59:59','2003033001:59:59' ],
     ],
   2003 =>
     [
        [ [2003,3,29,14,0,0],[2003,3,30,3,0,0],'+13:00:00',[13,0,0],
          '+13',1,[2003,10,25,13,59,59],[2003,10,26,2,59,59],
          '2003032914:00:00','2003033003:00:00','2003102513:59:59','2003102602:59:59' ],
        [ [2003,10,25,14,0,0],[2003,10,26,2,0,0],'+12:00:00',[12,0,0],
          '+12',0,[2004,3,27,13,59,59],[2004,3,28,1,59,59],
          '2003102514:00:00','2003102602:00:00','2004032713:59:59','2004032801:59:59' ],
     ],
   2004 =>
     [
        [ [2004,3,27,14,0,0],[2004,3,28,3,0,0],'+13:00:00',[13,0,0],
          '+13',1,[2004,10,30,13,59,59],[2004,10,31,2,59,59],
          '2004032714:00:00','2004032803:00:00','2004103013:59:59','2004103102:59:59' ],
        [ [2004,10,30,14,0,0],[2004,10,31,2,0,0],'+12:00:00',[12,0,0],
          '+12',0,[2005,3,26,13,59,59],[2005,3,27,1,59,59],
          '2004103014:00:00','2004103102:00:00','2005032613:59:59','2005032701:59:59' ],
     ],
   2005 =>
     [
        [ [2005,3,26,14,0,0],[2005,3,27,3,0,0],'+13:00:00',[13,0,0],
          '+13',1,[2005,10,29,13,59,59],[2005,10,30,2,59,59],
          '2005032614:00:00','2005032703:00:00','2005102913:59:59','2005103002:59:59' ],
        [ [2005,10,29,14,0,0],[2005,10,30,2,0,0],'+12:00:00',[12,0,0],
          '+12',0,[2006,3,25,13,59,59],[2006,3,26,1,59,59],
          '2005102914:00:00','2005103002:00:00','2006032513:59:59','2006032601:59:59' ],
     ],
   2006 =>
     [
        [ [2006,3,25,14,0,0],[2006,3,26,3,0,0],'+13:00:00',[13,0,0],
          '+13',1,[2006,10,28,13,59,59],[2006,10,29,2,59,59],
          '2006032514:00:00','2006032603:00:00','2006102813:59:59','2006102902:59:59' ],
        [ [2006,10,28,14,0,0],[2006,10,29,2,0,0],'+12:00:00',[12,0,0],
          '+12',0,[2007,3,24,13,59,59],[2007,3,25,1,59,59],
          '2006102814:00:00','2006102902:00:00','2007032413:59:59','2007032501:59:59' ],
     ],
   2007 =>
     [
        [ [2007,3,24,14,0,0],[2007,3,25,3,0,0],'+13:00:00',[13,0,0],
          '+13',1,[2007,10,27,13,59,59],[2007,10,28,2,59,59],
          '2007032414:00:00','2007032503:00:00','2007102713:59:59','2007102802:59:59' ],
        [ [2007,10,27,14,0,0],[2007,10,28,2,0,0],'+12:00:00',[12,0,0],
          '+12',0,[2008,3,29,13,59,59],[2008,3,30,1,59,59],
          '2007102714:00:00','2007102802:00:00','2008032913:59:59','2008033001:59:59' ],
     ],
   2008 =>
     [
        [ [2008,3,29,14,0,0],[2008,3,30,3,0,0],'+13:00:00',[13,0,0],
          '+13',1,[2008,10,25,13,59,59],[2008,10,26,2,59,59],
          '2008032914:00:00','2008033003:00:00','2008102513:59:59','2008102602:59:59' ],
        [ [2008,10,25,14,0,0],[2008,10,26,2,0,0],'+12:00:00',[12,0,0],
          '+12',0,[2009,3,28,13,59,59],[2009,3,29,1,59,59],
          '2008102514:00:00','2008102602:00:00','2009032813:59:59','2009032901:59:59' ],
     ],
   2009 =>
     [
        [ [2009,3,28,14,0,0],[2009,3,29,3,0,0],'+13:00:00',[13,0,0],
          '+13',1,[2009,10,24,13,59,59],[2009,10,25,2,59,59],
          '2009032814:00:00','2009032903:00:00','2009102413:59:59','2009102502:59:59' ],
        [ [2009,10,24,14,0,0],[2009,10,25,2,0,0],'+12:00:00',[12,0,0],
          '+12',0,[2010,3,27,13,59,59],[2010,3,28,1,59,59],
          '2009102414:00:00','2009102502:00:00','2010032713:59:59','2010032801:59:59' ],
     ],
   2010 =>
     [
        [ [2010,3,27,14,0,0],[2010,3,28,2,0,0],'+12:00:00',[12,0,0],
          '+12',1,[2010,10,30,14,59,59],[2010,10,31,2,59,59],
          '2010032714:00:00','2010032802:00:00','2010103014:59:59','2010103102:59:59' ],
        [ [2010,10,30,15,0,0],[2010,10,31,2,0,0],'+11:00:00',[11,0,0],
          '+11',0,[2011,3,26,14,59,59],[2011,3,27,1,59,59],
          '2010103015:00:00','2010103102:00:00','2011032614:59:59','2011032701:59:59' ],
     ],
   2011 =>
     [
        [ [2011,3,26,15,0,0],[2011,3,27,3,0,0],'+12:00:00',[12,0,0],
          '+12',0,[9999,12,31,0,0,0],[9999,12,31,12,0,0],
          '2011032615:00:00','2011032703:00:00','9999123100:00:00','9999123112:00:00' ],
     ],
);

%LastRule      = (
);

1;
