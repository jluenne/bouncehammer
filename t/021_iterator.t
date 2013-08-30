# $Id: 021_iterator.t,v 1.3.2.1 2013/08/30 23:05:12 ak Exp $
#  ____ ____ ____ ____ ____ ____ ____ ____ ____ 
# ||L |||i |||b |||r |||a |||r |||i |||e |||s ||
# ||__|||__|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
use lib qw(./t/lib ./dist/lib ./src/lib);
use strict;
use warnings;
use Kanadzuchi::Test;
use Kanadzuchi::Iterator;
use Time::Piece;
use Test::More;

#  ____ ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ 
# ||G |||l |||o |||b |||a |||l |||       |||v |||a |||r |||s ||
# ||__|||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|
#
my $T = new Kanadzuchi::Test(
    'class' => 'Kanadzuchi::Iterator',
    'methods' => [ 'new', 'reset', 'flush', 'first', 'hasnext', 'next', 'all' ],
    'instance' => new Kanadzuchi::Iterator,
);


#  ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ 
# ||T |||e |||s |||t |||       |||c |||o |||d |||e |||s ||
# ||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|
#
PREPROCESS: {
    isa_ok( $T->instance, $T->class );
    can_ok( $T->class, @{ $T->methods } );
}

CONSTRUCTOR: {
    my $object = new Kanadzuchi::Iterator;
    isa_ok( $object, $T->class );
    isa_ok( $object->data, 'ARRAY' );
    is( $object->count, 0, '->count = 0' );
}

METHODS: {
    my $objs = [];
    my $iter = undef;
    my $aref = [];

    REGULAR_CASES: {
        foreach my $c ( 1..10 ) {
            push( @$objs, Time::Piece->new( $c * 90000 ) );
        }

        isa_ok( $objs, 'ARRAY' );
        $iter = new Kanadzuchi::Iterator( $objs );

        isa_ok( $iter, 'Kanadzuchi::Iterator' );
        isa_ok( $iter->data, 'ARRAY' );
        is( $iter->count, 10, '->count = 10' );
        is( $iter->position, 0, '->position = 0' );
        isa_ok( $iter->first, 'Time::Piece' );

        while( my $i = $iter->next ) {
            isa_ok( $i, 'Time::Piece' );
            ok( $i->ymd, $i->ymd );
            ok( $iter->position, '->position = '.$iter->position );
            ok( $iter->hasnext, '->hasnext' ) if $iter->position < 9;
        }

        is( $iter->position, 10, '->position = 10' );

        $aref = $iter->all;
        isa_ok( $aref, 'ARRAY' );
        is( scalar @$aref, 10 );

        foreach my $t ( @$aref ){ 
            isa_ok( $t, 'Time::Piece' );
        }

        is( $iter->reset->position, 0, '->reset->position = 0' );

        $iter->flush;
        is( $iter->count, 0, '->flush->count = 0' );
        is( $iter->position, 0, '->flush->position = 0' );
        is( $iter->hasnext, 0, '->flush->hasnext = 0' );

        $aref = $iter->all;
        is( scalar @$aref, 0 );
    }

    IRREGULAR_CASES: {
        $objs = [];

        FALSE: foreach my $f ( 
            @{ $Kanadzuchi::Test::FalseValues },
            @{ $Kanadzuchi::Test::ZeroValues } ) {

            push @$objs, $f;
        }

        NEGATIVE: foreach my $n ( @{$Kanadzuchi::Test::NegativeValues} ) {
            push @$objs, $n;
        }

        CONTORL: foreach my $c ( 
            @{ $Kanadzuchi::Test::EscapeCharacters },
            @{ $Kanadzuchi::Test::ControlCharacters } ) {

            push @$objs, $c;
        }


        isa_ok( $objs, 'ARRAY' );
        $iter = new Kanadzuchi::Iterator( $objs );

        isa_ok( $iter, 'Kanadzuchi::Iterator' );
        isa_ok( $iter->data, 'ARRAY' );
        is( $iter->count, scalar @$objs, '->count = '.scalar @$objs );
        is( $iter->position, 0, '->position = 0' );

    }
}

done_testing();
__END__

