# $Id: 050_mail.t,v 1.12.2.3 2013/08/30 23:05:12 ak Exp $
#  ____ ____ ____ ____ ____ ____ ____ ____ ____ 
# ||L |||i |||b |||r |||a |||r |||i |||e |||s ||
# ||__|||__|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
use lib qw(./t/lib ./dist/lib ./src/lib);
use strict;
use warnings;
use Kanadzuchi::Test;
use Kanadzuchi::Test::Mail;
use Kanadzuchi::Mail;
use Kanadzuchi::String;
use Test::More;

#  ____ ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ 
# ||G |||l |||o |||b |||a |||l |||       |||v |||a |||r |||s ||
# ||__|||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|
#
my $T = new Kanadzuchi::Test(
    'class' => 'Kanadzuchi::Mail',
    'methods' => [ @{ $Kanadzuchi::Test::Mail::MethodList->{'BaseClass'} } ],
    'instance' => new Kanadzuchi::Mail(),
);

my $Suite = {
    'hostgroups' => [
        { 'recipient' => 'POSTMASTER@localhost.localdomain', 'hostgroup' => 'local', 'provider' => 'local', },
        { 'recipient' => 'POSTMASTER@example.jp', 'hostgroup' => 'example', 'provider' => 'example', },

        { 'recipient' => 'POSTMASTER@ovi.com', 'hostgroup' => 'webmail', 'provider' => 'nokia', },
        { 'recipient' => 'POSTMASTER@mail.ru', 'hostgroup' => 'webmail', 'provider' => 'runet', },
        { 'recipient' => 'POSTMASTER@inbox.ru', 'hostgroup' => 'webmail', 'provider' => 'runet', },
        { 'recipient' => 'POSTMASTER@mac.com', 'hostgroup' => 'webmail', 'provider' => 'apple', },
        { 'recipient' => 'POSTMASTER@me.com', 'hostgroup' => 'webmail', 'provider' => 'apple', },

        { 'recipient' => 'POSTMASTER@yahoo.com', 'hostgroup' => 'webmail', 'provider' => 'yahoo', },
        { 'recipient' => 'POSTMASTER@yahoo.co.jp', 'hostgroup' => 'webmail', 'provider' => 'yahoo', },
        { 'recipient' => 'POSTMASTER@ymail.com', 'hostgroup' => 'webmail', 'provider' => 'yahoo', },
        { 'recipient' => 'POSTMASTER@rocketmail.com', 'hostgroup' => 'webmail', 'provider' => 'yahoo', },
        { 'recipient' => 'POSTMASTER@ilove-pooh.jp', 'hostgroup' => 'webmail', 'provider' => 'yahoo', },

        { 'recipient' => 'POSTMASTER@hotmail.com', 'hostgroup' => 'webmail', 'provider' => 'microsoft', },
        { 'recipient' => 'POSTMASTER@msn.com', 'hostgroup' => 'webmail', 'provider' => 'microsoft', },
        { 'recipient' => 'POSTMASTER@msnhotmail.com', 'hostgroup' => 'webmail', 'provider' => 'microsoft', },
        { 'recipient' => 'POSTMASTER@live.com', 'hostgroup' => 'webmail', 'provider' => 'microsoft', },
        { 'recipient' => 'POSTMASTER@live.jp', 'hostgroup' => 'webmail', 'provider' => 'microsoft', },
        { 'recipient' => 'POSTMASTER@windowslive.com', 'hostgroup' => 'webmail', 'provider' => 'microsoft', },

        { 'recipient' => 'POSTMASTER@aol.com', 'hostgroup' => 'webmail', 'provider' => 'aol', },
        { 'recipient' => 'POSTMASTER@aol.jp', 'hostgroup' => 'webmail', 'provider' => 'aol', },
        { 'recipient' => 'POSTMASTER@aol.co.uk', 'hostgroup' => 'webmail', 'provider' => 'aol', },

        { 'recipient' => 'POSTMASTER@gmail.com', 'hostgroup' => 'webmail', 'provider' => 'google', },
        { 'recipient' => 'POSTMASTER@googlemail.com', 'hostgroup' => 'webmail', 'provider' => 'google', },

        { 'recipient' => 'POSTMASTER@i.softbank.jp', 'hostgroup' => 'smartphone', 'provider' => 'softbank', },
        { 'recipient' => 'POSTMASTER@emnet.ne.jp', 'hostgroup' => 'smartphone', 'provider' => 'emobile', },
        { 'recipient' => 'POSTMASTER@willcom.com', 'hostgroup' => 'smartphone', 'provider' => 'willcom', },
        { 'recipient' => 'POSTMASTER@pdx.ne.jp', 'hostgroup' => 'smartphone', 'provider' => 'willcom', },
        { 'recipient' => 'POSTMASTER@mopera.ne.jp', 'hostgroup' => 'smartphone', 'provider' => 'nttdocomo', },
        { 'recipient' => 'POSTMASTER@docomo.blackberry.com', 'hostgroup' => 'smartphone', 'provider' => 'nttdocomo', },

        { 'recipient' => 'POSTMASTER@docomo.ne.jp', 'hostgroup' => 'cellphone', 'provider' => 'nttdocomo', },
        { 'recipient' => 'POSTMASTER@ezweb.ne.jp', 'hostgroup' => 'cellphone', 'provider' => 'aubykddi', },
        { 'recipient' => 'POSTMASTER@d.vodafone.ne.jp', 'hostgroup' => 'cellphone', 'provider' => 'softbank', },
        { 'recipient' => 'POSTMASTER@softbank.ne.jp', 'hostgroup' => 'cellphone', 'provider' => 'softbank', },
        { 'recipient' => 'POSTMASTER@jp-d.ne.jp', 'hostgroup' => 'cellphone', 'provider' => 'softbank', },
        { 'recipient' => 'POSTMASTER@disney.ne.jp', 'hostgroup' => 'cellphone', 'provider' => 'disney', },
    ],
};

