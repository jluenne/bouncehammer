# $Id: Cellphone.pm,v 1.1.2.1 2013/04/18 10:56:28 ak Exp $
# Copyright (C) 2013 Cubicroot Co. Ltd.
# Kanadzuchi::Mail::Group::PA::
                                                            
  ####        ###  ###         ##                           
 ##  ##  ####  ##   ##  #####  ##      ####  #####   ####   
 ##     ##  ## ##   ##  ##  ## #####  ##  ## ##  ## ##  ##  
 ##     ###### ##   ##  ##  ## ##  ## ##  ## ##  ## ######  
 ##  ## ##     ##   ##  #####  ##  ## ##  ## ##  ## ##      
  ####   #### #### #### ##     ##  ##  ####  ##  ##  ####   
                        ##                                  
package Kanadzuchi::Mail::Group::PA::Cellphone;
use base 'Kanadzuchi::Mail::Group';
use strict;
use warnings;

#  ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ ____ ____ 
# ||C |||l |||a |||s |||s |||       |||M |||e |||t |||h |||o |||d |||s ||
# ||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
# Cellular phone domains in Panama
# sub communisexemplar { return qr{[.]pa\z}; }
sub nominisexemplaria
{
	my $self = shift;
	return {
		'cwmovil' => [
			# Cable & Wireless Panama; http://www.cwmovil.com/
			qr{\Acwmovil[.]com\z},
		],
	};
}

sub classisnomina
{
	my $class = shift;
	return {
		'cwmovil'	=> 'Generic',
	};
}

1;
__END__



