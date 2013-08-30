# $Id: 501_bin-logger.t,v 1.11.2.1 2013/08/30 23:05:12 ak Exp $
#  ____ ____ ____ ____ ____ ____ ____ ____ ____ 
# ||L |||i |||b |||r |||a |||r |||i |||e |||s ||
# ||__|||__|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
use lib qw(./t/lib ./dist/lib ./src/lib);
use strict;
use warnings;
use Test::More ( 'tests' => 354 );

SKIP: {
    my $howmanyskips = 354;
    eval{ require IPC::Cmd; }; 
    skip( 'Because no IPC::Cmd for testing', $howmanyskips ) if($@);

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
            'command' => -x './dist/bin/logger' ? './dist/bin/logger' : './src/bin/logger.PL',
            'config' => './src/etc/prove.cf',
            'input' => './examples/17-messages.eml',
            'output' => './.test/hammer.1970-01-01.ffffffff.000000.tmp',
            'tempdir' => './.test',
    );

    my $O = ' -C'.$E->config;
    my $LogFiles = Kanadzuchi::Test::CLI->logfiles;
    my $X = './.test/hammer.1970-01-01.11111111.111111.tmp';
    my $Y = './.test/hammer.2008-09-18.log';

    my $Suite = [
        {
            'name' => 'List of log files',
            'option' => $O.' --list',
            'expect' => 1,
            'wantresult' => 1,
        },
        {
            'name' => 'Specify a file/Concatenate',
            'option' => $O.' -c '.$E->output,
        },
        {
            'name' => 'Specify a directory/Concatenate',
            'option' => $O.' -c '.$E->tempdir,
        },
        {
            'name' => 'Specify a directory and remove temp logs/Concatenate',
            'option' => $O.' -c '.$E->tempdir.' --remove ',
        },
        {
            'name' => 'Specify a directory and truncate temp logs/Concatenate',
            'option' => $O.' -c '.$E->tempdir.' --truncate ',
        },
        {
            'name' => 'Specify a directory and backup temp logs/Concatenate',
            'option' => $O.' -c '.$E->tempdir.' --backup /tmp ',
        },
        {
            'name' => 'Specify a file/Merge',
            'option' => $O.' -m '.$X,
        },
        {
            'name' => 'Specify a file and remove temp logs/Merge',
            'option' => $O.' -m '.$X.' --remove ',
        },
        {
            'name' => 'Specify a file and truncate temp logs/Merge',
            'option' => $O.' -m '.$X.' --truncate ',
        },
        {
            'name' => 'Specify a file and backup temp logs/Merge',
            'option' => $O.' -m '.$X.' --backup /tmp ',
        },
    ];

    #  ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ 
    # ||T |||e |||s |||t |||       |||c |||o |||d |||e |||s ||
    # ||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__||
    # |/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|
    #
    PREPROCESS: {
        $K->load( $E->config );
        File::Copy::copy( '../examples/'.File::Basename::basename( $E->output ),
                    $E->tempdir.'/'.File::Basename::basename( $E->output ) );
        File::Copy::copy( $E->output, $E->output.'.bak' ) if -s $E->output;
        File::Copy::copy( $E->output.'.bak', $E->output ) if -s $E->output.'.bak';

        ok( $E->environment(1), '->environment(1)' );
        ok( $E->syntax, '->syntax' );
        ok( $E->version, '->version' );
        ok( $E->help, '->help' );
        ok( $E->error('-c'), '->error' );
        ok( $E->mailboxparser, '(mailboxparser) ->mailboxparser' );

        CLEANUP: foreach my $f ( @$LogFiles ) {

            next unless -f $E->tempdir.'/'.$f->{'file'};
            truncate( $E->tempdir.'/'.$f->{'file'}, 0 );
        }
    }

    ERROR_MESSAGES: {
        my $command = q();
        my $xresult = [];
    }

    EXECUTE: foreach my $s ( @$Suite ) {

        my $command = $E->perl.$E->command.$s->{'option'};
        my $xresult = q();

        if( $s->{'wantresult'} ) {
            $xresult = qx|$command|; chomp $xresult;
            ok( $xresult >= $s->{'expect'}, $s->{'name'} );

        } else {
            File::Copy::copy( $E->output.'.bak', $E->output ) if -s $E->output.'.bak';
            my $yaml = undef;
            my $file = undef;

            if( $s->{'name'} =~ m{Concatenate\z} ) {

                $xresult = scalar(IPC::Cmd::run( 'command' => $command ));
                ok( $xresult, $s->{'name'}.': '.$command );

                LOGFILE: foreach my $f ( @$LogFiles ) {

                    $yaml = undef;
                    $file = $E->tempdir.'/'.$f->{'file'};

                    SKIP: {
                        skip( 'No log file', 3 ) unless -e $file;

                        $yaml = JSON::Syck::LoadFile( $file );
                        isa_ok( $yaml, 'ARRAY', $f->{'file'}.' is Array(JSON)' );
                        ok( scalar @$yaml > 0, $f->{'file'}.' has '.$f->{'entity'}.' records' );
                        is( $K->is_logfile( $f->{'file'} ), 2, $f->{'file'}.' is regular log file' );

                        unlink $file if -e $file;
                    }
                }

            } elsif( $s->{'name'} =~ m{Merge\z} ) {

                foreach my $c ( 1 .. 3 ) {

                    open( my $_tmplogx, '<', $E->output );
                    open( my $_tmplog1, '>', $X );

                    while( my $__line = <$_tmplogx> ) {
                        print( $_tmplog1 $__line );
                        last;
                    }
                    close $_tmplogx;
                    close $_tmplog1;

                    $xresult = scalar(IPC::Cmd::run( 'command' => $command ));
                    ok( $xresult, qq|[$c] |.$s->{'name'}.': '.$command );

                    $yaml = JSON::Syck::LoadFile( $Y ); 
                    isa_ok( $yaml, 'ARRAY', qq|[$c] |.$Y.' is Array(JSON)' );
                    is( scalar @$yaml, 1, qq|[$c] |.$Y.' has 1 record' );
                    is( $K->is_logfile( $Y ), 2, qq|[$c] |.$Y.' is regular log file' );
                }
            }
        }
    }

    BATCHMODE: {
        my $command = $E->perl.$E->command.$O.' -c --batch ';
        my $xresult = qx( $command );
        my $yamlobj = JSON::Syck::Load( $xresult );
        my $thisent = {};

        isa_ok( $yamlobj, 'HASH', '--batch returns YAML(HASH)' );

        foreach my $_sk ( 'user', 'command', 'load' ) {
            ok( $yamlobj->{ $_sk }, $_sk.' = '.$yamlobj->{ $_sk } );
        }

        ok( $yamlobj->{'time'}->{'started'}, 'time->started = '.$yamlobj->{'time'}->{'started'} );
        ok( $yamlobj->{'time'}->{'ended'}, 'time->ended = '.$yamlobj->{'time'}->{'ended'} );
        ok( $yamlobj->{'time'}->{'elapsed'} > -1, 'time->elapsed = '.$yamlobj->{'time'}->{'elapsed'} );

        $thisent = $yamlobj->{'status'}->{'log-files'};
        ok( $thisent->{'all-of-temporary-logs'}, '->all-of-temporary-logs = '.$thisent->{'all-of-temporary-logs'} );
        ok( $thisent->{'size-of-temporary-logs'}, '->size-of-temporary-logs = '.$thisent->{'size-of-temporary-logs'} );

        $thisent = $yamlobj->{'status'}->{'records'};
    }

    POSTPROCESS: {
        File::Copy::copy( $E->output.'.bak', $E->output ) if -s $E->output.'.bak';
        unlink '/tmp/'.File::Basename::basename( $E->output ) if -w '/tmp/'.File::Basename::basename( $E->output );
    }

}


__END__
