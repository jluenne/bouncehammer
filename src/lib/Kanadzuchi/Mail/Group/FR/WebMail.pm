# $Id: WebMail.pm,v 1.1.2.7 2013/08/30 08:51:14 ak Exp $
# Copyright (C) 2010,2013 Cubicroot Co. Ltd.
# Kanadzuchi::Mail::Group::FR::
                                                   
 ##  ##         ##     ##  ##           ##  ###    
 ##  ##   ####  ##     ######   ####         ##    
 ##  ##  ##  ## #####  ######      ##  ###   ##    
 ######  ###### ##  ## ##  ##   #####   ##   ##    
 ######  ##     ##  ## ##  ##  ##  ##   ##   ##    
 ##  ##   ####  #####  ##  ##   #####  #### ####   
package Kanadzuchi::Mail::Group::FR::WebMail;
use base 'Kanadzuchi::Mail::Group';
use strict;
use warnings;

#  ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ ____ ____ 
# ||C |||l |||a |||s |||s |||       |||M |||e |||t |||h |||o |||d |||s ||
# ||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
# Major company's Webmail domains in French Republic
# sub communisexemplar { return qr{[.]fr\z}; }
sub nominisexemplaria {
    my $class = shift;
    return {
        'sfr' => [
            # SFR; http://www.sfr.fr/
            qr{\A(?:cario|guideo)[.]fr\z},
            qr{\A(?:mageos|waika9)[.]com\z},
            qr{\Afnac[.]net\z},
            qr{\Asfr[.]fr\z},
        ],
        'voila' => [
            # http://www.voila.fr/
            qr{\Avoila[.]fr\z},
        ],
    };
}

1;
__END__
