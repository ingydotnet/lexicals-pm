##
# name:      lexicals
# abstract:  Get a hash of your current 'my' variables
# author:    Ingy döt Net <ingy@ingy.net>
# license:   perl
# copyright: 2011
# see:
# - PadWalker
# - Acme::Locals

use strict; use warnings;
package lexicals;
our $VERSION = '0.23';

use PadWalker;

use base 'Exporter';
our @EXPORT = qw(lexicals);

sub lexicals {
    my $hash = PadWalker::peek_my(1);
    return +{
        map {
            my $v = $hash->{$_};
            $v = $$v if ref($v) =~ m'^(SCALAR|REF)$';
            s/^[\$\@\%\*]//;
            ($_, $v);
        } reverse sort keys %$hash
    };
}

1;
