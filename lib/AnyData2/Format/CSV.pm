package AnyData2::Format::CSV;

use 5.006;
use strict;
use warnings FATAL => 'all';

use base qw(AnyData2::Format AnyData2::Role::GuessImplementation);

=head1 NAME

AnyData2::Format::CSV - Format base class for AnyData2

=cut

our $VERSION = '0.001';

=head1 METHODS

=head2 new

constructs a storage, passes all options down to C<csv_class> beside
C<csv_class>, which is used to instantiate the parser. C<csv_class>
prefers L<Text::CSV_XS> over L<Text::CSV> by default.

=cut

sub new
{
    my ( $class, $storage, %options ) = @_;
    my $csv_class = delete $options{csv_class};
    defined $csv_class or $csv_class = $class->_guess_suitable_class(qw(Text::CSV_XS Text::CSV));
    my $csv = $csv_class->new( {%options} );
    my $self = $class->SUPER::new($storage);
    $self->{csv} = $csv;
    $self;
}

=head2 read

=cut

sub read
{
    my $self = shift;
    my $buf  = $self->{storage}->read();
    my $stat = $self->{csv}->parse($buf);
    $stat or return $self->_handle_error( $self->{csv}->error_diag );
    [ $self->{csv}->fields ];
}

=head2 write

=cut

sub write
{
    my ( $self, $fields ) = @_;
    my $stat = $self->{csv}->combine(@$fields);
    $stat or return $self->_handle_error( $self->{csv}->error_diag );
    $self->{storage}->write( $self->{csv}->string );
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
