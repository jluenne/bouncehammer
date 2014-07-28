# $Id: ExceedLimit.pm,v 1.8.2.3 2014/07/28 05:24:40 ak Exp $
# -Id: ExceedLimit.pm,v 1.1 2009/08/29 07:33:28 ak Exp -
# -Id: ExceedLimit.pm,v 1.1 2009/05/04 05:17:05 ak Exp -
# Copyright (C) 2009,2010,2013,2014 Cubicroot Co. Ltd.
# Kanadzuchi::Mail::Why::
                                                                     
 ######                              ## ##      ##          ## ##    
 ##     ##  ## #### ####   ####      ## ##          ##  ##   ######  
 ####    #### ##   ##  ## ##  ##  ##### ##     ###  ###### ### ##    
 ##       ##  ##   ###### ###### ##  ## ##      ##  ######  ## ##    
 ##      #### ##   ##     ##     ##  ## ##      ##  ##  ##  ## ##    
 ###### ##  ## #### ####   ####   ##### ###### #### ##  ## #### ###  
package Kanadzuchi::Mail::Why::ExceedLimit;
use base 'Kanadzuchi::Mail::Why';

#  ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ ____ ____ 
# ||C |||l |||a |||s |||s |||       |||M |||e |||t |||h |||o |||d |||s ||
# ||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
# Regular expressions of 'Excced Limit'
sub exemplaria {
    my $class = shift;
    return [
        qr/daily sending quota exceeded/,
        qr/your message exceeded Google's message size limits/,
    ];
}

1;
__END__
