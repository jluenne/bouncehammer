# $Id: 506_bin-messagetoken.t,v 1.4.2.1 2013/08/30 23:05:13 ak Exp $
#  ____ ____ ____ ____ ____ ____ ____ ____ ____ 
# ||L |||i |||b |||r |||a |||r |||i |||e |||s ||
# ||__|||__|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
use lib qw(./t/lib ./dist/lib ./src/lib);
use strict;
use warnings;
use Test::More ( 'tests' => 43 );

SKIP: {
    my $howmanyskips = 43;
    eval{ require IPC::Cmd; }; 
    skip( 'Because no IPC::Cmd for testing', $howmanyskips ) if $@;

    require Kanadzuchi::Test::CLI;
    require Kanadzuchi;
    require File::Copy;

    #  ____ ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ 
    # ||G |||l |||o |||b |||a |||l |||       |||v |||a |||r |||s ||
    # ||__|||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__||
    # |/__\|/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|
    #
    my $K = new Kanadzuchi;
    my $E = new Kanadzuchi::Test::CLI(
            'command' => -x './dist/bin/messagetoken' ? './dist/bin/messagetoken' : './src/bin/messagetoken.PL',
            'config' => './src/etc/prove.cf',
            'input' => './examples/17-messages.eml',
            'output' => './.test/hammer.1970-01-01.ffffffff.000000.tmp',
            'tempdir' => './.test',
    );

    my $O = $E->command.' -C'.$E->config;

    #  ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ 
    # ||T |||e |||s |||t |||       |||c |||o |||d |||e |||s ||
    # ||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__||
    # |/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|
    #
    PREPROCESS: {
        $K->load($E->config);
        ok( $E->environment(1), '->environment(1)' );
        ok( $E->syntax, '->syntax' );
        ok( $E->version, '->version' );
        ok( $E->help, '->help' );
        ok( $E->error, '->error' );

        File::Copy::copy( './examples/hammer.1970-01-01.ffffffff.000000.tmp', $E->output );
    }

    MESSAGETOKEN: {
        my $jsonarr = JSON::Syck::LoadFile( $E->output );
        my $command = q();
        my $xresult = q();

        isa_ok( $jsonarr, 'ARRAY' );

        foreach my $j ( @$jsonarr ) {
            my $a = $j->{'addresser'};
            my $r = $j->{'recipient'};
            my $m = $j->{'token'};

            $command = $E->perl.$O.' -a '.$a.' -r '.$r;
            $xresult = qx| $command |;
            chomp $xresult;

            is( $xresult, $m, ' -a '.$a.' -r '.$r.' :MessageToken = '.$m );
        }
    }

}

__END__
