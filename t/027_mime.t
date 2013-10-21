# $Id: 027_mime.t,v 1.1.2.1 2013/10/21 06:24:22 ak Exp $
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
use Kanadzuchi::MIME;
use Digest::MD5;
use Test::More;

#  ____ ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ 
# ||G |||l |||o |||b |||a |||l |||       |||v |||a |||r |||s ||
# ||__|||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|
#
my $T = new Kanadzuchi::Test(
    'class' => 'Kanadzuchi::MIME',
    'methods' => [ 'is_mimeencoded', 'mimedecode' ],
);
my $M = 'c00b20fd99fee196a4f47bcae462c148';


#  ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ 
# ||T |||e |||s |||t |||       |||c |||o |||d |||e |||s ||
# ||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|
#
PREPROCESS: {
    can_ok( $T->class, @{ $T->methods } );
}

METHODS: {
    my $mimeencoded = {
        'base64' => [
            '=?utf-8?B?55m954yr44Gr44KD44KT44GT?=',
            '=?iso-2022-jp?B?GyRCR3JHLSRLJGMkcyQzGyhC?=',
            '=?euc-jp?B?x/LHraTLpOOk86Sz?=',
            '=?shift_jis?B?lJKUTILJguGC8YKx?=',
        ],
        'quoted-printable' => [
            '=?utf-8?Q?=E7=99=BD=E7=8C=AB=E3=81=AB=E3=82=83=E3=82=93=E3=81=93?=',
            '=?iso-2022-jp?Q?=1B$BGrG-$K$c$s$3=1B(B?=',
            '=?euc-jp?Q?=C7=F2=C7=AD=A4=CB=A4=E3=A4=F3=A4=B3?=',
            '=?shift_jis?Q?=94=92=94L=82=C9=82=E1=82=F1=82=B1?=',
        ],
    };

    my $mimedecoded = [
        '眉毛の太い猫',
        '貓濃濃的眉毛',
        'القط حواجب كثيفة',
        'Cat густые брови',
        'Cat husté obočí',
        'Kedi kalın kaşları',
    ];

    for my $e ( keys %$mimeencoded ) {
        for my $f ( @{ $mimeencoded->{ $e } } ) {
            ok( $T->class->is_mimeencoded( \$f ), $f );

            my $g = $T->class->mimedecode( [ $f ] );
            my $h = Digest::MD5::md5_hex( $g );
            ok( $g );
            is( $h, $M );
        }
    }

    for my $e ( @$mimedecoded ) {
        is( $T->class->is_mimeencoded( \$e ), 0 );

        my $f = $T->class->mimedecode( [ $e ] );
        ok( $f );
        ok( utf8::is_utf8 $f );
    }
}

done_testing();
__END__
