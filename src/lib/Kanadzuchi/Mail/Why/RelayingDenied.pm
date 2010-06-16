# $Id: RelayingDenied.pm,v 1.6 2010/06/16 12:57:49 ak Exp $
# -Id: RelayingDenied.pm,v 1.1 2009/08/29 07:33:28 ak Exp -
# -Id: RelayingDenied.pm,v 1.2 2009/05/11 08:22:29 ak Exp -
# Copyright (C) 2009,2010 Cubicroot Co. Ltd.
# Kanadzuchi::Mail::Why::
                                                                                             
 #####        ###                 ##                ####                  ##             ##  
 ##  ##  ####  ##   ####  ##  ##      #####   ##### ## ##   ####  #####        ####      ##  
 ##  ## ##  ## ##      ## ##  ## ###  ##  ## ##  ## ##  ## ##  ## ##  ## ###  ##  ##  #####  
 #####  ###### ##   ##### ##  ##  ##  ##  ## ##  ## ##  ## ###### ##  ##  ##  ###### ##  ##  
 ## ##  ##     ##  ##  ##  #####  ##  ##  ##  ##### ## ##  ##     ##  ##  ##  ##     ##  ##  
 ##  ##  #### ####  #####    ##  #### ##  ##     ## ####    ####  ##  ## ####  ####   #####  
                          ####               #####                                           
package Kanadzuchi::Mail::Why::RelayingDenied;
use base 'Kanadzuchi::Mail::Why';

#  ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ ____ ____ 
# ||C |||l |||a |||s |||s |||       |||M |||e |||t |||h |||o |||d |||s ||
# ||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
# Regular expressions of 'Relaying Denied'
sub exemplaria
{
	my $class = shift();
	return [
		qr(relaying denied),					# Sendmail
		qr(that domain isn[']t in my list of allowed rcpthost), # qmail
		qr(relay denied),
		qr(relay not permitted),
		qr(relay access denied),
	];
}



1;
__END__
