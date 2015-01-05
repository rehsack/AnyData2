#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'AnyData2' ) || BAIL_OUT "Couldn't load AnyData2";
}

diag( "Testing AnyData2 $AnyData2::VERSION, Perl $], $^X" );
