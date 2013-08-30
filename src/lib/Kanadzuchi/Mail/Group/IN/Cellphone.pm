# $Id: Cellphone.pm,v 1.1.2.4 2013/08/30 08:51:14 ak Exp $
# Copyright (C) 2009-2010,2013 Cubicroot Co. Ltd.
# Kanadzuchi::Mail::Group::IN::
                                                            
  ####        ###  ###         ##                           
 ##  ##  ####  ##   ##  #####  ##      ####  #####   ####   
 ##     ##  ## ##   ##  ##  ## #####  ##  ## ##  ## ##  ##  
 ##     ###### ##   ##  ##  ## ##  ## ##  ## ##  ## ######  
 ##  ## ##     ##   ##  #####  ##  ## ##  ## ##  ## ##      
  ####   #### #### #### ##     ##  ##  ####  ##  ##  ####   
                        ##                                  
package Kanadzuchi::Mail::Group::IN::Cellphone;
use base 'Kanadzuchi::Mail::Group';
use strict;
use warnings;

#  ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ ____ ____ 
# ||C |||l |||a |||s |||s |||       |||M |||e |||t |||h |||o |||d |||s ||
# ||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
# Cellular phone domains in India
# sub communisexemplar { return qr{[.]in\z}; }
sub nominisexemplaria {
    my $self = shift;
    return {
        'aircel' => [
            # Aircel; http://www.aircel.com/, phone-number@aircel.co.in
            qr{\Aaircel[.]co[.]in\z},
            qr{\Aairsms[.]com\z},
        ],
        'airtel' => [
            # Bharti Airtel; http://www.airtel.com/
            qr{\Aairtel(?:ap|chennai|kerala|kk|kol|mail|mobile)[.]com\z}, 
        ],
        'celforce' => [
            # Gujarat Celforce / Fascel
            qr{\Acelforce[.]com\z},
        ],
        'dehlihutch' => [
            # Delhi Hutch
            qr{\Adelhi[.]hutch[.]co[.]in\z},
        ],
        'escotel' => [
            # Haryana Escotel
            qr{\Aescotelmobile[.]com\z},
        ],
        'rpgcellular' => [
            # Chennai RPG Cellular
            qr{\Arpgmail[.]net\z},
        ],
        'ideacellular' => [
            # !DEA; http://ideacellular.net:80/IDEA.portal
            qr{\Aideacellular[.]net\z},
        ],
        'loopmobile' => [
            # Loop Mobile (Formerly BPL Mobile); http://www.loopmobile.in/
            qr{\Abplmobile[.]com\z},
            qr{\Aloopmobile[.]co[.]in\z},
        ],
    };
}

1;
__END__
