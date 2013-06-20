# $Id: 043_mta-us-verizon.t,v 1.1.2.1 2013/06/20 11:36:44 ak Exp $
#  ____ ____ ____ ____ ____ ____ ____ ____ ____ 
# ||L |||i |||b |||r |||a |||r |||i |||e |||s ||
# ||__|||__|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
use lib qw(./t/lib ./dist/lib ./src/lib);
use strict;
use warnings;
use Kanadzuchi::Test;
use Kanadzuchi::MTA::US::Verizon;
use Test::More ( tests => 12 );

#  ____ ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ 
# ||G |||l |||o |||b |||a |||l |||       |||v |||a |||r |||s ||
# ||__|||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|
#
my $Test = new Kanadzuchi::Test(
		'class' => q|Kanadzuchi::MTA::US::Verizon|,
		'methods' => [ 'xsmtpagent', 'xsmtpcommand', 'xsmtpdiagnosis', 
				'xsmtprecipient', 'xsmtpcharset', 'xsmtpstatus', 
				'emailheaders', 'reperit', 'SMTPCOMMAND' ],
		'instance' => undef,
);
my $Head = {
	'subject' => 'Re: test for bounce',
	'from' => 'post_master@vtext.com',
	'received' => [
		'from txslspamp2.vtext.com ([192.0.2.195]) by gargamel.example.com ([192.0.2.146])',
		'from unknown (HELO VZW) ([192.0.2.8]) by txslspamp2.vtext.com with ESMTP; 12 Jun 2013 02:22:13 +0000',
	],
};

#  ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ 
# ||T |||e |||s |||t |||       |||c |||o |||d |||e |||s ||
# ||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|
#
PREPROCESS: {
	can_ok( $Test->class(), @{ $Test->methods } );
	is( $Test->class->xsmtpagent(), 'X-SMTP-Agent: US::Verizon'.qq(\n),
		'->xsmtpagent() = X-SMTP-Agent: US::Verizon' );
	is( $Test->class->xsmtpcommand(), 'X-SMTP-Command: CONN'.qq(\n),
		'->xsmtpcommand() = X-SMTP-Command: CONN' );
	isa_ok( $Test->class->emailheaders(), q|ARRAY|, '->emailheaders = []' );
	is( $Test->class->xsmtpdiagnosis('Test'), 'X-SMTP-Diagnosis: Test'.qq(\n),
		'->xsmtpdiagnosis() = X-SMTP-Diagnosis: Test' );
	is( $Test->class->xsmtpstatus('5.0.911'), 'X-SMTP-Status: 5.0.911'.qq(\n),
		'->xsmtpstatus() = X-SMTP-Status: 5.0.911' );
	is( $Test->class->xsmtprecipient('user@example.jp'), 'X-SMTP-Recipient: user@example.jp'.qq(\n),
		'->xsmtprecipient() = X-SMTP-Recipient: user@example.jp' );
	isa_ok( $Test->class->SMTPCOMMAND(), q|HASH|, '->SMTPCOMMAND = {}' );
}

REPERIT: {
	my $mesgbodypart = q();
	my $pseudoheader = q();

	$mesgbodypart .= $_ while( <DATA> );
	$pseudoheader = $Test->class->reperit( $Head, \$mesgbodypart );
	ok( $pseudoheader );

	foreach my $el ( split("\n", $pseudoheader) )
	{
		next if $el =~ m{\A\z};
		ok( $el, $el ) if $el =~ m{X-SMTP-Command: [A-Z]{4}};
		ok( $el, $el ) if $el =~ m{X-SMTP-Status: };
		ok( $el, $el ) if $el =~ m{Final-Recipient: };
		ok( $el, $el ) if $el =~ m{X-SMTP-Diagnosis: };
	}
}

__DATA__
Received: (qmail 21084 invoked from network); 12 Jun 2013 02:22:14 -0000
Received: from gargamel.example.com (192.0.2.146)
	by athena.internal.example.com with SMTP; 12 Jun 2013 02:22:14 -0000
Received: (qmail 19083 invoked from network); 12 Jun 2013 02:22:13 -0000
Received: from txslspamp2.vtext.com ([192.0.2.195])
	by gargamel.example.com ([192.0.2.146])
	with ESMTP via SSL; 12 Jun 2013 02:22:13 -0000
Received: from unknown (HELO VZW) ([192.0.2.8])
	by txslspamp2.vtext.com with ESMTP; 12 Jun 2013 02:22:13 +0000
From: post_master@vtext.com
To: fail-8603@hg.example.com
Message-ID: <30691869.135848.1371003733023.JavaMail.vmaprod@cocsvmaapp05>
In-Reply-To: <20130612022153.21062.qmail@athena.internal.example.com>
Subject: Re:Test message
MIME-Version: 1.0
Content-Type: multipart/mixed;
boundary="----=_Part_135846_1545588.1371003733022"
Date: 12 Jun 2013 02:21:53 -0000

------=_Part_135846_1545588.1371003733022
Content-Type: multipart/alternative;
boundary="----=_Part_135847_5577927.1371003733022"

------=_Part_135847_5577927.1371003733022
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Error: Invalid user address

Error message below:
550 - Requested action not taken: no such user here

Message details:
  Subject: Test message
  Sent date: Wed Jun 12 02:21:53 GMT 2013
  MAIL FROM: fail-8603@hg.example.com
  RCPT TO: badidea@vtext.com
  From: sgifford@athena.internal.example.com
  CC: recipient list not shown: ;
  Size (in bytes): 39
  Number of lines: 2

------=_Part_135847_5577927.1371003733022--

------=_Part_135846_1545588.1371003733022--
