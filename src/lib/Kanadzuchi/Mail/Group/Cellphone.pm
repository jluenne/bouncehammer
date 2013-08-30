# $Id: Cellphone.pm,v 1.1.2.5 2013/08/30 08:51:14 ak Exp $
# Copyright (C) 2009-2013 Cubicroot Co. Ltd.
# Kanadzuchi::Mail::Group::
#                                                             
#   ####        ###  ###         ##                           
#  ##  ##  ####  ##   ##  #####  ##      ####  #####   ####   
#  ##     ##  ## ##   ##  ##  ## #####  ##  ## ##  ## ##  ##  
#  ##     ###### ##   ##  ##  ## ##  ## ##  ## ##  ## ######  
#  ##  ## ##     ##   ##  #####  ##  ## ##  ## ##  ## ##      
#   ####   #### #### #### ##     ##  ##  ####  ##  ##  ####   
#                         ##                                  
package Kanadzuchi::Mail::Group::Cellphone;
use base 'Kanadzuchi::Mail::Group';
use strict;
use warnings;

#  ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ ____ ____ 
# ||C |||l |||a |||s |||s |||       |||M |||e |||t |||h |||o |||d |||s ||
# ||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
# Major cellular phone provider's domains in The World
# https://github.com/cubiclesoft/email_sms_mms_gateways
sub nominisexemplaria {
    my $class = shift;
    return {
        'bulksms' => [
            # BulkSMS International; http://bulksms.net
            qr{\Abulksms[.]net\z},
        ],
        'bulletin' => [
            # BULLETIN; bulletinmessenger.net
            qr{\Abulletinmessenger[.]net\z},
        ],
        'globalstar' => [
            # Globalstar; http://globalstar.com/
            qr{\Amsg[.]globalstarusa[.]com},
        ],
        'iridium' => [
            # Iridium Communications Inc.; http://iridium.com/
            qr{\Amsg[.]iridium[.]com\z},
        ],
        'panaceamobile' => [
            # Panacea Mobile; http://www.panaceamobile.com
            qr{\Aapi[.]panaceamobile[.]com\z},
        ],
        'routomessaging' => [
            # RoutoMessaging; http://www.routomessaging.com
            qr{\Aemail2sms[.]routomessaging[.]com\z},
        ],
    };
}

1;
__END__
