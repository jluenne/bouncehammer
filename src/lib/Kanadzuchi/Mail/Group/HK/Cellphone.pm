# $Id: Cellphone.pm,v 1.1.2.2 2013/08/30 08:51:14 ak Exp $
# Copyright (C) 2013 Cubicroot Co. Ltd.
# Kanadzuchi::Mail::Group::HK::
                                                            
  ####        ###  ###         ##                           
 ##  ##  ####  ##   ##  #####  ##      ####  #####   ####   
 ##     ##  ## ##   ##  ##  ## #####  ##  ## ##  ## ##  ##  
 ##     ###### ##   ##  ##  ## ##  ## ##  ## ##  ## ######  
 ##  ## ##     ##   ##  #####  ##  ## ##  ## ##  ## ##      
  ####   #### #### #### ##     ##  ##  ####  ##  ##  ####   
                        ##                                  
package Kanadzuchi::Mail::Group::HK::Cellphone;
use base 'Kanadzuchi::Mail::Group';
use strict;
use warnings;

#  ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ ____ ____ 
# ||C |||l |||a |||s |||s |||       |||M |||e |||t |||h |||o |||d |||s ||
# ||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
# Cellular phone domains in Hong Kong
sub communisexemplar { return qr{[.]com\z}; }
sub nominisexemplaria {
    my $self = shift;
    return {
        'accessyou' => [
            # http://www.accessyou.com
            qr{\Amessaging[.]accessyou[.]com\z},
        ],
        'hkcsl' => [
            # Hong Kong CSL Limited/香港移動通訊有限公司; 
            # http://www.hkcsl.com/en/index/index.jsp
            qr{\Amgw[.]mmsc1[.]hkcsl[.]com\z},
        ],
    };
}

1;
__END__
