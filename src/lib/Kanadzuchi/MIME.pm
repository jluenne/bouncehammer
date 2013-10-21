# $Id: MIME.pm,v 1.1.2.1 2013/10/21 06:23:59 ak Exp $
# Copyright (C) 2013 Cubicroot Co. Ltd.
# Kanadzuchi::
                            
 ##  ## #### ##  ## ######  
 ######  ##  ###### ##      
 ######  ##  ###### ####    
 ##  ##  ##  ##  ## ##      
 ##  ##  ##  ##  ## ##      
 ##  ## #### ##  ## ######  

package Kanadzuchi::MIME;
use strict;
use warnings;
use Encode;
use MIME::Base64 ();
use MIME::QuotedPrint ();

#  ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ ____ ____ 
# ||C |||l |||a |||s |||s |||       |||M |||e |||t |||h |||o |||d |||s ||
# ||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
sub is_mimeencoded {
    my $class = shift;
    my $argvs = shift || return 0;
    
    return undef unless ref $argvs;
    return undef unless ref $argvs eq 'SCALAR';

    return 1 if $$argvs =~ m{\A=[?][-_0-9A-Za-z]+[?][BbQq][?].+[?]=\z};
    return 0;
}

sub mimedecode {
    my $class = shift;
    my $argvs = shift;

    return q() unless ref $argvs;
    return q() unless ref $argvs eq 'ARRAY';

    my $characterset = q();
    my $encodingname = q();
    my $mimeencoded0 = [];
    my $decodedtext0 = [];
    my $decodedtext1 = q();
    my $utf8decoded1 = q();

    for my $e ( @$argvs ) {
        $e =~ s/\A\s+//g;
        $e =~ s/\s+\z//g;

        if( __PACKAGE__->is_mimeencoded( \$e ) ) {
            # MIME Encoded string
            if( $e =~ m{\A=[?]([-_0-9A-Za-z]+)[?]([BbQq])[?](.+)[?]=\z} ) {
                # =?utf-8?B?55m954yr44Gr44KD44KT44GT?=
                $characterset ||= lc $1;
                $encodingname ||= uc $2;
                $mimeencoded0   = $3;

                if( $encodingname eq 'Q' ) {
                    # Quoted-Printable
                    push @$decodedtext0, MIME::QuotedPrint::decode( $mimeencoded0 );

                } elsif( $encodingname eq 'B' ) {
                    # Base64
                    push @$decodedtext0, MIME::Base64::decode( $mimeencoded0 );
                }
            }
        } else {
            push @$decodedtext0, $e;
        }
    }

    return q() unless scalar @$decodedtext0;
    $decodedtext1 = join( '', @$decodedtext0 );

    if( $characterset && $encodingname ) {
        $characterset = 'utf8' if $characterset eq 'utf-8';

        if( $characterset ne 'utf8' ) {
            # Characterset is not UTF-8
            eval {
                Encode::from_to( $decodedtext1, $characterset, 'utf8' );
            };
        }
    }

    $decodedtext1 = 'FAILED TO CONVERT THE SUBJECT' if $@;
    $utf8decoded1 = $decodedtext1;
    return $utf8decoded1;
}
1;
__END__
