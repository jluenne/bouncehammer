# $Id: 151_ui-cli.t,v 1.7.2.2 2013/08/30 23:05:12 ak Exp $
#  ____ ____ ____ ____ ____ ____ ____ ____ ____ 
# ||L |||i |||b |||r |||a |||r |||i |||e |||s ||
# ||__|||__|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
use lib qw(./t/lib ./dist/lib ./src/lib);
use strict;
use warnings;
use Kanadzuchi::Test;
use Kanadzuchi::UI::CLI;
use Path::Class::File;
use File::Basename qw(basename);
use Test::More;

#  ____ ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ 
# ||G |||l |||o |||b |||a |||l |||       |||v |||a |||r |||s ||
# ||__|||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|
#
my $K = new Kanadzuchi;
my $T = new Kanadzuchi::Test(
    'class' => 'Kanadzuchi::UI::CLI',
    'methods' => [ 
        'new', 'init', 'batchstatus', 'd', 'e', 'catch_signal',
        'DESTROY', 'abort', 'exception', 'finish'
    ],
    'instance' => new Kanadzuchi::UI::CLI(
        'commandline' => join( ' ', $0, @ARGV ),
    ),
);
my $P = {};

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

    my $o = $T->instance;
    isa_ok( $o->option, 'HASH', '->option' );

    is( $o->cf, undef, '->cf = undefined' );
    is( $o->operation, 0, '->operation = 0' );
    is( $o->debuglevel, 0, '->debuglevel = 0' );
    is( $o->calledfrom, File::Basename::basename($0), '->calledfrom = '.$o->calledfrom );
    ok( $o->processid, '->processid = '.$o->processid );
    ok( length $o->commandline, '->commandline = '.$o->commandline );
}

foreach my $cf ( './src/etc/prove.cf', './src/etc/test-run.cf', '/dev/null', '/doesnotexist' )
{

    DESTORACTOR_OF_PREVIOUS_OBJECT: {
        last unless defined $P;
        last unless defined $P->{'tmpdir'};
        last unless defined $P->{'pf'};
        ok( ! -d $P->{'tmpdir'}, 'DESTROY: $P->{tmpdir} = '.$P->{'tmpdir'} );
        ok( ! -f $P->{'pf'}, 'DESTROY: $P->{pf} = '.$P->{'pf'} );
        $P = {};
    }

    my $o = new Kanadzuchi::UI::CLI( 
        'commandline' => $T->instance->commandline, 'cf' => $cf );
    my $l = 0;

    PREPROCESS: {

        isa_ok( $o, $T->class );
        can_ok( $o, @{ $T->methods } );
    }

    CONSTRUCTOR: {

        isa_ok( $o->option, 'HASH', '->option' );

        is( $o->operation, 0, '->operation = 0' );
        is( $o->debuglevel, 0, '->debuglevel = 0' );
        is( $o->calledfrom, File::Basename::basename($0), '->calledfrom = '.$o->calledfrom );
        ok( $o->processid, '->processid = '.$o->processid );
        ok( length($o->commandline), '->commandline = '.$o->commandline );
    }

    INITIALIZED: {
        $K->config( {} );
        $l = $K->load( $o->cf );

        if( defined $o->cf && -e $o->cf ) {

            isa_ok( $K->config, 'HASH' );
            isa_ok( $o->cf, q|Path::Class::File|, '->cf' );
            like( $o->cf->stringify, qr{/}, '->cf = '.$o->cf->stringify );
            ok( length($K->config->{'system'}), 'Kanadzuchi->config->system = '.$K->config->{'system'} );
            is( $l, 1, 'Kanadzuchi->load = '.$o->cf->stringify );
            ok( $o->stream->{'in'} > -1, '->stream->in = '.$o->stream->{'in'} );
            ok( $o->stream->{'out'} > -1, '->stream->out = '.$o->stream->{'out'} );
            ok( $o->stream->{'error'} > -1, '->stream->error = '.$o->stream->{'error'} );

        } else {
            isnt( ref( $o->cf ), 'Path::Class::File', '->cf' );
            is( ref( $l ), 'Kanadzuchi::Exception::IO', 'Kanadzuchi->load = ' );
            $P = {};
            next;
        }
        ok( $o->init( $K ), '->init' );

        ENVIRONMENT: {
            is( $ENV{'LANG'}, 'C', 'ENV{LANG} = C' );
            is( $ENV{'LC_ALL'}, 'C', 'ENV{LC_ALL} = C' );
            is( exists $ENV{'IFS'}, q(), 'ENV{IFS} is removed' );
            is( exists $ENV{'CDPATH'}, q(), 'ENV{CDPATH} is removed' );
            is( exists $ENV{'ENV'}, q(), 'ENV{ENV} is removed' );
            is( exists $ENV{'BASH_ENV'}, q(), 'ENV{BASH_ENV} is removed' );
        }

        OTHER_MEMBERS: {
            isa_ok( $o->tmpdir, 'Path::Class::Dir', '->tmpdir' );
            isa_ok( $o->pf, 'Path::Class::File', '->pf' );

            ok( -d $o->tmpdir, '->tmpdir = '.$o->tmpdir->stringify );
            ok( -f $o->pf, '->pf = '.$o->pf->stringify );
        }

        $P = { 'tmpdir' => $o->tmpdir->stringify, 'pf' => $o->pf->stringify, };
    }
}

foreach my $e ( 
    @{ $Kanadzuchi::Test::ExceptionalValues },
    @{ $Kanadzuchi::Test::NegativeValues } ) {

    my $l = 0;
    my $o = new Kanadzuchi::UI::CLI( 
                'commandline' => $T->instance->commandline, 'cf' => $e );
    $a = defined $e ? sprintf( "%#x", ord $e ) : 'undef';

    PREPROCESS: {
        isa_ok( $o, $T->class );
        can_ok( $o, @{$T->methods} );
    }

    CONSTRUCTOR: {

        isa_ok( $o->option, 'HASH', '->option' );

        isnt( ref $o->cf, 'Path::Class::File', '->cf = undef, '.$a );
        is( $o->operation, 0, '->operation = 0' );
        is( $o->debuglevel, 0, '->debuglevel = 0' );
        is( $o->calledfrom, File::Basename::basename($0), '->calledfrom = '.$o->calledfrom );
        ok( $o->processid, '->processid = '.$o->processid );
        ok( length $o->commandline, '->commandline = '.$o->commandline );
    }
}

done_testing;
__END__
