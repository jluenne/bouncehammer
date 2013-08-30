# $Id: Cellphone.pm,v 1.1.2.4 2013/08/30 08:51:14 ak Exp $
# Copyright (C) 2009,2010,2013 Cubicroot Co. Ltd.
# Kanadzuchi::Mail::Group::AU::
                                                            
  ####        ###  ###         ##                           
 ##  ##  ####  ##   ##  #####  ##      ####  #####   ####   
 ##     ##  ## ##   ##  ##  ## #####  ##  ## ##  ## ##  ##  
 ##     ###### ##   ##  ##  ## ##  ## ##  ## ##  ## ######  
 ##  ## ##     ##   ##  #####  ##  ## ##  ## ##  ## ##      
  ####   #### #### #### ##     ##  ##  ####  ##  ##  ####   
                        ##                                  
package Kanadzuchi::Mail::Group::AU::Cellphone;
use base 'Kanadzuchi::Mail::Group';
use strict;
use warnings;

#  ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ ____ ____ 
# ||C |||l |||a |||s |||s |||       |||M |||e |||t |||h |||o |||d |||s ||
# ||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
# Cellular phone domains in Commonwealth of Australia
# See http://en.wikipedia.org/wiki/List_of_SMS_gateways
# sub communisexemplar { return qr{[.]au\z}; }
sub nominisexemplaria {
    # *** NOT TESTED YET ***
    my $self = shift;
    return {
        'itcompany' => [
            # All Australian Mobile Networks 
            qr{\Asms[.]itcompany[.]com[.]au\z},
        ],
        'smsbroadcast' => [
            # SMS Broadcast;  https://www.smsbroadcast.com.au
            qr{\Asend[.]smsbroadcast[.]com[.]au\z},
        ],
        'smscentral' => [
            # SMS Central; http://www.smscentral.com.au
            qr{\Asms[.]smscentral[.]com[.]au\z}
        ],
        'smspup' => [
            # SMSPUP; http://smspup.com
            qr{\Asmspup[.]com\z},
        ],
        't-mobile' => [
            # SingTel Optus Pty Limited; http://www.optus.com.au/
            qr{\Aoptusmobile[.]com[.]au\z},
        ],
        'telstra' => [
            # Telstra; http://www.telstra.com.au/
            qr{\A(?:sms[.])?tim[.]telstra[.]com\z},
        ],
        'utbox' => [
            # UTBox; http://www.utbox.net
            qr{\Asms[.]utbox[.]net\z},
        ],
    };
}

1;
__END__
