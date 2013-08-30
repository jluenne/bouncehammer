# $Id: Smartphone.pm,v 1.1.2.4 2013/08/30 08:51:14 ak Exp $
# Copyright (C) 2011,2013 Cubicroot Co. Ltd.
# Kanadzuchi::Mail::Group::IL::
                                                                        
  #####                        ##          ##                           
 ###     ##  ##  ####  ##### ###### #####  ##      ####  #####   ####   
  ###    ######     ## ##  ##  ##   ##  ## #####  ##  ## ##  ## ##  ##  
   ###   ######  ##### ##      ##   ##  ## ##  ## ##  ## ##  ## ######  
    ###  ##  ## ##  ## ##      ##   #####  ##  ## ##  ## ##  ## ##      
 #####   ##  ##  ##### ##       ### ##     ##  ##  ####  ##  ##  ####   
                                    ##                                  
package Kanadzuchi::Mail::Group::IL::Smartphone;
use base 'Kanadzuchi::Mail::Group';
use strict;
use warnings;

#  ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ ____ ____ 
# ||C |||l |||a |||s |||s |||       |||M |||e |||t |||h |||o |||d |||s ||
# ||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
# Major company's smaprtphone domains in Israel
sub communisexemplar { return qr{[.]com\z}; }
sub nominisexemplaria {
    my $class = shift;
    return {
        # Orange: see ../Smartphone.pm
        'cellcom' => [
            # סלקום - דף הבית ; http://www.cellcom.co.il/
            qr{\Acellcom[.]blackberry[.]com\z},
        ],
        'pelephone' => [
            # Pelephone; http://www.pelephone.co.il/
            qr{\Apelephone[.]blackberry[.]com\z},
        ],
    };
}

1;
__END__
