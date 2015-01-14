#!perl

use 5.006;
use strict;
use warnings FATAL => 'all';

use Test::More;

use Cwd ();
use FindBin ();
use File::Spec ();

BEGIN {
    use_ok( 'AnyData2' ) || BAIL_OUT "Couldn't load AnyData2";
    use_ok( 'AnyData2::Format::CSV' ) || BAIL_OUT "Couldn't load AnyData2::Format::CSV";
    use_ok( 'AnyData2::Storage::File::Linewise' ) || BAIL_OUT "Couldn't load AnyData2::Storage::File::Linewise";
}

my $test_dir = Cwd::abs_path( File::Spec->catdir( $FindBin::Bin, "data" ) );

my $af = AnyData2->new(
    CSV => {},
    "File::Linewise" => { filename => File::Spec->catfile($test_dir, "simple.csv") }
);

done_testing;
