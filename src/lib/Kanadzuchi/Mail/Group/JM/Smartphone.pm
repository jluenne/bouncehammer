# $Id: Smartphone.pm,v 1.1.2.5 2013/08/30 08:51:14 ak Exp $
# -Id: SmartPhone.pm,v 1.1 2009/08/29 07:33:22 ak Exp -
# Copyright (C) 2011,2013 Cubicroot Co. Ltd.
# Kanadzuchi::Mail::Group::JM::
                                                                        
  #####                        ##          ##                           
 ###     ##  ##  ####  ##### ###### #####  ##      ####  #####   ####   
  ###    ######     ## ##  ##  ##   ##  ## #####  ##  ## ##  ## ##  ##  
   ###   ######  ##### ##      ##   ##  ## ##  ## ##  ## ##  ## ######  
    ###  ##  ## ##  ## ##      ##   #####  ##  ## ##  ## ##  ## ##      
 #####   ##  ##  ##### ##       ### ##     ##  ##  ####  ##  ##  ####   
                                    ##                                  
package Kanadzuchi::Mail::Group::JM::Smartphone;
use base 'Kanadzuchi::Mail::Group';
use strict;
use warnings;

#  ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ ____ ____ 
# ||C |||l |||a |||s |||s |||       |||M |||e |||t |||h |||o |||d |||s ||
# ||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
# Major company's smaprtphone domains in Jamaica
# See http://www.thegremlinhunt.com/2010/01/07/list-of-blackberry-internet-service-e-mail-login-sites/
# sub communisexemplar { return qr{[.]jm\z}; }
sub nominisexemplaria {
    my $class = shift;
    return {
        'claro' => [
            # Claro Jamaica; http://claro.com.jm/
            qr{\Aclarojm[.]blackberry[.]com\z},
        ],
        'lime' => [
            # LIME Jamaica; http://www.time4lime.com/jm/
            qr{\Acwjamaica[.]blackberry[.](?:com|net)\z},
            qr{\Acw[.]blackberry[.](?:com|net)\z},
        ],
        'digicel' => [
            # Digicel Jamaica Cellular; http://www.digiceljamaica.com/
            qr{\Adigicel[.]blackberry[.]com\z},
        ],
    };
}

1;
__END__
