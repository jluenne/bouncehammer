# $Id: 090_log.t,v 1.9.2.2 2013/08/30 23:05:12 ak Exp $
#  ____ ____ ____ ____ ____ ____ ____ ____ ____ 
# ||L |||i |||b |||r |||a |||r |||i |||e |||s ||
# ||__|||__|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
use lib qw(./t/lib ./dist/lib ./src/lib);
use strict;
use warnings;
use Kanadzuchi::Test;
use Kanadzuchi::Mail::Bounced;
use Kanadzuchi::Mbox;
use Kanadzuchi::Log;
use Path::Class;
use Test::More;

#  ____ ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ 
# ||G |||l |||o |||b |||a |||l |||       |||v |||a |||r |||s ||
# ||__|||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|
#
my $L = new Kanadzuchi::Test(
    'class' => 'Kanadzuchi::Log',
    'methods' => [ 'new', 'logger', 'dumper' ],
);

my $NM = 37;
my $OF = [ 'yaml', 'json', 'csv', 'asciitable' ];
my $MR = undef;
my $TD = undef;
my $KP = undef;

#  ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ 
# ||T |||e |||s |||t |||       |||c |||o |||d |||e |||s ||
# ||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|
#
foreach my $fmt ( 'json', 'yaml' ) {
    PREPROCESS: {
        $TD = new Path::Class::Dir( $L->tempdir.'/hammer-log.temp.'.$$);
        $KP = new Kanadzuchi::Mbox( 'file' => $L->example->stringify.'/17-messages.eml' );

        $L->instance( new Kanadzuchi::Log(
            'directory' => new Path::Class::Dir( $L->tempdir ),
            'logfile' => new Path::Class::File( $L->tempdir.'/test-data.tmp' ),
            'entities' => [],
            'count' => 0,
            'format' => $fmt,
            'device' => 'STDOUT', )
        );

        isa_ok( $L->instance, $L->class );
        isa_ok( $L->instance->directory, 'Path::Class::Dir' );
        isa_ok( $L->instance->logfile, 'Path::Class::File' );
        can_ok( $L->class, @{ $L->methods } );

        isa_ok( $TD, 'Path::Class::Dir' );
        isa_ok( $KP, 'Kanadzuchi::Mbox' );

        CALL_PARSER: {
            is( $KP->slurpit, $NM, 'Kanadzuchi::Mbox->slurpit' );
            is( $KP->parseit, $NM, 'Kanadzuchi::Mbox->parseit' );

            $TD->mkpath unless -e $TD->stringify;
            $MR = Kanadzuchi::Mail::Bounced->eatit( 
                    $KP, [], { 'cache' => $TD->stringify, 'greed' => 1, 'verbose' => 0 } );

            isa_ok( $MR, 'Kanadzuchi::Iterator' );
        }

        $L->instance->entities( $MR->all );
        $L->instance->count( $MR->count );
    }

    LOG_INSTANCE: {

        my $dumpeddata = q();

        isa_ok( $L->instance->entities, 'ARRAY', $L->class.'->entities' );

        is( $L->instance->count, $NM, $L->class.'->count' );
        is( $L->instance->format, $fmt, $L->class.'->format' );
        is( $L->instance->device, 'STDOUT', $L->class.'->device' );

        OUTPUT_FORMAT: foreach my $f ( @$OF ) {
            $L->instance->format( $f );

            $dumpeddata = $L->instance->logger;
            ok( length $dumpeddata, $L->class.'->logger with '.$f );

            $dumpeddata = $L->instance->dumper;
            ok( length $dumpeddata, $L->class.'->dumper with '.$f );
        }
    }
}

done_testing();
__END__
