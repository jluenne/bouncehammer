# $Id: Smartphone.pm,v 1.1.2.4 2013/08/30 08:51:14 ak Exp $
# -Id: SmartPhone.pm,v 1.1 2009/08/29 07:33:22 ak Exp -
# Copyright (C) 2011,2013 Cubicroot Co. Ltd.
# Kanadzuchi::Mail::Group::DE::
                                                                        
  #####                        ##          ##                           
 ###     ##  ##  ####  ##### ###### #####  ##      ####  #####   ####   
  ###    ######     ## ##  ##  ##   ##  ## #####  ##  ## ##  ## ##  ##  
   ###   ######  ##### ##      ##   ##  ## ##  ## ##  ## ##  ## ######  
    ###  ##  ## ##  ## ##      ##   #####  ##  ## ##  ## ##  ## ##      
 #####   ##  ##  ##### ##       ### ##     ##  ##  ####  ##  ##  ####   
                                    ##                                  
package Kanadzuchi::Mail::Group::DE::Smartphone;
use base 'Kanadzuchi::Mail::Group';
use strict;
use warnings;

#  ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ ____ ____ 
# ||C |||l |||a |||s |||s |||       |||M |||e |||t |||h |||o |||d |||s ||
# ||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
# Major company's smaprtphone domains in Germany(Bundesrepublik Deutschland)
# See http://www.thegremlinhunt.com/2010/01/07/list-of-blackberry-internet-service-e-mail-login-sites/
# sub communisexemplar { return qr{[.]de\z}; }
sub nominisexemplaria {
    my $class = shift;
    return {
        'e-plus' => [
            # E-Plus; http://www.eplus.de/
            qr{\Aeplus[.]blackberry[.]com\z},
        ],
        'o2' => [
            # Telefonica; o2online.de
            qr{\Ao2[.]blackberry[.]de\z},
        ],
        't-mobile' => [
            # T-Mobile; http://www.t-mobile.de/
            qr{\Ainstantemail[.]t-mobile[.]de\z},
        ],
    };
}

1;
__END__
