# $Id: WebMail.pm,v 1.4.2.3 2013/08/30 08:51:14 ak Exp $
# Copyright (C) 2010,2013 Cubicroot Co. Ltd.
# Kanadzuchi::Mail::Group::CA::
                                                   
 ##  ##         ##     ##  ##           ##  ###    
 ##  ##   ####  ##     ######   ####         ##    
 ##  ##  ##  ## #####  ######      ##  ###   ##    
 ######  ###### ##  ## ##  ##   #####   ##   ##    
 ######  ##     ##  ## ##  ##  ##  ##   ##   ##    
 ##  ##   ####  #####  ##  ##   #####  #### ####   
package Kanadzuchi::Mail::Group::CA::WebMail;
use base 'Kanadzuchi::Mail::Group';
use strict;
use warnings;

#  ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ ____ ____ 
# ||C |||l |||a |||s |||s |||       |||M |||e |||t |||h |||o |||d |||s ||
# ||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
# Major company's Webmail domains in Canada
sub nominisexemplaria {
    my $class = shift;
    return {
        'hush' => [
            # Hushmail http://www.hushmail.com/
            qr{\Ahushmail[.](?:com|me)\z},
            qr{\Ahush[.](?:com|ai)\z},
            qr{\Amac[.]hush[.]com\z},
        ],
        'zworg' => [
            # Zworg.com; https://zworg.com/
            qr{\Azworg[.]com\z},
            qr{\A(?:irk|mailcanada)[.]ca\z},
        ],
    };
}

1;
__END__
