# $Id: Cellphone.pm,v 1.1.2.1 2013/04/18 10:56:28 ak Exp $
# Copyright (C) 2013 Cubicroot Co. Ltd.
# Kanadzuchi::Mail::Group::UY::
                                                            
  ####        ###  ###         ##                           
 ##  ##  ####  ##   ##  #####  ##      ####  #####   ####   
 ##     ##  ## ##   ##  ##  ## #####  ##  ## ##  ## ##  ##  
 ##     ###### ##   ##  ##  ## ##  ## ##  ## ##  ## ######  
 ##  ## ##     ##   ##  #####  ##  ## ##  ## ##  ## ##      
  ####   #### #### #### ##     ##  ##  ####  ##  ##  ####   
                        ##                                  
package Kanadzuchi::Mail::Group::UY::Cellphone;
use base 'Kanadzuchi::Mail::Group';
use strict;
use warnings;

#  ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ ____ ____ 
# ||C |||l |||a |||s |||s |||       |||M |||e |||t |||h |||o |||d |||s ||
# ||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
# Cellular phone domains in Uruguay
# See http://en.wikipedia.org/wiki/List_of_SMS_gateways
sub communisexemplar { return qr{[.]uy\z}; }
sub nominisexemplaria
{
	my $self = shift;
	return {
		'movistar' => [
			# Movistar; http://www.movistar.com.uy
			qr{\Asms[.]movistar[.]com[.]uy},
		],
	};
}

sub classisnomina
{
	my $class = shift;
	return {
		'movistar'	=> 'Generic',
	};
}

1;
__END__

