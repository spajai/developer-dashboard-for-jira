package #
Date::Manip::TZ::ammont02;
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
        [ [1,1,2,0,0,0],[1,1,1,20,15,9],'-03:44:51',[-3,-44,-51],
          'LMT',0,[1908,6,10,3,44,50],[1908,6,9,23,59,59],
          '0001010200:00:00','0001010120:15:09','1908061003:44:50','1908060923:59:59' ],
     ],
   1908 =>
     [
        [ [1908,6,10,3,44,51],[1908,6,10,0,0,0],'-03:44:51',[-3,-44,-51],
          'MMT',0,[1920,5,1,3,44,50],[1920,4,30,23,59,59],
          '1908061003:44:51','1908061000:00:00','1920050103:44:50','1920043023:59:59' ],
     ],
   1920 =>
     [
        [ [1920,5,1,3,44,51],[1920,4,30,23,44,51],'-04:00:00',[-4,0,0],
          '-04',0,[1923,10,1,3,59,59],[1923,9,30,23,59,59],
          '1920050103:44:51','1920043023:44:51','1923100103:59:59','1923093023:59:59' ],
     ],
   1923 =>
     [
        [ [1923,10,1,4,0,0],[1923,10,1,1,0,0],'-03:00:00',[-3,0,0],
          '-03',1,[1924,4,1,2,59,59],[1924,3,31,23,59,59],
          '1923100104:00:00','1923100101:00:00','1924040102:59:59','1924033123:59:59' ],
     ],
   1924 =>
     [
        [ [1924,4,1,3,0,0],[1924,3,31,23,30,0],'-03:30:00',[-3,-30,0],
          '-0330',0,[1924,10,1,3,29,59],[1924,9,30,23,59,59],
          '1924040103:00:00','1924033123:30:00','1924100103:29:59','1924093023:59:59' ],
        [ [1924,10,1,3,30,0],[1924,10,1,0,30,0],'-03:00:00',[-3,0,0],
          '-03',1,[1925,4,1,2,59,59],[1925,3,31,23,59,59],
          '1924100103:30:00','1924100100:30:00','1925040102:59:59','1925033123:59:59' ],
     ],
   1925 =>
     [
        [ [1925,4,1,3,0,0],[1925,3,31,23,30,0],'-03:30:00',[-3,-30,0],
          '-0330',0,[1925,10,1,3,29,59],[1925,9,30,23,59,59],
          '1925040103:00:00','1925033123:30:00','1925100103:29:59','1925093023:59:59' ],
        [ [1925,10,1,3,30,0],[1925,10,1,0,30,0],'-03:00:00',[-3,0,0],
          '-03',1,[1926,4,1,2,59,59],[1926,3,31,23,59,59],
          '1925100103:30:00','1925100100:30:00','1926040102:59:59','1926033123:59:59' ],
     ],
   1926 =>
     [
        [ [1926,4,1,3,0,0],[1926,3,31,23,30,0],'-03:30:00',[-3,-30,0],
          '-0330',0,[1933,10,29,3,29,59],[1933,10,28,23,59,59],
          '1926040103:00:00','1926033123:30:00','1933102903:29:59','1933102823:59:59' ],
     ],
   1933 =>
     [
        [ [1933,10,29,3,30,0],[1933,10,29,0,30,0],'-03:00:00',[-3,0,0],
          '-03',1,[1934,4,1,2,59,59],[1934,3,31,23,59,59],
          '1933102903:30:00','1933102900:30:00','1934040102:59:59','1934033123:59:59' ],
     ],
   1934 =>
     [
        [ [1934,4,1,3,0,0],[1934,3,31,23,30,0],'-03:30:00',[-3,-30,0],
          '-0330',0,[1934,10,28,3,29,59],[1934,10,27,23,59,59],
          '1934040103:00:00','1934033123:30:00','1934102803:29:59','1934102723:59:59' ],
        [ [1934,10,28,3,30,0],[1934,10,28,0,30,0],'-03:00:00',[-3,0,0],
          '-03',1,[1935,3,31,2,59,59],[1935,3,30,23,59,59],
          '1934102803:30:00','1934102800:30:00','1935033102:59:59','1935033023:59:59' ],
     ],
   1935 =>
     [
        [ [1935,3,31,3,0,0],[1935,3,30,23,30,0],'-03:30:00',[-3,-30,0],
          '-0330',0,[1935,10,27,3,29,59],[1935,10,26,23,59,59],
          '1935033103:00:00','1935033023:30:00','1935102703:29:59','1935102623:59:59' ],
        [ [1935,10,27,3,30,0],[1935,10,27,0,30,0],'-03:00:00',[-3,0,0],
          '-03',1,[1936,3,29,2,59,59],[1936,3,28,23,59,59],
          '1935102703:30:00','1935102700:30:00','1936032902:59:59','1936032823:59:59' ],
     ],
   1936 =>
     [
        [ [1936,3,29,3,0,0],[1936,3,28,23,30,0],'-03:30:00',[-3,-30,0],
          '-0330',0,[1936,10,25,3,29,59],[1936,10,24,23,59,59],
          '1936032903:00:00','1936032823:30:00','1936102503:29:59','1936102423:59:59' ],
        [ [1936,10,25,3,30,0],[1936,10,25,0,30,0],'-03:00:00',[-3,0,0],
          '-03',1,[1937,3,28,2,59,59],[1937,3,27,23,59,59],
          '1936102503:30:00','1936102500:30:00','1937032802:59:59','1937032723:59:59' ],
     ],
   1937 =>
     [
        [ [1937,3,28,3,0,0],[1937,3,27,23,30,0],'-03:30:00',[-3,-30,0],
          '-0330',0,[1937,10,31,3,29,59],[1937,10,30,23,59,59],
          '1937032803:00:00','1937032723:30:00','1937103103:29:59','1937103023:59:59' ],
        [ [1937,10,31,3,30,0],[1937,10,31,0,30,0],'-03:00:00',[-3,0,0],
          '-03',1,[1938,3,27,2,59,59],[1938,3,26,23,59,59],
          '1937103103:30:00','1937103100:30:00','1938032702:59:59','1938032623:59:59' ],
     ],
   1938 =>
     [
        [ [1938,3,27,3,0,0],[1938,3,26,23,30,0],'-03:30:00',[-3,-30,0],
          '-0330',0,[1938,10,30,3,29,59],[1938,10,29,23,59,59],
          '1938032703:00:00','1938032623:30:00','1938103003:29:59','1938102923:59:59' ],
        [ [1938,10,30,3,30,0],[1938,10,30,0,30,0],'-03:00:00',[-3,0,0],
          '-03',1,[1939,3,26,2,59,59],[1939,3,25,23,59,59],
          '1938103003:30:00','1938103000:30:00','1939032602:59:59','1939032523:59:59' ],
     ],
   1939 =>
     [
        [ [1939,3,26,3,0,0],[1939,3,25,23,30,0],'-03:30:00',[-3,-30,0],
          '-0330',0,[1939,10,1,3,29,59],[1939,9,30,23,59,59],
          '1939032603:00:00','1939032523:30:00','1939100103:29:59','1939093023:59:59' ],
        [ [1939,10,1,3,30,0],[1939,10,1,0,30,0],'-03:00:00',[-3,0,0],
          '-03',1,[1940,3,31,2,59,59],[1940,3,30,23,59,59],
          '1939100103:30:00','1939100100:30:00','1940033102:59:59','1940033023:59:59' ],
     ],
   1940 =>
     [
        [ [1940,3,31,3,0,0],[1940,3,30,23,30,0],'-03:30:00',[-3,-30,0],
          '-0330',0,[1940,10,27,3,29,59],[1940,10,26,23,59,59],
          '1940033103:00:00','1940033023:30:00','1940102703:29:59','1940102623:59:59' ],
        [ [1940,10,27,3,30,0],[1940,10,27,0,30,0],'-03:00:00',[-3,0,0],
          '-03',1,[1941,3,30,2,59,59],[1941,3,29,23,59,59],
          '1940102703:30:00','1940102700:30:00','1941033002:59:59','1941032923:59:59' ],
     ],
   1941 =>
     [
        [ [1941,3,30,3,0,0],[1941,3,29,23,30,0],'-03:30:00',[-3,-30,0],
          '-0330',0,[1941,8,1,3,29,59],[1941,7,31,23,59,59],
          '1941033003:00:00','1941032923:30:00','1941080103:29:59','1941073123:59:59' ],
        [ [1941,8,1,3,30,0],[1941,8,1,0,30,0],'-03:00:00',[-3,0,0],
          '-03',1,[1942,12,14,2,59,59],[1942,12,13,23,59,59],
          '1941080103:30:00','1941080100:30:00','1942121402:59:59','1942121323:59:59' ],
     ],
   1942 =>
     [
        [ [1942,12,14,3,0,0],[1942,12,14,0,30,0],'-02:30:00',[-2,-30,0],
          '-0230',1,[1943,3,14,2,29,59],[1943,3,13,23,59,59],
          '1942121403:00:00','1942121400:30:00','1943031402:29:59','1943031323:59:59' ],
     ],
   1943 =>
     [
        [ [1943,3,14,2,30,0],[1943,3,13,23,30,0],'-03:00:00',[-3,0,0],
          '-03',0,[1959,5,24,2,59,59],[1959,5,23,23,59,59],
          '1943031402:30:00','1943031323:30:00','1959052402:59:59','1959052323:59:59' ],
     ],
   1959 =>
     [
        [ [1959,5,24,3,0,0],[1959,5,24,0,30,0],'-02:30:00',[-2,-30,0],
          '-0230',1,[1959,11,15,2,29,59],[1959,11,14,23,59,59],
          '1959052403:00:00','1959052400:30:00','1959111502:29:59','1959111423:59:59' ],
        [ [1959,11,15,2,30,0],[1959,11,14,23,30,0],'-03:00:00',[-3,0,0],
          '-03',0,[1960,1,17,2,59,59],[1960,1,16,23,59,59],
          '1959111502:30:00','1959111423:30:00','1960011702:59:59','1960011623:59:59' ],
     ],
   1960 =>
     [
        [ [1960,1,17,3,0,0],[1960,1,17,1,0,0],'-02:00:00',[-2,0,0],
          '-02',1,[1960,3,6,1,59,59],[1960,3,5,23,59,59],
          '1960011703:00:00','1960011701:00:00','1960030601:59:59','1960030523:59:59' ],
        [ [1960,3,6,2,0,0],[1960,3,5,23,0,0],'-03:00:00',[-3,0,0],
          '-03',0,[1965,4,4,2,59,59],[1965,4,3,23,59,59],
          '1960030602:00:00','1960030523:00:00','1965040402:59:59','1965040323:59:59' ],
     ],
   1965 =>
     [
        [ [1965,4,4,3,0,0],[1965,4,4,1,0,0],'-02:00:00',[-2,0,0],
          '-02',1,[1965,9,26,1,59,59],[1965,9,25,23,59,59],
          '1965040403:00:00','1965040401:00:00','1965092601:59:59','1965092523:59:59' ],
        [ [1965,9,26,2,0,0],[1965,9,25,23,0,0],'-03:00:00',[-3,0,0],
          '-03',0,[1968,5,27,2,59,59],[1968,5,26,23,59,59],
          '1965092602:00:00','1965092523:00:00','1968052702:59:59','1968052623:59:59' ],
     ],
   1968 =>
     [
        [ [1968,5,27,3,0,0],[1968,5,27,0,30,0],'-02:30:00',[-2,-30,0],
          '-0230',1,[1968,12,1,2,29,59],[1968,11,30,23,59,59],
          '1968052703:00:00','1968052700:30:00','1968120102:29:59','1968113023:59:59' ],
        [ [1968,12,1,2,30,0],[1968,11,30,23,30,0],'-03:00:00',[-3,0,0],
          '-03',0,[1970,4,25,2,59,59],[1970,4,24,23,59,59],
          '1968120102:30:00','1968113023:30:00','1970042502:59:59','1970042423:59:59' ],
     ],
   1970 =>
     [
        [ [1970,4,25,3,0,0],[1970,4,25,1,0,0],'-02:00:00',[-2,0,0],
          '-02',1,[1970,6,14,1,59,59],[1970,6,13,23,59,59],
          '1970042503:00:00','1970042501:00:00','1970061401:59:59','1970061323:59:59' ],
        [ [1970,6,14,2,0,0],[1970,6,13,23,0,0],'-03:00:00',[-3,0,0],
          '-03',0,[1972,4,23,2,59,59],[1972,4,22,23,59,59],
          '1970061402:00:00','1970061323:00:00','1972042302:59:59','1972042223:59:59' ],
     ],
   1972 =>
     [
        [ [1972,4,23,3,0,0],[1972,4,23,1,0,0],'-02:00:00',[-2,0,0],
          '-02',1,[1972,7,16,1,59,59],[1972,7,15,23,59,59],
          '1972042303:00:00','1972042301:00:00','1972071601:59:59','1972071523:59:59' ],
        [ [1972,7,16,2,0,0],[1972,7,15,23,0,0],'-03:00:00',[-3,0,0],
          '-03',0,[1974,1,13,2,59,59],[1974,1,12,23,59,59],
          '1972071602:00:00','1972071523:00:00','1974011302:59:59','1974011223:59:59' ],
     ],
   1974 =>
     [
        [ [1974,1,13,3,0,0],[1974,1,13,1,30,0],'-01:30:00',[-1,-30,0],
          '-0130',1,[1974,3,10,1,29,59],[1974,3,9,23,59,59],
          '1974011303:00:00','1974011301:30:00','1974031001:29:59','1974030923:59:59' ],
        [ [1974,3,10,1,30,0],[1974,3,9,23,0,0],'-02:30:00',[-2,-30,0],
          '-0230',1,[1974,9,1,2,29,59],[1974,8,31,23,59,59],
          '1974031001:30:00','1974030923:00:00','1974090102:29:59','1974083123:59:59' ],
        [ [1974,9,1,2,30,0],[1974,8,31,23,30,0],'-03:00:00',[-3,0,0],
          '-03',0,[1974,12,22,2,59,59],[1974,12,21,23,59,59],
          '1974090102:30:00','1974083123:30:00','1974122202:59:59','1974122123:59:59' ],
        [ [1974,12,22,3,0,0],[1974,12,22,1,0,0],'-02:00:00',[-2,0,0],
          '-02',1,[1975,3,30,1,59,59],[1975,3,29,23,59,59],
          '1974122203:00:00','1974122201:00:00','1975033001:59:59','1975032923:59:59' ],
     ],
   1975 =>
     [
        [ [1975,3,30,2,0,0],[1975,3,29,23,0,0],'-03:00:00',[-3,0,0],
          '-03',0,[1976,12,19,2,59,59],[1976,12,18,23,59,59],
          '1975033002:00:00','1975032923:00:00','1976121902:59:59','1976121823:59:59' ],
     ],
   1976 =>
     [
        [ [1976,12,19,3,0,0],[1976,12,19,1,0,0],'-02:00:00',[-2,0,0],
          '-02',1,[1977,3,6,1,59,59],[1977,3,5,23,59,59],
          '1976121903:00:00','1976121901:00:00','1977030601:59:59','1977030523:59:59' ],
     ],
   1977 =>
     [
        [ [1977,3,6,2,0,0],[1977,3,5,23,0,0],'-03:00:00',[-3,0,0],
          '-03',0,[1977,12,4,2,59,59],[1977,12,3,23,59,59],
          '1977030602:00:00','1977030523:00:00','1977120402:59:59','1977120323:59:59' ],
        [ [1977,12,4,3,0,0],[1977,12,4,1,0,0],'-02:00:00',[-2,0,0],
          '-02',1,[1978,3,5,1,59,59],[1978,3,4,23,59,59],
          '1977120403:00:00','1977120401:00:00','1978030501:59:59','1978030423:59:59' ],
     ],
   1978 =>
     [
        [ [1978,3,5,2,0,0],[1978,3,4,23,0,0],'-03:00:00',[-3,0,0],
          '-03',0,[1978,12,17,2,59,59],[1978,12,16,23,59,59],
          '1978030502:00:00','1978030423:00:00','1978121702:59:59','1978121623:59:59' ],
        [ [1978,12,17,3,0,0],[1978,12,17,1,0,0],'-02:00:00',[-2,0,0],
          '-02',1,[1979,3,4,1,59,59],[1979,3,3,23,59,59],
          '1978121703:00:00','1978121701:00:00','1979030401:59:59','1979030323:59:59' ],
     ],
   1979 =>
     [
        [ [1979,3,4,2,0,0],[1979,3,3,23,0,0],'-03:00:00',[-3,0,0],
          '-03',0,[1979,4,29,2,59,59],[1979,4,28,23,59,59],
          '1979030402:00:00','1979030323:00:00','1979042902:59:59','1979042823:59:59' ],
        [ [1979,4,29,3,0,0],[1979,4,29,1,0,0],'-02:00:00',[-2,0,0],
          '-02',1,[1980,3,16,1,59,59],[1980,3,15,23,59,59],
          '1979042903:00:00','1979042901:00:00','1980031601:59:59','1980031523:59:59' ],
     ],
   1980 =>
     [
        [ [1980,3,16,2,0,0],[1980,3,15,23,0,0],'-03:00:00',[-3,0,0],
          '-03',0,[1987,12,14,2,59,59],[1987,12,13,23,59,59],
          '1980031602:00:00','1980031523:00:00','1987121402:59:59','1987121323:59:59' ],
     ],
   1987 =>
     [
        [ [1987,12,14,3,0,0],[1987,12,14,1,0,0],'-02:00:00',[-2,0,0],
          '-02',1,[1988,2,28,1,59,59],[1988,2,27,23,59,59],
          '1987121403:00:00','1987121401:00:00','1988022801:59:59','1988022723:59:59' ],
     ],
   1988 =>
     [
        [ [1988,2,28,2,0,0],[1988,2,27,23,0,0],'-03:00:00',[-3,0,0],
          '-03',0,[1988,12,11,2,59,59],[1988,12,10,23,59,59],
          '1988022802:00:00','1988022723:00:00','1988121102:59:59','1988121023:59:59' ],
        [ [1988,12,11,3,0,0],[1988,12,11,1,0,0],'-02:00:00',[-2,0,0],
          '-02',1,[1989,3,5,1,59,59],[1989,3,4,23,59,59],
          '1988121103:00:00','1988121101:00:00','1989030501:59:59','1989030423:59:59' ],
     ],
   1989 =>
     [
        [ [1989,3,5,2,0,0],[1989,3,4,23,0,0],'-03:00:00',[-3,0,0],
          '-03',0,[1989,10,29,2,59,59],[1989,10,28,23,59,59],
          '1989030502:00:00','1989030423:00:00','1989102902:59:59','1989102823:59:59' ],
        [ [1989,10,29,3,0,0],[1989,10,29,1,0,0],'-02:00:00',[-2,0,0],
          '-02',1,[1990,2,25,1,59,59],[1990,2,24,23,59,59],
          '1989102903:00:00','1989102901:00:00','1990022501:59:59','1990022423:59:59' ],
     ],
   1990 =>
     [
        [ [1990,2,25,2,0,0],[1990,2,24,23,0,0],'-03:00:00',[-3,0,0],
          '-03',0,[1990,10,21,2,59,59],[1990,10,20,23,59,59],
          '1990022502:00:00','1990022423:00:00','1990102102:59:59','1990102023:59:59' ],
        [ [1990,10,21,3,0,0],[1990,10,21,1,0,0],'-02:00:00',[-2,0,0],
          '-02',1,[1991,3,3,1,59,59],[1991,3,2,23,59,59],
          '1990102103:00:00','1990102101:00:00','1991030301:59:59','1991030223:59:59' ],
     ],
   1991 =>
     [
        [ [1991,3,3,2,0,0],[1991,3,2,23,0,0],'-03:00:00',[-3,0,0],
          '-03',0,[1991,10,27,2,59,59],[1991,10,26,23,59,59],
          '1991030302:00:00','1991030223:00:00','1991102702:59:59','1991102623:59:59' ],
        [ [1991,10,27,3,0,0],[1991,10,27,1,0,0],'-02:00:00',[-2,0,0],
          '-02',1,[1992,3,1,1,59,59],[1992,2,29,23,59,59],
          '1991102703:00:00','1991102701:00:00','1992030101:59:59','1992022923:59:59' ],
     ],
   1992 =>
     [
        [ [1992,3,1,2,0,0],[1992,2,29,23,0,0],'-03:00:00',[-3,0,0],
          '-03',0,[1992,10,18,2,59,59],[1992,10,17,23,59,59],
          '1992030102:00:00','1992022923:00:00','1992101802:59:59','1992101723:59:59' ],
        [ [1992,10,18,3,0,0],[1992,10,18,1,0,0],'-02:00:00',[-2,0,0],
          '-02',1,[1993,2,28,1,59,59],[1993,2,27,23,59,59],
          '1992101803:00:00','1992101801:00:00','1993022801:59:59','1993022723:59:59' ],
     ],
   1993 =>
     [
        [ [1993,2,28,2,0,0],[1993,2,27,23,0,0],'-03:00:00',[-3,0,0],
          '-03',0,[2004,9,19,2,59,59],[2004,9,18,23,59,59],
          '1993022802:00:00','1993022723:00:00','2004091902:59:59','2004091823:59:59' ],
     ],
   2004 =>
     [
        [ [2004,9,19,3,0,0],[2004,9,19,1,0,0],'-02:00:00',[-2,0,0],
          '-02',1,[2005,3,27,3,59,59],[2005,3,27,1,59,59],
          '2004091903:00:00','2004091901:00:00','2005032703:59:59','2005032701:59:59' ],
     ],
   2005 =>
     [
        [ [2005,3,27,4,0,0],[2005,3,27,1,0,0],'-03:00:00',[-3,0,0],
          '-03',0,[2005,10,9,4,59,59],[2005,10,9,1,59,59],
          '2005032704:00:00','2005032701:00:00','2005100904:59:59','2005100901:59:59' ],
        [ [2005,10,9,5,0,0],[2005,10,9,3,0,0],'-02:00:00',[-2,0,0],
          '-02',1,[2006,3,12,3,59,59],[2006,3,12,1,59,59],
          '2005100905:00:00','2005100903:00:00','2006031203:59:59','2006031201:59:59' ],
     ],
   2006 =>
     [
        [ [2006,3,12,4,0,0],[2006,3,12,1,0,0],'-03:00:00',[-3,0,0],
          '-03',0,[2006,10,1,4,59,59],[2006,10,1,1,59,59],
          '2006031204:00:00','2006031201:00:00','2006100104:59:59','2006100101:59:59' ],
        [ [2006,10,1,5,0,0],[2006,10,1,3,0,0],'-02:00:00',[-2,0,0],
          '-02',1,[2007,3,11,3,59,59],[2007,3,11,1,59,59],
          '2006100105:00:00','2006100103:00:00','2007031103:59:59','2007031101:59:59' ],
     ],
   2007 =>
     [
        [ [2007,3,11,4,0,0],[2007,3,11,1,0,0],'-03:00:00',[-3,0,0],
          '-03',0,[2007,10,7,4,59,59],[2007,10,7,1,59,59],
          '2007031104:00:00','2007031101:00:00','2007100704:59:59','2007100701:59:59' ],
        [ [2007,10,7,5,0,0],[2007,10,7,3,0,0],'-02:00:00',[-2,0,0],
          '-02',1,[2008,3,9,3,59,59],[2008,3,9,1,59,59],
          '2007100705:00:00','2007100703:00:00','2008030903:59:59','2008030901:59:59' ],
     ],
   2008 =>
     [
        [ [2008,3,9,4,0,0],[2008,3,9,1,0,0],'-03:00:00',[-3,0,0],
          '-03',0,[2008,10,5,4,59,59],[2008,10,5,1,59,59],
          '2008030904:00:00','2008030901:00:00','2008100504:59:59','2008100501:59:59' ],
        [ [2008,10,5,5,0,0],[2008,10,5,3,0,0],'-02:00:00',[-2,0,0],
          '-02',1,[2009,3,8,3,59,59],[2009,3,8,1,59,59],
          '2008100505:00:00','2008100503:00:00','2009030803:59:59','2009030801:59:59' ],
     ],
   2009 =>
     [
        [ [2009,3,8,4,0,0],[2009,3,8,1,0,0],'-03:00:00',[-3,0,0],
          '-03',0,[2009,10,4,4,59,59],[2009,10,4,1,59,59],
          '2009030804:00:00','2009030801:00:00','2009100404:59:59','2009100401:59:59' ],
        [ [2009,10,4,5,0,0],[2009,10,4,3,0,0],'-02:00:00',[-2,0,0],
          '-02',1,[2010,3,14,3,59,59],[2010,3,14,1,59,59],
          '2009100405:00:00','2009100403:00:00','2010031403:59:59','2010031401:59:59' ],
     ],
   2010 =>
     [
        [ [2010,3,14,4,0,0],[2010,3,14,1,0,0],'-03:00:00',[-3,0,0],
          '-03',0,[2010,10,3,4,59,59],[2010,10,3,1,59,59],
          '2010031404:00:00','2010031401:00:00','2010100304:59:59','2010100301:59:59' ],
        [ [2010,10,3,5,0,0],[2010,10,3,3,0,0],'-02:00:00',[-2,0,0],
          '-02',1,[2011,3,13,3,59,59],[2011,3,13,1,59,59],
          '2010100305:00:00','2010100303:00:00','2011031303:59:59','2011031301:59:59' ],
     ],
   2011 =>
     [
        [ [2011,3,13,4,0,0],[2011,3,13,1,0,0],'-03:00:00',[-3,0,0],
          '-03',0,[2011,10,2,4,59,59],[2011,10,2,1,59,59],
          '2011031304:00:00','2011031301:00:00','2011100204:59:59','2011100201:59:59' ],
        [ [2011,10,2,5,0,0],[2011,10,2,3,0,0],'-02:00:00',[-2,0,0],
          '-02',1,[2012,3,11,3,59,59],[2012,3,11,1,59,59],
          '2011100205:00:00','2011100203:00:00','2012031103:59:59','2012031101:59:59' ],
     ],
   2012 =>
     [
        [ [2012,3,11,4,0,0],[2012,3,11,1,0,0],'-03:00:00',[-3,0,0],
          '-03',0,[2012,10,7,4,59,59],[2012,10,7,1,59,59],
          '2012031104:00:00','2012031101:00:00','2012100704:59:59','2012100701:59:59' ],
        [ [2012,10,7,5,0,0],[2012,10,7,3,0,0],'-02:00:00',[-2,0,0],
          '-02',1,[2013,3,10,3,59,59],[2013,3,10,1,59,59],
          '2012100705:00:00','2012100703:00:00','2013031003:59:59','2013031001:59:59' ],
     ],
   2013 =>
     [
        [ [2013,3,10,4,0,0],[2013,3,10,1,0,0],'-03:00:00',[-3,0,0],
          '-03',0,[2013,10,6,4,59,59],[2013,10,6,1,59,59],
          '2013031004:00:00','2013031001:00:00','2013100604:59:59','2013100601:59:59' ],
        [ [2013,10,6,5,0,0],[2013,10,6,3,0,0],'-02:00:00',[-2,0,0],
          '-02',1,[2014,3,9,3,59,59],[2014,3,9,1,59,59],
          '2013100605:00:00','2013100603:00:00','2014030903:59:59','2014030901:59:59' ],
     ],
   2014 =>
     [
        [ [2014,3,9,4,0,0],[2014,3,9,1,0,0],'-03:00:00',[-3,0,0],
          '-03',0,[2014,10,5,4,59,59],[2014,10,5,1,59,59],
          '2014030904:00:00','2014030901:00:00','2014100504:59:59','2014100501:59:59' ],
        [ [2014,10,5,5,0,0],[2014,10,5,3,0,0],'-02:00:00',[-2,0,0],
          '-02',1,[2015,3,8,3,59,59],[2015,3,8,1,59,59],
          '2014100505:00:00','2014100503:00:00','2015030803:59:59','2015030801:59:59' ],
     ],
   2015 =>
     [
        [ [2015,3,8,4,0,0],[2015,3,8,1,0,0],'-03:00:00',[-3,0,0],
          '-03',0,[9999,12,31,0,0,0],[9999,12,30,21,0,0],
          '2015030804:00:00','2015030801:00:00','9999123100:00:00','9999123021:00:00' ],
     ],
);

%LastRule      = (
);

1;