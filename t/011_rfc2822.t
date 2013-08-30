# $Id: 011_rfc2822.t,v 1.6.2.1 2013/08/30 23:05:12 ak Exp $
#  ____ ____ ____ ____ ____ ____ ____ ____ ____ 
# ||L |||i |||b |||r |||a |||r |||i |||e |||s ||
# ||__|||__|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
use lib qw(./t/lib ./dist/lib ./src/lib);
use strict;
use warnings;
use Kanadzuchi::Test;
use Kanadzuchi::RFC2822;
use Test::More;

#  ____ ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ 
# ||G |||l |||o |||b |||a |||l |||       |||v |||a |||r |||s ||
# ||__|||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|
#
my $T = new Kanadzuchi::Test(
    'class' => 'Kanadzuchi::RFC2822',
    'methods' => [
        'is_emailaddress', 'is_domainpart', 'expand_subaddress',
        'is_mailerdaemon', 'is_subaddress', ],
    'instance' => undef, );

my $e = {
    'ok' => 'postmaster@example.jp',
    'ng' => 'postmaster-example-jp',
};
my $s = {
    'ok' => 'postmaster+hostmaster@example.jp',
    'ng' => 'postmaster-hostmaster@example.jp',
};
my $x = {
    'ok' => 'bounce+postmaster=example.org@example.jp',
    'ng' => 'bounce-postmaster@example.jp',
};
my $d = {
    'ok' => 'example.jp',
    'ng' => '.',
};

#  ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ 
# ||T |||e |||s |||t |||       |||c |||o |||d |||e |||s ||
# ||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|
#
PREPROCESS: {
    can_ok( $T->class, @{ $T->methods } );
}

CLASS_METHODS: {
    my $class = $T->class;

    VALID_ADDRESS: {
        ok( $class->is_emailaddress( $e->{'ok'} ), 'Check valid address' );
        ok( $class->is_domainpart( $d->{'ok'} ), 'Check valid domain'  );
        ok( $class->is_mailerdaemon('MAILER-DAEMON'), 'Check MAILER-DAEMON'  );
        ok( $class->is_subaddress( $s->{'ok'} ), 'Check sub-address' );

        my $xa = $class->expand_subaddress( $x->{'ok'} );
        is( $class->expand_subaddress( $x->{'ok'}), $xa, 'Expand sub-address = '.$xa );
    }

    INVALID_ADDRESS: {
        is( $class->is_emailaddress( $e->{'ng'} ),0, 'Check invalid address' );
        is( $class->is_domainpart( $d->{'ng'} ),0, 'Check invalid domain'  );
        is( $class->is_mailerdaemon( 'Postmaster' ),0, 'Check Non MAILER-DAEMON' );
        is( $class->is_subaddress( $s->{'ng'} ), 0, 'Check invalid sub-address' );

        my $xa = $class->expand_subaddress( $x->{'ng'} );
        is( $class->expand_subaddress( $x->{'ng'} ), q{}, 'Expand invalid sub-address = ' );
    }

    IRREGULAR_CASES: {
        foreach my $x ( qw/@example.jp user@/ ) {
            is( $class->is_emailaddress( $e ), 0, '->is_emailaddress('.$x.')' );
            is( $class->is_mailerdaemon( $e ), 0, '->is_mailerdaemon('.$x.')' );
        }

        foreach my $e ( @{ $Kanadzuchi::Test::ExceptionalValues } ) {
            my $argv = defined $e ? sprintf( "%#x", ord $e ) : 'undef';
            is( $class->is_emailaddress( $e ) ,0, '->is_emailaddress('.$argv.')' );
            is( $class->is_mailerdaemon( $e ) ,0, '->is_mailerdaemon('.$argv.')' );
            is( $class->is_domainpart( $e ) ,0, '->is_domainpart('.$argv.')' );
        }

        foreach my $n ( @{ $Kanadzuchi::Test::NegativeValues } ) {
            is( $class->is_emailaddress( $n ) ,0, '->is_emailaddress('.$n.')' );
            is( $class->is_mailerdaemon( $n ) ,0, '->is_mailerdaemon('.$n.')' );
            is( $class->is_domainpart( $n ) ,1, '->is_domainpart('.$n.')' );
        }
    }
}
done_testing();
__END__
