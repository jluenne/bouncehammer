# $Id: 110_bddr.t,v 1.5.2.1 2013/08/30 23:05:12 ak Exp $
#  ____ ____ ____ ____ ____ ____ ____ ____ ____ 
# ||L |||i |||b |||r |||a |||r |||i |||e |||s ||
# ||__|||__|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
use lib qw(./t/lib ./dist/lib ./src/lib);
use strict;
use warnings;
use Kanadzuchi::Test;
use Kanadzuchi::BdDR;
use Test::More ( 'tests' => 170 );

#  ____ ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ 
# ||G |||l |||o |||b |||a |||l |||       |||v |||a |||r |||s ||
# ||__|||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|
#
my $T = new Kanadzuchi::Test(
    'class' => 'Kanadzuchi::BdDR',
    'methods' => [ 'new', 'setup', 'connect', 'disconnect', 'DESTROY' ],
    'instance' => new Kanadzuchi::BdDR,
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

METHODS: {
    my $object = undef;
    my $config = JSON::Syck::LoadFile( './src/etc/prove.cf' );
    my $therdb = ':memory:';
    my $datasn = q();
    my $rdbset = {
        'PostgreSQL' => { 'driver' => 'Pg', 'port' => 5432 },
        'MySQL' => { 'driver' => 'mysql', 'port' => 3306 },
        'SQLite' => { 'driver' => 'SQLite', 'port' => undef, 'dbname' => $therdb },
    };

    foreach my $d ( keys %$rdbset ) {
        $object = new Kanadzuchi::BdDR;
        $config->{'database'}->{'hostname'} = '127.0.0.1';
        $config->{'database'}->{'dbname'} = $rdbset->{ $d }->{'dbname'} || 'bouncehammer' ;
        $config->{'database'}->{'username'} = 'bouncehammer';
        $config->{'database'}->{'password'} = 'kanadzuchi';
        $config->{'database'}->{'port'} = $rdbset->{ $d }->{'port'};
        $config->{'database'}->{'dbtype'} = $d;

        SETUP: {
            ok( $object->setup( $config->{'database'}, '->setup' ) );

            if( $d eq 'SQLite' ) {

                is( $object->hostname, q(), '->hostname is empty' );
                is( $object->port, q(), '->port is empty ' );
                is( $object->username, q(), '->username is empty' );
                is( $object->password, q(), '->password is empty' );

            } else {
                is( $object->hostname, '127.0.0.1', '->hostname = 127.0.0.1' );
                is( $object->port, $rdbset->{$d}->{port}, '->port = '.$rdbset->{ $d }->{port} );
                is( $object->username, 'bouncehammer', '->username = bouncehammer' );
                is( $object->password, 'kanadzuchi', '->password = kanadzuchi' );
            }
            is( $object->dbtype, $d, '->dbtype = '.$d );
            is( $object->dbname, $config->{'database'}->{'dbname'}, '->dbname = '.$config->{'database'}->{'dbname'} );
            ok( length($object->datasn), '->datasn = '.$object->datasn );
        }

        next unless $d eq 'SQLite';

        SKIP: {
            my $Skip = 2;
            eval { require DBI; }; skip( 'Because no DBI for testing', $Skip ) if $@;
            eval { require DBD::SQLite; }; skip( 'Because no DBD::SQLite for testing', $Skip ) if $@;

            CONNECT: {
                my $dbhx = $object->connect;
                isa_ok( $dbhx, 'DBI::db', '->connect(SQLite)' );
                my $dbhs = $object->disconnect;
                ok( $dbhs, '->disconnect(SQLite)' );
            }
        }
    }

    FAIL: {
        foreach my $e ( 
            @{ $Kanadzuchi::Test::ExceptionalValues },
            @{ $Kanadzuchi::Test::NegativeValues } ) {

            my $argv = defined $e ? sprintf( "%#x", ord $e ) : 'undef';
            my $dbio = Kanadzuchi::BdDR->new->setup($e);
            is( ref( $dbio ), $T->class, '->setup = '.$argv );
            is( $dbio->datasn, undef, '->setup->datasn = ""' );
        }
    }
}

__END__
