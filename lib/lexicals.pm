##
# name: lexicals
# abstract: Create a hash of your 'my' variables
# author: Ingy döt Net <ingy@ingy.net>
# license: perl
# copyright: 2011
# see:
# - PadWalker
# - Acme::Locals

package lexicals;
use 5.005008;
use strict;

our $VERSION = '0.11';

use PadWalker;

use base 'Exporter';
our @EXPORT = qw(lexicals);

sub lexicals {
    my $hash = PadWalker::peek_my(1);
    my $lex = {};
    while ( my ($k, $v) = each %$hash ) {
        $k =~ s/^\$//;
        $lex->{$k} = $$v;
    }
    return $lex;
}

1;

=head1 SYNOPSIS

    use Template::Toolkit::Simple;
    use lexicals;

    sub mail {
        my $self = shift;
        my $name = 'Mr. ' . $self->get_name;
        my $address = $self->fetch_address($name);
        my $stamp = Postage::Stamp->new(0.44);
        my $envelope = tt->render('envelope', lexicals);
    }

=head1 DESCRIPTION

Python has a builtin function called `locals()` that returns the lexically
scoped variables in a name/value mapping. This is a very useful idiom.
Instead of needing to create a hash like this:

    my $hash = {
        foo => $foo,
        bar => $bar,
    };

Just say:

    my $hash = lexicals;

Assuming you have a $foo and $bar defined, you get the same thing.

The `lexicals` module exports a function called `lexicals`. This function
returns the lexicals as a hash reference (in scalar or list context).

=head1 NOTE

The C<lexicals> function only reports the lexical variables variables that
were defined before where it gets called.

=head1 DEBUGGING TRICK

This could be a handy idiom for debugging:

    use XXX;

    sub foo {
        ...
        XXX lexicals;     # See your lexicals in the nude.
        ...
    }
