# $Id: SecurityError.pm,v 1.2.2.6 2013/08/30 05:55:25 ak Exp $
# Copyright (C) 2009,2010,2013 Cubicroot Co. Ltd.
# Kanadzuchi::Mail::Why::
                                                                                       
  #####                             ## ##          ######                              
 ###     ####   #### ##  ## #####    ###### ##  ## ##     #####  #####   ####  #####   
  ###   ##  ## ##    ##  ## ##  ## ### ##   ##  ## ####   ##  ## ##  ## ##  ## ##  ##  
   ###  ###### ##    ##  ## ##      ## ##   ##  ## ##     ##     ##     ##  ## ##      
    ### ##     ##    ##  ## ##      ## ##    ##### ##     ##     ##     ##  ## ##      
 #####   ####   ####  ##### ##     #### ###    ##  ###### ##     ##      ####  ##      
                                            ####                                       
package Kanadzuchi::Mail::Why::SecurityError;
use base 'Kanadzuchi::Mail::Why';

#  ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ ____ ____ 
# ||C |||l |||a |||s |||s |||       |||M |||e |||t |||h |||o |||d |||s ||
# ||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
# Regular expressions of 'Security Error'
sub exemplaria {
    my $class = shift;
    return [ 
        qr/authentication turned on in your email client/,
        qr/email not accepted for policy reasons/,
        qr/sorry, that domain isn'?t in my list of allowed rcpthosts/,
        qr/sorry, your don'?t authenticate or the domain isn'?t in my list of allowed rcpthosts/,
        qr/your network is temporary blacklisted/,
    ];
}

1;
__END__
