# $Id: Smartphone.pm,v 1.1.2.4 2013/08/30 08:51:14 ak Exp $
# -Id: SmartPhone.pm,v 1.1 2009/08/29 07:33:22 ak Exp -
# Copyright (C) 2011,2013 Cubicroot Co. Ltd.
# Kanadzuchi::Mail::Group::SE::
                                                                        
  #####                        ##          ##                           
 ###     ##  ##  ####  ##### ###### #####  ##      ####  #####   ####   
  ###    ######     ## ##  ##  ##   ##  ## #####  ##  ## ##  ## ##  ##  
   ###   ######  ##### ##      ##   ##  ## ##  ## ##  ## ##  ## ######  
    ###  ##  ## ##  ## ##      ##   #####  ##  ## ##  ## ##  ## ##      
 #####   ##  ##  ##### ##       ### ##     ##  ##  ####  ##  ##  ####   
                                    ##                                  
package Kanadzuchi::Mail::Group::SE::Smartphone;
use base 'Kanadzuchi::Mail::Group';
use strict;
use warnings;

#  ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ ____ ____ 
# ||C |||l |||a |||s |||s |||       |||M |||e |||t |||h |||o |||d |||s ||
# ||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
# Major company's smaprtphone domains in Kingdom of Sweden/Konungariket Sverige
# http://www.thegremlinhunt.com/2010/01/07/list-of-blackberry-internet-service-e-mail-login-sites/
sub communisexemplar { return qr{[.]com\z}; }
sub nominisexemplaria {
    my $class = shift;
    return {
        'tele2' => [
            # Tele2; http://tele2.se/
            qr{\Atele2se[.]blackberry[.]com\z},
        ],
        'telenor' => [
            # Telenor Sverige; http://www.telenor.se/
            qr{\Atelenor-se[.]blackberry[.]com\z},
        ],
        'three' => [
            # 3; http://tre.se/
            qr{\Atre[.]blackberry[.]com\z}, # ...?
        ],
    };
}

1;
__END__
