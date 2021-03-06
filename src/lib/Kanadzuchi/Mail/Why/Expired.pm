# $Id: Expired.pm,v 1.1.2.6 2014/07/28 05:24:40 ak Exp $
# Copyright (C) 2009,2010,2013,2014 Cubicroot Co. Ltd.
# Kanadzuchi::Mail::Why::
                                                                                    
  ####                 ##                 ##   ######                               
 ##  ##  ####  ##### ###### ####  ##### ###### ##      #####  #####   ####  #####   
 ##     ##  ## ##  ##  ##  ##  ## ##  ##  ##   ####    ##  ## ##  ## ##  ## ##  ##  
 ##     ##  ## ##  ##  ##  ###### ##  ##  ##   ##      ##     ##     ##  ## ##      
 ##  ## ##  ## ##  ##  ##  ##     ##  ##  ##   ##      ##     ##     ##  ## ##      
  ####   ####  ##  ##   ### ####  ##  ##   ### ######  ##     ##      ####  ##      
package Kanadzuchi::Mail::Why::Expired;
use base 'Kanadzuchi::Mail::Why';

#  ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ ____ ____ 
# ||C |||l |||a |||s |||s |||       |||M |||e |||t |||h |||o |||d |||s ||
# ||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
# Regular expressions of 'Expired'
sub exemplaria {
    my $class = shift;
    return [ 
        qr/connection timed out in connect/,
        qr/delivery time expired/,
        qr/retry time not reached for any host after a long failure period/,
        qr/temporary system problem[.] try again later/,
        qr/timeout [-] closing connection/,
        qr/try again later, closing connection/,
    ];
}

1;
__END__
