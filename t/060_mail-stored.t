# $Id: 060_mail-stored.t,v 1.2.2.1 2013/08/30 23:05:12 ak Exp $
#  ____ ____ ____ ____ ____ ____ ____ ____ ____ 
# ||L |||i |||b |||r |||a |||r |||i |||e |||s ||
# ||__|||__|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
use lib qw(./t/lib ./dist/lib ./src/lib);
use strict;
use warnings;
use Kanadzuchi::Test;
use Kanadzuchi::Test::Mail;
use Kanadzuchi::Mail::Stored;
use Test::More;

#  ____ ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ 
# ||G |||l |||o |||b |||a |||l |||       |||v |||a |||r |||s ||
# ||__|||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|
#
my $T = new Kanadzuchi::Test(
    'class' => 'Kanadzuchi::Mail::Stored',
    'methods' => [ 
        @{ $Kanadzuchi::Test::Mail::MethodList->{'BaseClass'} },
        @{ $Kanadzuchi::Test::Mail::MethodList->{'Stored'} },
    ],
    'instance' => new Kanadzuchi::Mail::Stored,
);

isa_ok( $T->instance, $T->class );
can_ok( $T->class, @{ $T->methods } );

done_testing();
__END__
