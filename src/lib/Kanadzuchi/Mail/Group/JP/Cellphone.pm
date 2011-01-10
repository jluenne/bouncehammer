# $Id: Cellphone.pm,v 1.7.2.2 2011/01/10 08:18:44 ak Exp $
# Copyright (C) 2009,2010 Cubicroot Co. Ltd.
# Kanadzuchi::Mail::Group::JP::
                                                            
  ####        ###  ###         ##                           
 ##  ##  ####  ##   ##  #####  ##      ####  #####   ####   
 ##     ##  ## ##   ##  ##  ## #####  ##  ## ##  ## ##  ##  
 ##     ###### ##   ##  ##  ## ##  ## ##  ## ##  ## ######  
 ##  ## ##     ##   ##  #####  ##  ## ##  ## ##  ## ##      
  ####   #### #### #### ##     ##  ##  ####  ##  ##  ####   
                        ##                                  
package Kanadzuchi::Mail::Group::JP::Cellphone;
use base 'Kanadzuchi::Mail::Group';
use strict;
use warnings;

#  ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ ____ ____ 
# ||C |||l |||a |||s |||s |||       |||M |||e |||t |||h |||o |||d |||s ||
# ||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
# Cellular phone domains in Japan
sub communisexemplar { return qr{[.]ne[.]jp\z}; }
sub nominisexemplaria
{
	my $self = shift();
	return {
		'nttdocomo' => [ 
			qr{\Adocomo[.]ne[.]jp\z},
		],
		'aubykddi'  => [
			qr{\Aezweb[.]ne[.]jp\z},
			qr{\A[0-9a-z]{2}[.]ezweb[.]ne[.]jp\z},
			qr{\A[0-9a-z][-0-9a-z]{0,8}[0-9a-z][.]biz[.]ezweb[.]ne[.]jp\z},
			qr{\Aido[.]ne[.]jp\z},
			qr{\Aez[a-j][.]ido[.]ne[.]jp\z},
		],
		'softbank'  => [
			qr{\Asoftbank[.]ne[.]jp\z},
			qr{\A[dhtcrksnq][.]vodafone[.]ne[.]jp\z},
			qr{\Ajp-[dhtcrksnq][.]ne[.]jp\z},
			qr{\Adisney[.]ne[.]jp\z},
		],
		'vertu' => [
			# VERTU http://www.vertu.com/jp-jp/home
			qr{\Avertuclub[.]ne[.]jp\z},
		],
		'tu-ka' => [
			qr{\Asky[.](?:tkk|tkc|tu-ka)[.]ne[.]jp\z},
		],
	};
}

sub classisnomina
{
	my $class = shift();
	return {
		'nttdocomo'	=> 'Generic',
		'aubykddi'	=> 'Generic',
		'softbank'	=> 'Generic',
		'vertu'		=> 'Generic',
		'tu-ka'		=> 'Generic',
	};
}

1;
__END__
