# $Id: Verizon.pm,v 1.1.2.1 2013/06/20 11:36:44 ak Exp $
# Copyright (C) 2013 Scott Gifford
# Copyright (C) 2013 Cubicroot Co. Ltd.
# Kanadzuchi::MTA::US::Verizon
# Based on Kanadzuchi::MTA::US::Vtext at https://github.com/azumakuniyuki/bouncehammer/pull/3,
# https://github.com/scottgifford/bouncehammer/commit/35b32c12e5f1bbfe5ab9165f50a89436bf35e218
package Kanadzuchi::MTA::US::Verizon;
use base 'Kanadzuchi::MTA';
use strict;
use warnings;

#  ____ ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ 
# ||G |||l |||o |||b |||a |||l |||	 |||v |||a |||r |||s ||
# ||__|||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|
#
my $RxVtext = {
	'from' => qr{\Apost_master[@]vtext[.]com\z},
	'received' => qr{by .+[.]vtext[.]com },
	'begin' => qr{\AError message below:\z},
	'endof' => qr{\A--},
};

my $RxVtextErrors = {
	'userunknown' => [
		# The attempted recipient address does not exist.
		qr{550 - Requested action not taken: no such user here},
	],
};

my $RxVzwpix = {
	'from' => qr{[<]?sysadmin[@].+[.]vzwpix[.]com[>]?\z},
	'subject' => qr{Undeliverable Message},
	'received' => qr{by .+[.]vtext[.]com },
	'begin' => qr{\AMessage could not be delivered to mobile},
	'endof' => qr{\A------=ThisIsTheBoundaryString},
};

my $RxVzwpixErrors = {
	'userunknown' => [
		qr{No valid recipients for this MM}
	],
};

#  ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ ____ ____ 
# ||C |||l |||a |||s |||s |||	    |||M |||e |||t |||h |||o |||d |||s ||
# ||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
sub version { '0.0.1' };
sub description { 'Verizon(vtext.com,vzwpix.com)' };
sub xsmtpagent { 'X-SMTP-Agent: US::Verizon'.qq(\n); }
sub reperit
{
	# +-+-+-+-+-+-+-+
	# |r|e|p|e|r|i|t|
	# +-+-+-+-+-+-+-+
	#
	# @Description	Detect an error from Verizon
	# @Param <ref>	(Ref->Hash) Message header
	# @Param <ref>	(Ref->String) Message body
	# @Return	(String) Pseudo header content
	my $class = shift;
	my $mhead = shift || return q();
	my $mbody = shift || return q();
	my $isvzw = q();

	while(1)
	{
		last unless grep { $_ =~ $RxVtext->{'received'} } @{ $mhead->{'received'} };
		$isvzw = 'vtext' if $mhead->{'from'} =~ $RxVtext->{'from'};
		$isvzw = 'vzwpix' if $mhead->{'from'} =~ $RxVzwpix->{'from'};
		last;
	}
	return q() unless $isvzw;

	my $phead = q();	# (String) Pseudo email header
	my $pstat = q();	# (String) #n.n.n Status code in message body
	my $xsmtp = 'DATA';	# (String) SMTP Command in transcript of session
	my $rhostsaid = q();	# (String) Remote host said: ...
	my $rcptintxt = q();	# (String) Recipient address in message body

	if( $isvzw eq 'vtext' )
	{
		#        _            _                        
		# __   _| |_ _____  _| |_   ___ ___  _ __ ___  
		# \ \ / / __/ _ \ \/ / __| / __/ _ \| '_ ` _ \ 
		#  \ V /| ||  __/>  <| |_ | (_| (_) | | | | | |
		#   \_/  \__\___/_/\_\\__(_)___\___/|_| |_| |_|
		#                                              
		# from vtext.com
		EACH_LINE: foreach my $el ( split( qq{\n}, $$mbody ) )
		{
			if( ($el =~ $RxVtext->{'begin'}) .. ($el =~ $RxVtext->{'endof'}) )
			{
				last if( $rhostsaid && $rcptintxt );

				if( length $rhostsaid == 0 && $el =~ /\A(\d{3})\s[-]\s(.*)\z/ )
				{
					# 550 - Requested action not taken: no such user here
					$rhostsaid = $el;
					next;
				} 

				if( length $rcptintxt == 0 && $el =~ /\A\s+RCPT TO: (.*)\z/ )
				{
					# Message details:
					#   Subject: Test message
					#   Sent date: Wed Jun 12 02:21:53 GMT 2013
					#   MAIL FROM: *******@hg.example.com
					#   RCPT TO: *****@vtext.com
					$rcptintxt = $1;
					next;
				}
			}
		} # End of foreach(EACH_LINE)

		return q() unless $rhostsaid;
		return q() unless $rcptintxt;

		foreach my $e ( keys %$RxVtextErrors )
		{
			next unless grep { $rhostsaid =~ $_ } @{ $RxVtextErrors->{ $e } };
			$pstat = Kanadzuchi::RFC3463->status( $e, 'p', 'i' );
			last;
		}
	}
	elsif( $isvzw eq 'vzwpix' )
	{
		#                            _                           
		# __   ________      ___ __ (_)_  __  ___ ___  _ __ ___  
		# \ \ / /_  /\ \ /\ / / '_ \| \ \/ / / __/ _ \| '_ ` _ \ 
		#  \ V / / /  \ V  V /| |_) | |>  < | (_| (_) | | | | | |
		#   \_/ /___|  \_/\_/ | .__/|_/_/\_(_)___\___/|_| |_| |_|
		#                     |_|                                
		# from vzwpix.com
		EACH_LINE: foreach my $el ( split( qq{\n}, $$mbody ) )
		{
			if( ($el =~ $RxVzwpix->{'begin'}) .. ($el =~ $RxVzwpix->{'endof'}) )
			{
				last if( $rhostsaid && $rcptintxt );

				if( length $rhostsaid == 0 && $el =~ /\AError: (.+)\z/ )
				{
					# Message could not be delivered to mobile.
					# Error: No valid recipients for this MM
					$rhostsaid = $1;
					next;
				} 

				if( length $rcptintxt == 0 && $el =~ /\ATo: (.*)\z/ )
				{
					# Original Message:
					# From: *** <****@example.jp>
					# To: #@vzwpix.com
					$rcptintxt = $1;
					next;
				}
			}
		} # End of foreach(EACH_LINE)

		return q() unless $rhostsaid;
		return q() unless $rcptintxt;

		foreach my $e ( keys %$RxVzwpixErrors )
		{
			next unless grep { $rhostsaid =~ $_ } @{ $RxVzwpixErrors->{ $e } };
			$pstat = Kanadzuchi::RFC3463->status( $e, 'p', 'i' );
			last;
		}
	}

	$pstat ||= Kanadzuchi::RFC3463->status( 'undefined', 'p', 'i' );
	$phead	.= __PACKAGE__->xsmtprecipient( $rcptintxt );
	$phead	.= __PACKAGE__->xsmtpstatus( $pstat );
	$phead	.= __PACKAGE__->xsmtpdiagnosis( $rhostsaid );
	$phead	.= __PACKAGE__->xsmtpcommand( $xsmtp );
	$phead	.= __PACKAGE__->xsmtpagent();
	return $phead;
}

1;
__END__
