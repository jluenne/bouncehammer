# $Id: 019_iso3166.t,v 1.1.2.1 2013/08/30 23:05:12 ak Exp $
#  ____ ____ ____ ____ ____ ____ ____ ____ ____ 
# ||L |||i |||b |||r |||a |||r |||i |||e |||s ||
# ||__|||__|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
use lib qw(./t/lib ./dist/lib ./src/lib);
use strict;
use warnings;
use Kanadzuchi::Test;
use Kanadzuchi::ISO3166;
use Test::More;

#  ____ ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ 
# ||G |||l |||o |||b |||a |||l |||       |||v |||a |||r |||s ||
# ||__|||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|
#
my $Test = new Kanadzuchi::Test(
        'class' => 'Kanadzuchi::ISO3166',
        'methods' => [ 'assignedcode' ],
        'instance' => undef,
);

#  ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ 
# ||T |||e |||s |||t |||       |||c |||o |||d |||e |||s ||
# ||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|
#
PREPROCESS: {
    can_ok( $Test->class, @{ $Test->methods } );
}

ISO3166: {
    my $code = $Test->class->assignedcode;
    isa_ok( $code, 'HASH' );
    foreach my $cc ( keys %$code ) {

        ok( $code->{ $cc }->{'shortname'}, 'Short Name = '.$code->{ $cc }->{'shortname'} );
        ok( $code->{ $cc }->{'alpha-2'}, 'Alpha-2 Code = '.$code->{ $cc }->{'alpha-2'} );
        is( uc $cc, $code->{ $cc }->{'alpha-2'} ) unless $cc eq 'uk';
        ok( $code->{ $cc }->{'alpha-3'}, 'Alpha-3 Code = '.$code->{ $cc }->{'alpha-3'} );
        ok( $code->{ $cc }->{'numeric'}, 'Numeric Code = '.$code->{ $cc }->{'numeric'} );
    }
}

done_testing();
__END__
