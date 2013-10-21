# $Id: 014_string.t,v 1.6.2.2 2013/10/21 06:32:48 ak Exp $
#  ____ ____ ____ ____ ____ ____ ____ ____ ____ 
# ||L |||i |||b |||r |||a |||r |||i |||e |||s ||
# ||__|||__|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
use lib qw(./t/lib ./dist/lib ./src/lib);
use strict;
use warnings;
use utf8;
use Kanadzuchi::Test;
use Kanadzuchi::String;
use Test::More;
no warnings 'once';

#  ____ ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ 
# ||G |||l |||o |||b |||a |||l |||       |||v |||a |||r |||s ||
# ||__|||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|
#
my $T = new Kanadzuchi::Test(
    'class' => 'Kanadzuchi::String',
    'methods' => [ 'token', 'is_validtoken', 'is_8bit' ],
    'instance' => undef, );

#  ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ 
# ||T |||e |||s |||t |||       |||c |||o |||d |||e |||s ||
# ||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|
#
PREPROCESS: {
    can_ok( $T->class, @{ $T->methods } );
}

MESSAGE_TOKEN: {
    my $c = $T->class;
    my $d = q();
    is( $c->token( 'hoge', 'fuga'), '58dabdb1c930521fc8ee80c5634e4db6', $c.'->token()' );
    is( $c->token( 'HOGE', 'FUGA'), '58dabdb1c930521fc8ee80c5634e4db6', $c.'->token()' );
    is( $c->token( 'hoge', ''), q(), q{->token('hoge','')} );
    is( $c->token( '', 'fuga'), q(), q{->token('','fuga')} );
    is( $c->token(0,0), q(), '->token(0,0)' );
    ok( $c->is_validtoken( $c->token( 'hoge', 'fuga' )), '->is_validtoken() = 1' );

    FALSE: foreach my $f ( @{ $Kanadzuchi::Test::FalseValues } ) {
        my $argv = defined $f ? sprintf( "%#x", ord $f ) : 'undef';
        $d = $c->token( $f, $f );
        is( length( $d ), 0, '->token('.$argv.') = '.$d );
        is( $c->is_validtoken( $d ), 0, '->is_validtoken() = 0' );
    }

    CONTROL: foreach my $e (
            @{ $Kanadzuchi::Test::EscapeCharacters },
            @{ $Kanadzuchi::Test::ControlCharacters },
            @{ $Kanadzuchi::Test::NegativeValues } ){

        my $argv = defined $e ? sprintf( "%#x",ord $e ) : 'undef';
        $d = $c->token( $e, $e );
        ok( length $d, '->token('.$e.') = '.$argv );
        ok( $c->is_validtoken( $d ), '->is_validtoken() = 1' );
    }
}

EIGHTBIT_VALUE: {
    my $c = $T->class;
    my $d = '猫';

    is( $c->is_8bit( \$d ), 1 );
    is( $c->is_8bit( \'cat' ), 0 );

    is( $c->is_8bit( $d ), undef );
    is( $c->is_8bit( 'cat' ), undef );
    is( $c->is_8bit(), undef );
}

done_testing();
__END__