#  ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ 
# ||T |||e |||s |||t |||       |||c |||o |||d |||e |||s ||
# ||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|
#
PREPROCESS: {
    isa_ok( $T->instance, $T->class );
    can_ok( $T->class, @{ $T->methods } );
}

CLASS_METHODS: {

    CONSTRUCTOR: {
        my $email = 'POSTMASTER@BOUNCEHAMMER.JP';

        foreach my $m ( 'addresser', 'recipient' ) {

            my $object_x = new Kanadzuchi::Mail( $m => $email, 'bounced' => 166222661 );
            my $object_y = new Kanadzuchi::Mail( 
                    $m => new Kanadzuchi::Address( 'address' => $email ), 'bounced' => 166222661 );

            foreach my $o ( $object_x, $object_y )
            {
                isa_ok( $o, $T->class );
                isa_ok( $o->$m, 'Kanadzuchi::Address', '->'.$m.' is Kanadzuchi::Address' );
                isa_ok( $o->bounced, 'Time::Piece', '->bounced is Time::Piece' );
                isa_ok( $o->description, 'HASH', '->description is HASH' );

                if( $m eq 'addresser' )
                {
                    is( $o->addresser->address, lc $email, '->addresser->address == '.$email );
                    is( $o->senderdomain, q(bouncehammer.jp), '->senderdomain == bouncehammer.jp' );
                }
                
                if( $m eq 'recipient' )
                {
                    is( $o->recipient->address, lc $email, '->recipient->address == '.$email );
                    is( $o->destination, 'bouncehammer.jp', '->destination == bouncehammer.jp' )
                }

                is( $o->bounced->year, 1975, '->bounced->year == 1975' );
                is( $o->bounced->second, 41, '->bounced->second == 41' );
                is( $o->timezoneoffset, '+0000', '->timezoneoffset == +0000' );
                is( $o->frequency, 1, '->frequency == 1' );
                is( $o->reason, q(), '->reason is empty' );
                is( $o->hostgroup, q(), '->hostgroup is empty' );
                is( $o->diagnosticcode, q(), '->diagnosticcode is empty' );
                is( $o->deliverystatus, q(), '->deliverystatus is empty' );
                is( $o->smtpagent, q(), '->smtpagent is empty' );
                is( $o->listid, q(), '->listid is empty' );
            }
        }
    }

    ID_TO_HOSTGROUPNAME: {

        is( $T->class->id2gname(8), 'smartphone', $T->class.'->id2gname(smartphone)' );
        is( $T->class->id2gname(0), '', $T->class.'->id2gname(0)' );
        is( $T->class->id2gname(36), '', $T->class.'->id2gname(36)' );
        ok( $T->class->id2gname('@'), $T->class.'->id2gname(@), Get key names' );

        ZERO_VALUES: foreach my $z ( @{ $Kanadzuchi::Test::ExceptionalValues } ) {

            my $argv = defined $z ? sprintf( "%#x", ord $z ) : 'undef';
            is( $T->class->id2gname( $z ), q(), $T->class.'->id2gname('.$argv.')' );
        }

        NEGATIVE_VALUES: foreach my $n ( @{ $Kanadzuchi::Test::NegativeValues } ) {
            is( $T->class->id2gname( $n ), q(), $T->class.'->id2gname('.$n.')' );
        }
    }

    HOSTGROUPNAME_TO_ID: {

        is( $T->class->gname2id('cellphone'), 7, $T->class.'->gname2id(cellphone)' );
        is( $T->class->gname2id('null'), 0, $T->class.'->gname2id(null)' );
        ok( $T->class->gname2id('@'), $T->class.'->gname2id(@), Get values' );

        ZERO_VALUES: foreach my $z ( @{ $Kanadzuchi::Test::ExceptionalValues } ) {
            my $argv = defined $z ? sprintf( "%#x", ord $z ) : 'undef';
            is( $T->class->gname2id( $z ), 0, $T->class.'->gname2id('.$argv.')' );
        }

        NEGATIVE_VALUES: foreach my $n ( @{ $Kanadzuchi::Test::NegativeValues } ) {
            is( $T->class->gname2id( $n ), 0, $T->class.'->gname2id('.$n.')' );
        }
    }

    ID_TO_REASON: {

        is( $T->class->id2rname(9), 'mailboxfull', $T->class.'->id2rname(9)' );
        is( $T->class->id2rname(0), '', $T->class.'->id2rname(0)' );
        is( $T->class->id2rname(81), '', $T->class.'->id2rname(81)' );
        ok( $T->class->id2rname('@'), $T->class.'->id2rname(@), Get key names' );

        ZERO_VALUES: foreach my $z ( @{ $Kanadzuchi::Test::ExceptionalValues } ) {
            my $argv = defined $z ? sprintf( "%#x", ord $z ) : 'undef';
            is( $T->class->id2rname( $z ), q(), $T->class.'->id2rname('.$argv.')' );
        }

        NEGATIVE_VALUES: foreach my $n ( @{ $Kanadzuchi::Test::NegativeValues } )
        {
            is( $T->class->id2rname( $n ), q(), $T->class.'->id2rname('.$n.')' );
        }
    }

    REASON_TO_ID: {
        is( $T->class->rname2id('filtered'), 5, $T->class.'->gname2id(filtered)' );
        is( $T->class->rname2id('null'), 0, $T->class.'->gname2id(null)' );
        ok( $T->class->rname2id('@'), $T->class.'->rname2id(@), Get values' );

        ZERO_VALUES: foreach my $z ( @{ $Kanadzuchi::Test::ExceptionalValues } ) {
            my $argv = defined $z ? sprintf( "%#x", ord $z ) : 'undef';
            is( $T->class->rname2id( $z ), 0, $T->class.'->rname2id('.$argv.')' );
        }

        NEGATIVE_VALUES: foreach my $n ( @{ $Kanadzuchi::Test::NegativeValues } ) {
            is( $T->class->rname2id( $n ), 0, $T->class.'->rname2id('.$n.')' );
        }
    }
}

