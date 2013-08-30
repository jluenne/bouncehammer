# $Id: 052_mail-bounced.t,v 1.8.2.4 2013/08/30 23:05:12 ak Exp $
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
use Kanadzuchi::Mail::Bounced;
use Kanadzuchi::Mbox;
use Kanadzuchi::RFC2822;
use Kanadzuchi::String;
use Kanadzuchi::Time;
use Path::Class::Dir;
use Test::More;

#  ____ ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ 
# ||G |||l |||o |||b |||a |||l |||       |||v |||a |||r |||s ||
# ||__|||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|
#
my $T = new Kanadzuchi::Test(
    'class' => 'Kanadzuchi::Mail::Bounced',
    'methods' => [ 
        @{ $Kanadzuchi::Test::Mail::MethodList->{'BaseClass'} },
        @{ $Kanadzuchi::Test::Mail::MethodList->{'Bounced'} },
    ],
    'instance' => new Kanadzuchi::Mail::Bounced,
);

my $ReturnedMesg = [];
my $bHbParser = new Kanadzuchi::Mbox( 'file' => $T->example->stringify.'/17-messages.eml' );
my $nMessages = 37;

#  ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ 
# ||T |||e |||s |||t |||       |||c |||o |||d |||e |||s ||
# ||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|
#
PREPROCESS: {
    isa_ok( $T->instance, $T->class );
    isa_ok( $T->tempdir, 'Path::Class::Dir' );
    isa_ok( $bHbParser, 'Kanadzuchi::Mbox' );
    can_ok( $T->class, @{ $T->methods } );

    $T->tempdir->mkpath unless -e $T->tempdir->stringify;
}

