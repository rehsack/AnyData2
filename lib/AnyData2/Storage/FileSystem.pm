package AnyData2::Storage::FileSystem;

use 5.006;
use strict;
use warnings FATAL => 'all';

use base qw(AnyData2::Storage);

use Carp qw/croak/;
use IO::Dir ();

=head1 NAME

AnyData2::Storage::FileSystem - AnyData2 file storage ...

=cut

our $VERSION = '0.001';

=head1 METHODS

...

=head2 new

constructs a storage.

=cut

sub new
{
    my ( $class, %options ) = @_;
    my $self = $class->SUPER::new();
    $self->{dirh} = IO::Dir->new( $options{dirname} ) or die "Can't open $options{dirname}";
    @$self{qw(dirname)} = @options{qw(dirname)};
    $self;
}

=head2 read

  my $buf = $stor->read(<characters>)

Use binmode for characters as synonymous for bytes.

=cut

sub read
{
    my $self  = shift;
    my $entry = $self->{dirh}->read;
    $entry;
}

=head2 seek

  $stor->seek(0,SEEK_SET)

Sets the current position to the beginning of the directory (this,
naturally, affects read only).

=cut

sub seek
{
    my ( $self, $pos, $whence ) = @_;
    $pos == 0 and $whence == 0 and return $self->{dirh}->rewind;
    croak "Unsupported combination of POS and WHENCE";
}

=head2 meta

Returns a meta storage - if any. Imaging it as an object dealing with
underlying filesystem for a file storage.

=cut

sub meta
{
    my $self = shift;
    $self->{meta} or $self->{meta} = AnyData2::Storage::FileSystem->new( dirname => dirname( $self->{dirname} ) );
    $self->{meta};
}

=head1 LICENSE AND COPYRIGHT

Copyright 2015 Jens Rehsack.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

=cut

1;
