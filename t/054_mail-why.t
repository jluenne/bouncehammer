# $Id: 054_mail-why.t,v 1.8.2.5 2013/08/30 23:05:12 ak Exp $
#  ____ ____ ____ ____ ____ ____ ____ ____ ____ 
# ||L |||i |||b |||r |||a |||r |||i |||e |||s ||
# ||__|||__|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
use lib qw(./t/lib ./dist/lib ./src/lib);
use strict;
use warnings;
use Kanadzuchi::Test;
use Test::More;

#  ____ ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ 
# ||G |||l |||o |||b |||a |||l |||       |||v |||a |||r |||s ||
# ||__|||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|
#
my $Classes = {
    'contenterr'    => 'Kanadzuchi::Mail::Why::ContentError',
    'filtered'      => 'Kanadzuchi::Mail::Why::Filtered',
    'hostunknown'   => 'Kanadzuchi::Mail::Why::HostUnknown',
    'mailboxfull'   => 'Kanadzuchi::Mail::Why::MailboxFull',
    'mailererror'   => 'Kanadzuchi::Mail::Why::MailerError',
    'msgtoobig'     => 'Kanadzuchi::Mail::Why::MesgTooBig',
    'notaccept'     => 'Kanadzuchi::Mail::Why::NotAccept',
    'rejected'      => 'Kanadzuchi::Mail::Why::Rejected',
    'expired'       => 'Kanadzuchi::Mail::Why::Expired',
    'suspend'       => 'Kanadzuchi::Mail::Why::Suspend',
    'relayingdenied'=> 'Kanadzuchi::Mail::Why::RelayingDenied',
    'securityerr'   => 'Kanadzuchi::Mail::Why::SecurityError',
    'systemerror'   => 'Kanadzuchi::Mail::Why::SystemError',
    'systemfull'    => 'Kanadzuchi::Mail::Why::SystemFull',
    'userunknown'   => 'Kanadzuchi::Mail::Why::UserUnknown',
};

my $Strings = {
    'contenterr' => [
        'Message filtered. Please see the faqs section on spam',
        'Blocked by policy: No spam please',
        'Message rejected due to suspected spam content',
        'The message was rejected because it contains prohibited virus or spam content',
    ],
    'filtered' => [
        'due to extended inactivity new mail is not currently being accepted for this mailbox',
    ],
    'hostunknown' => [
        'Recipient address rejected: Unknown domain name',
        'Host Unknown',
    ],
    'mailboxfull' => [
        'Mailbox full',
        'Mailbox is full',
        'Too much mail data',
        'Account is over quota',
        'Account is temporarily over quota',
    ],
    'mailererror' => [
        'X-Unix; 127',
        'Command died with status 9',
    ],
    'mesgtoobig' => [
        'Message size exceeds fixed maximum message size',
        'Message size exceeds fixed limit',
        'Message size exceeds maximum value',
    ],
    'notaccept' => [
        'Name service error for ...',
        'Sorry, Your remotehost looks suspiciously like spammer',
        'we do not accept mail from hosts with dynamic ip or generic dns ptr-records', # MAIL.RU
        'we do not accept mail from dynamic ips', # MAIL.RU
    ],
    'rejected' => [
        'sender rejected',
        'domain of sender address example.jp does not exist',
        'Domain of sender address exampe.int does not exist',
    ],
    'expired' => [
        'delivery time expired',
        'connection timed out in connect',
    ],
    'suspend' => [
        'recipient suspend the service',
        'Sorry your message to neko@example.jp cannot be delivered. This account has been disabled or discontinued',
    ],
    'relayingdenied'=> [ 
        'Relaying denied',
    ],
    'securityerr' => [
        q|553 sorry, that domain isn't in my list of allowed rcpthosts (#5.7.1)|,
    ],
    'systemerror' => [
        'Server configuration error',
        'Local error in processing',
        'mail system configuration error',
        'system config error',
        'Too many hops',
    ],
    'systemfull'    => [ 'Requested mail action aborted: exceeded storage allocation' ],
    'userunknown'   => [
        'user01@example.jp: ...User Unknown',
        'No such mailbox',
        'Recipient address rejected: User unknown in relay recipient table',
        'Recipient address rejected: User unknown in local recipient table',
        'Recipient address rejected: User unknown in virtual mailbox table',
        'Recipient address rejected: User unknown in virtual alias table',
        'Recipient address rejected: Unknown user',
        q|Delivery error: dd this user doesn't have a site account.|,
        'Sorry, User unknown',
        'Sorry, No mailbox here by that name',
        'Mailbox not present',
        'Recipient is not local',
        'Unknown address',
        'Unknown recipient',
    ],
};

my $OtherString = 'This string does not match with any patterns';

#  ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ 
# ||T |||e |||s |||t |||       |||c |||o |||d |||e |||s ||
# ||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|
#
REQUIRE: foreach my $c ( keys %$Classes ){ 
    require_ok( "$Classes->{ $c }" );
}
METHODS: foreach my $c ( keys %$Classes ){
    can_ok( $Classes->{ $c }, 'textumhabet' );
}

# 3. Call class method
CLASS_METHODS: foreach my $c ( keys %$Classes ) {

    MATCH: foreach my $s ( @{ $Strings->{ $c } } ) {
        ok( $Classes->{ $c }->textumhabet( $s ), 
            'Match String by '.$c.'->textumhabet('.$s.')' );
    }

    is( $Classes->{ $c }->textumhabet( $OtherString ), 0, 
        'No Match String by '.$c.'->textumhabet('.$OtherString.')' );

    ZERO: foreach my $z (
        @{ $Kanadzuchi::Test::ExceptionalValues },
        @{ $Kanadzuchi::Test::NegativeValues } ) {

        my $argv = defined $z ? sprintf( "%#x", ord $z ) : 'undef';
        is( $Classes->{ $c }->textumhabet( $z ), 0,
            'No Match String by '.$c.'->textumhabet('.$argv.')' );
    }
}

done_testing();
__END__