CALL_PARSER: {
    my $mesgtoken = q();
    my $addresser = q();
    my $recipient = q();
    my $damnedobj = {};

    is( $bHbParser->slurpit, $nMessages, 'Kanadzuchi::Mbox->slurpit' );
    is( $bHbParser->nmails, $nMessages, 'The number of emails = '.$nMessages );
    isa_ok( $bHbParser->emails, 'ARRAY' );
    is( $bHbParser->parseit, $nMessages, 'Kanadzuchi::Mbox->parseit' );
    is( $bHbParser->nmesgs, $nMessages, 'The number of messages = '.$nMessages );
    isa_ok( $bHbParser->messages, 'ARRAY' );

    $ReturnedMesg = $T->class->eatit( $bHbParser, [], { 
                        'cache' => $T->tempdir->stringify, 
                        'greed' => 1, 'verbose' => 0 } );
    isa_ok( $ReturnedMesg, 'Kanadzuchi::Iterator' );
    ok( $ReturnedMesg->count, '->count = '.$nMessages );

    PARSE: while( my $_p = $ReturnedMesg->next ) {

        isa_ok( $_p, $T->class );

        EMAIL_ADDRESS: {
            isa_ok( $_p, $T->class );
            isa_ok( $_p->addresser, 'Kanadzuchi::Address' );
            isa_ok( $_p->recipient, 'Kanadzuchi::Address' );

            $addresser = $_p->addresser->address;
            $recipient = $_p->recipient->address;

            ok( Kanadzuchi::RFC2822->is_emailaddress( $addresser ), '->addresser->address is valid: '.$addresser );
            ok( Kanadzuchi::RFC2822->is_domainpart( $_p->addresser->host ), '->addresser->host is valid' );
            is( $_p->addresser->host, $_p->senderdomain, '->addresser->host == senderdomain: '.$_p->senderdomain );

            ok( Kanadzuchi::RFC2822->is_emailaddress( $recipient ), '->recipient->address is valid: '.$recipient );
            ok( Kanadzuchi::RFC2822->is_domainpart( $_p->recipient->host ), '->recipient->host is valid' );
            is( $_p->recipient->host, $_p->destination, '->recipient->host == destination: '.$_p->destination );
        }

        MESSAGETOKEN: {
            $mesgtoken = Kanadzuchi::String->token( $addresser, $recipient );
            is( length( $_p->token ), 32, 'length of token is 32' );
            is( $_p->token, $mesgtoken, '->token is valid: '.$mesgtoken );
        }

        BOUNCED_DATE: {
            isa_ok( $_p->bounced, 'Time::Piece' );
            ok( $_p->bounced->epoch, '->bounced->epoch is valid: '.$_p->bounced->epoch );
            ok( $_p->bounced->year, '->bounced->year is valid: '.$_p->bounced->year );
            ok( $_p->bounced->month, '->bounced->month is valid: '.$_p->bounced->month );
            ok( $_p->bounced->day_of_month, '->bounced->day_of_month is valid: '.$_p->bounced->day_of_month );
            ok( $_p->bounced->day, '->bounced->day is valid: '.$_p->bounced->day );

            like( $_p->bounced->hour, qr{\A\d+\z}, '->bounced->hour is valid: '.$_p->bounced->hour );
            like( $_p->bounced->minute, qr{\A\d+\z}, '->bounced->minute is valid: '.$_p->bounced->minute );
            like( $_p->bounced->second, qr{\A\d+\z}, '->bounced->second is valid: '.$_p->bounced->second );
        }

        REASON: {
            my $id = $T->class->rname2id( $_p->reason );
            my $rn = $T->class->id2rname( $id );

            like( $rn, qr{\A\w+\z}, '->reason is valid: '.$rn );
            ok( $id, 'The ID of '.$rn.' is '.$id );
            is( $_p->reason, $rn, 'The name of ID:'.$id.' is '.$rn );
        }

        HOSTGROUP: {
            ok( $_p->hostgroup, '->hostgroup = '.$_p->hostgroup );
            my $id = $T->class->gname2id( $_p->hostgroup );
            my $cn = $T->class->id2gname( $id );

            like( $cn, qr{\A\w+\z}, '->hostgroup is valid: '.$cn );
            ok( $id, 'The ID of '.$cn.' is '.$id );
            is( $_p->hostgroup, $cn, 'The name of ID:'.$id.' is '.$cn );
        }

        PROVIDER: {
            ok( length $_p->provider, '->provider is valid: '.$_p->provider );
        }

        DESCRIPTION: {
            isa_ok( $_p->description, 'HASH', '->description is HASH' );

            DELIVERY_STATUS: {

                is( $_p->deliverystatus, $_p->description->{'deliverystatus'},
                            '->description->deliverystatus == deliverystatus' );

                foreach my $ds ( $_p->deliverystatus, $_p->description->{'deliverystatus'} ) {

                    like( $ds, qr{\A\d[.]\d[.]\d+\z}, '->deliverystatus is valid: '.$ds );
                    ok( $_p->is_permerror, '->is_permerror('.$ds.')' ) if $ds =~ m{\A5};
                    ok( $_p->is_temperror, '->is_temperror('.$ds.')' ) if $ds =~ m{\A4};
                }
            }

            DIAGNOSTIC_CODE: {

                is( $_p->description->{'diagnosticcode'}, $_p->diagnosticcode, 
                            '->description->diagnosticcode == diagnosticcode' );

                foreach my $dc ( $_p->diagnosticcode, $_p->description->{'diagnosticcode'} ) {

                    like( $dc, qr{\A.*\z}, '->diagnosticcode is valid: '.$dc );
                }
            }

            TIMEZONE_OFFSET: {

                is( $_p->description->{'timezoneoffset'}, $_p->timezoneoffset,
                        '->description->timezoneoffset == timezoneoffset' );

                foreach my $tz ( $_p->timezoneoffset, $_p->description->{'timezoneoffset'} ) {

                    like( $tz, qr{\A[-+]\d{4}\z}, '->timezoneoffset is valid: '.$tz );
                    like( Kanadzuchi::Time->tz2second( $tz ), qr{\d+\z}, 'Kanadzuchi::Time->tz2second('.$tz.')' );
                }
            }

            SMTPAGENT: {
                my $_smtpagents = qr{(?:Sendmail|unknown|qmail|JP::aubyKDDI|)};
                is( $_p->description->{'smtpagent'}, $_p->smtpagent, '->description->smtpagent == smtpagent' );

                foreach my $sa ( $_p->description->{'smtpagent'}, $_p->smtpagent ) {
                    like( $sa, $_smtpagents, '->smtpagent is '.$sa );
                }
            }

            LISTID: {
                is( $_p->description->{'listid'}, $_p->listid, '->description->listid == listid' );

                foreach my $li ( $_p->description->{'listid'}, $_p->listid ) {
                    is( $li, q(), '->listid is empty' );
                }
            }
        }

        is( $_p->frequency, 1, '->frequency == 1' );

        DAMNED: {
            $damnedobj = $_p->damn;
            isa_ok( $damnedobj, 'HASH', '->damn' );
        }
    }
}

done_testing();
__END__
