# $Id: WebMail.pm,v 1.1.2.3 2013/08/30 08:51:14 ak Exp $
# Copyright (C) 2010,2013 Cubicroot Co. Ltd.
# Kanadzuchi::Mail::Group::VN::
                                                   
 ##  ##         ##     ##  ##           ##  ###    
 ##  ##   ####  ##     ######   ####         ##    
 ##  ##  ##  ## #####  ######      ##  ###   ##    
 ######  ###### ##  ## ##  ##   #####   ##   ##    
 ######  ##     ##  ## ##  ##  ##  ##   ##   ##    
 ##  ##   ####  #####  ##  ##   #####  #### ####   
package Kanadzuchi::Mail::Group::VN::WebMail;
use base 'Kanadzuchi::Mail::Group';
use strict;
use warnings;

#  ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ ____ ____ 
# ||C |||l |||a |||s |||s |||       |||M |||e |||t |||h |||o |||d |||s ||
# ||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
# Major company's Webmail domains in Socialist Republic of Vietnam
sub communisexemplar { return qr{[.]vn\z}; }
sub nominisexemplaria {
    my $class = shift;
    return {
        'megaplus' => [
            # MegaPlus; http://vnn.vn/
            qr{\Avdc[.]com[.]vn\z},
            qr{\Avnn[.]vn\z},
            qr{\A(?:hn|dng|hcn|fmail|pmail)[.]vnn[.]vn\z},
        ],
    };
}

1;
__END__
