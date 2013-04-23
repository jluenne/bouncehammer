# $Id: Cellphone.pm,v 1.1.2.3 2013/04/18 10:56:28 ak Exp $
# Copyright (C) 2009,2010,2013 Cubicroot Co. Ltd.
# Kanadzuchi::Mail::Group::ES::
                                                            
  ####        ###  ###         ##                           
 ##  ##  ####  ##   ##  #####  ##      ####  #####   ####   
 ##     ##  ## ##   ##  ##  ## #####  ##  ## ##  ## ##  ##  
 ##     ###### ##   ##  ##  ## ##  ## ##  ## ##  ## ######  
 ##  ## ##     ##   ##  #####  ##  ## ##  ## ##  ## ##      
  ####   #### #### #### ##     ##  ##  ####  ##  ##  ####   
                        ##                                  
package Kanadzuchi::Mail::Group::ES::Cellphone;
use base 'Kanadzuchi::Mail::Group';
use strict;
use warnings;

#  ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ ____ ____ 
# ||C |||l |||a |||s |||s |||       |||M |||e |||t |||h |||o |||d |||s ||
# ||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
# Cellular phone domains in Kingdom of Spain
# See http://en.wikipedia.org/wiki/List_of_SMS_gateways
# sub communisexemplar { return qr{[.]es\z}; }
sub nominisexemplaria
{
	# *** NOT TESTED YET ***
	my $self = shift;
	return {
		#'altiria' => [
		#	# Altiria | Plataforma SMS y Marketing Móvil; http://www.altiria.com
		#	an email domain not checked
		#],
		'esendex' => [
			# Esendex; http://esendex.es/
			qr{\Aesendex[.]net\z},
		],
		'movistar' => [
			# Telefonica Movistar; http://www.movistar.es/
			qr{\Acorreo[.]movistar[.]net\z},	# ...?
			qr{\Amovistar[.]net\z},
		],
		'vodafone' => [
			# Vodafone; http://www.vodafone.es/ 
			qr{\Avodafone[.]es\z},
		],
	};
}

sub classisnomina
{
	my $class = shift;
	return {
		'esendex'	=> 'Generic',
		'movistar'	=> 'Generic',
		'vodafone'	=> 'Generic',
	};
}

1;
__END__
