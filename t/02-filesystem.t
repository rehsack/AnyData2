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

my $cols = $af->cols;
my @rows;

while ( my $row = $af->fetchrow )
{
    push @rows, $row;
}

my @stripped_rows = map { [ $_->[0] ] } @rows;

is_deeply( $cols, [qw(entry dev ino mode nlink uid gid rdev size atime mtime ctime blksize blocks)], "Cols from filesystem" );
is_deeply( \@stripped_rows, [ ["."], [".."], ["simple.csv"] ], "Rows from filesystem" );

done_testing;
