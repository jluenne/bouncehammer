# $Id: WebMail.pm,v 1.4.2.5 2013/08/30 08:51:14 ak Exp $
# Copyright (C) 2010,2012-2013 Cubicroot Co. Ltd.
# Kanadzuchi::Mail::Group::DE::
                                                   
 ##  ##         ##     ##  ##           ##  ###    
 ##  ##   ####  ##     ######   ####         ##    
 ##  ##  ##  ## #####  ######      ##  ###   ##    
 ######  ###### ##  ## ##  ##   #####   ##   ##    
 ######  ##     ##  ## ##  ##  ##  ##   ##   ##    
 ##  ##   ####  #####  ##  ##   #####  #### ####   
package Kanadzuchi::Mail::Group::DE::WebMail;
use base 'Kanadzuchi::Mail::Group';
use strict;
use warnings;

#  ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ ____ ____ 
# ||C |||l |||a |||s |||s |||       |||M |||e |||t |||h |||o |||d |||s ||
# ||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
# Major company's Webmail domains in Germany(Bundesrepublik Deutschland)
# sub communisexemplar { return qr{[.]de\z}; }
sub nominisexemplaria {
    my $class = shift;
    return {
        # GMX - http://www.gmx.net/
        'gmx' => [
            qr{\Agmx[.](?:com|net|org|info|biz|name)\z},
            qr{\Agmx[.]co[.](?:in|uk)\z},
            qr{\Agmx[.]com[.](?:br|my|tr)\z},
            qr{\Agmx[.](?:at|ca|cc|ch|cn|co|de|es|eu|fr|hk|ie|it)\z},
            qr{\Agmx[.](?:li|lu|ph|pt|ru|se|sg|tm|tw|us)\z},
            qr{\Acaramail[.]com\z}, # GMX Caramail
        ],
    };
}

1;
__END__
