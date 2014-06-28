# Test to make sure that this package builds and is installable.
use Test::More tests => 1;
use strict;
use Cwd qw'cwd abs_path';

die "Error: Use devel-local!\n\n" unless 
    $ENV{PERL5LIB} =~ /module-package-pm/;

delete $ENV{PERL_CPANM_OPT};
if (-e 'Makefile') {
    system("make purge") == 0 or die;
    system("rm -fr local") == 0 or die;
}
system("perl Makefile.PL") == 0 or die;
system("make manifest") == 0 or die;
system("make dist") == 0 or die;
system("cpanm -l local lexicals-*.tar.gz") == 0 or die;

ok -e 'local/lib/perl5/lexicals.pm', 'Install works on user end';

system("rm lexicals-*.tar.gz") == 0 or die;
system("rm -fr local") == 0 or die;
