#!perl

use 5.006;
use strict;
use warnings FATAL => 'all';

use Test::More;

use Cwd        ();
use FindBin    ();
use File::Spec ();

BEGIN
{
    use_ok('AnyData2')                      || BAIL_OUT "Couldn't load AnyData2";
    use_ok('AnyData2::Format::FileSystem')  || BAIL_OUT "Couldn't load AnyData2::Format::FileSystem";
    use_ok('AnyData2::Storage::FileSystem') || BAIL_OUT "Couldn't load AnyData2::Storage::FileSystem";
}

my $test_dir = Cwd::abs_path( File::Spec->catdir( $FindBin::Bin, "data" ) );

my $af = AnyData2->new(
    FileSystem   => {},
    "FileSystem" => { dirname => File::Spec->catfile($test_dir) }
);

done_testing;
