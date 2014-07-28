# $Id: SecurityError.pm,v 1.2.2.7 2014/07/28 05:24:40 ak Exp $
# Copyright (C) 2009,2010,2013,2014 Cubicroot Co. Ltd.
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
        qr/application-specific password required/,
        qr/authentication required/,
        qr/authentication turned on in your email client/,
        qr/email not accepted for policy reasons/,
        qr/must issue a starttls command first/,
        qr/no identity changes permitted/,
        qr/please log in with your web browser and then try again/,
        qr/sorry, that domain isn'?t in my list of allowed rcpthosts/,
        qr/sorry, your don'?t authenticate or the domain isn'?t in my list of allowed rcpthosts/,
        qr/tls required for rcpt domain, closing connection/,
        qr/too many unauthenticated commands/,
        qr/username and password not accepted/,
        qr/unrecognized authentication type/,
        qr/your network is temporary blacklisted/,
    ];
}

1;
__END__
