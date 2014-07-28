# $Id: Rejected.pm,v 1.2.2.5 2014/07/28 05:24:40 ak Exp $
# Copyright (C) 2009,2010,2013,2014 Cubicroot Co. Ltd.
# Kanadzuchi::Mail::Why::
                                                       
 #####           ##                 ##             ##  
 ##  ##  ####         ####   #### ###### ####      ##  
 ##  ## ##  ##   ##  ##  ## ##      ##  ##  ##  #####  
 #####  ######   ##  ###### ##      ##  ###### ##  ##  
 ## ##  ##       ##  ##     ##      ##  ##     ##  ##  
 ##  ##  ####    ##   ####   ####    ### ####   #####  
              ####                                     
package Kanadzuchi::Mail::Why::Rejected;
use base 'Kanadzuchi::Mail::Why';

#  ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ ____ ____ 
# ||C |||l |||a |||s |||s |||       |||M |||e |||t |||h |||o |||d |||s ||
# ||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
# Regular expressions of 'Rejected'
sub exemplaria
{
    my $class = shift;
    return [ 
        # Rejected due to envelope from address
        qr/address rejected/,
        qr/domain of sender address .+ does not exist/,
        qr/mail Sending denied/,
        qr/sender rejected/,
        qr/unauthenticated email is not accepted from this domain/,
    ];
}

1;
__END__
