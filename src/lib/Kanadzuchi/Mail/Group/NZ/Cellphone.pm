# $Id: Cellphone.pm,v 1.1.2.3 2013/04/18 10:56:28 ak Exp $
# Copyright (C) 2009-2010,2013 Cubicroot Co. Ltd.
# Kanadzuchi::Mail::Group::NZ::
                                                            
  ####        ###  ###         ##                           
 ##  ##  ####  ##   ##  #####  ##      ####  #####   ####   
 ##     ##  ## ##   ##  ##  ## #####  ##  ## ##  ## ##  ##  
 ##     ###### ##   ##  ##  ## ##  ## ##  ## ##  ## ######  
 ##  ## ##     ##   ##  #####  ##  ## ##  ## ##  ## ##      
  ####   #### #### #### ##     ##  ##  ####  ##  ##  ####   
                        ##                                  
package Kanadzuchi::Mail::Group::NZ::Cellphone;
use base 'Kanadzuchi::Mail::Group';
use strict;
use warnings;

#  ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ ____ ____ 
# ||C |||l |||a |||s |||s |||       |||M |||e |||t |||h |||o |||d |||s ||
# ||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
# Cellular phone domains in New Zealand
# See http://en.wikipedia.org/wiki/List_of_SMS_gateways
sub communisexemplar { return qr{[.]nz\z}; }
sub nominisexemplaria
{
	# *** NOT TESTED YET ***
	my $self = shift;
	return {
		'telecomnz' => [
			# Telecom New Zealand; http://www.telecom.co.nz/home/
			qr{\Aetxt[.]co[.]nz\z},
		],
		'vodafone' => [
			# Vodafone; http://www.vodafone.co.nz/
			qr{\Asms[.]vodafone[.]net[.]nz\z},
			qr{\Amtxt[.]co[.]nz\z},
		],
	};
}

sub classisnomina
{
	my $class = shift;
	return {
		'telecomnz'	=> 'Generic',
		'vodafone'	=> 'Generic',
	};
}

1;
__END__
