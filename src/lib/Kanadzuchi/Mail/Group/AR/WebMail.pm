# $Id: WebMail.pm,v 1.1.2.4 2013/08/30 08:51:14 ak Exp $
# Copyright (C) 2010,2013 Cubicroot Co. Ltd.
# Kanadzuchi::Mail::Group::AR::
                                                   
 ##  ##         ##     ##  ##           ##  ###    
 ##  ##   ####  ##     ######   ####         ##    
 ##  ##  ##  ## #####  ######      ##  ###   ##    
 ######  ###### ##  ## ##  ##   #####   ##   ##    
 ######  ##     ##  ## ##  ##  ##  ##   ##   ##    
 ##  ##   ####  #####  ##  ##   #####  #### ####   
package Kanadzuchi::Mail::Group::AR::WebMail;
use base 'Kanadzuchi::Mail::Group';
use strict;
use warnings;

#  ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ ____ ____ 
# ||C |||l |||a |||s |||s |||       |||M |||e |||t |||h |||o |||d |||s ||
# ||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
# Major company's Webmail domains in Argentina/Argentine Republic
sub communisexemplar { return qr{[.]ar\z}; }
sub nominisexemplaria {
    my $class = shift;
    return {
        'ciudad' => [
            # Ciudad.com; http://www.ciudad.com.ar/
            qr{\Aciudad[.]com[.]ar\z},
        ],
        'uol' => [
            # UOL; http://www.uolmail.com.ar/
            qr{\Auolsinectis[.]com[.]ar\z},
        ],
    };
}

1;
__END__
