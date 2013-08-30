# $Id: Smartphone.pm,v 1.1.2.6 2013/08/30 08:51:14 ak Exp $
# -Id: SmartPhone.pm,v 1.1 2009/08/29 07:33:22 ak Exp -
# Copyright (C) 2011,2013 Cubicroot Co. Ltd.
# Kanadzuchi::Mail::Group::FR::
                                                                        
  #####                        ##          ##                           
 ###     ##  ##  ####  ##### ###### #####  ##      ####  #####   ####   
  ###    ######     ## ##  ##  ##   ##  ## #####  ##  ## ##  ## ##  ##  
   ###   ######  ##### ##      ##   ##  ## ##  ## ##  ## ##  ## ######  
    ###  ##  ## ##  ## ##      ##   #####  ##  ## ##  ## ##  ## ##      
 #####   ##  ##  ##### ##       ### ##     ##  ##  ####  ##  ##  ####   
                                    ##                                  
package Kanadzuchi::Mail::Group::FR::Smartphone;
use base 'Kanadzuchi::Mail::Group';
use strict;
use warnings;

#  ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ ____ ____ 
# ||C |||l |||a |||s |||s |||       |||M |||e |||t |||h |||o |||d |||s ||
# ||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
# Major company's smaprtphone domains in République Française/French Republic
# sub communisexemplar { return qr{[.]fr\z}; }
sub nominisexemplaria {
    my $class = shift;
    return {
        # orange: see ../Smartphone.pm
        'bouygues' => [
            # Bouygues Telecom; http://www.bouyguestelecom.fr/
            qr{\Abouyguestelecom[.]blackberry[.]com\z},
        ],
        'sfr' => [
            # SFR/La Reunion; http://sfr.re/
            # Vodafone?
            qr{\Asfrre[.]blackberry[.]com\z},
        ],
    };
}

1;
__END__