INSTANCE_METHODS: {
    my $object = undef;
    my $mtoken = q();
    my $sender = 'POSTMASTER@CUBICROOT.JP';
    my $prefix = '.MIL';
    my $damned = {};

    SUCCESS: foreach my $c ( @{ $Suite->{'hostgroups'} } ) {

        next unless $c->{'recipient'};

        $mtoken = Kanadzuchi::String->token( $sender, $c->{'recipient'} );
        $object = new Kanadzuchi::Mail(
                    'addresser' => $sender,
                    'recipient' => $c->{'recipient'},
                    'hostgroup' => $c->{'hostgroup'},
                    'provider' => $c->{'provider'},
                );

        isa_ok( $object, $T->class );
        isa_ok( $object->addresser, 'Kanadzuchi::Address' );
        isa_ok( $object->recipient, 'Kanadzuchi::Address' );

        is( $object->token, $mtoken, '->token == '.$mtoken );
        is( $object->senderdomain, $object->addresser->host, '->senderdomain == addresser->host' );
        is( $object->destination, $object->recipient->host, '->destination == recipient->host' );
        is( $object->provider, $c->{'provider'}, '->provider == '.$c->{'provider'} );
    }

    FAILURE: foreach my $c ( @{ $Suite->{'hostgroups'} } ) {
        next unless $c->{'recipient'};

        $mtoken = Kanadzuchi::String->token( $sender, $c->{'recipient'}.$prefix );
        $object = new Kanadzuchi::Mail(
                    'addresser' => $sender,
                    'recipient' => $c->{'recipient'}.$prefix
                );
        isa_ok( $object, $T->class );
        isa_ok( $object->addresser, 'Kanadzuchi::Address' );
        isa_ok( $object->recipient, 'Kanadzuchi::Address' );

        is( $object->token, $mtoken, '->token == '.$mtoken );
    }

    OTHER_PROPERTIES: {
        is( $T->instance->frequency, 1, $T->class.'->frequency' );
    }

    DAMNED: {
        $damned = $object->damn;
        isa_ok( $damned, 'HASH', $T->class.'->damn' );
    }
}

done_testing();
__END__

