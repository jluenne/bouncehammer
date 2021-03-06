# $Id: MTA.pm,v 1.6.2.5 2013/08/30 05:55:54 ak Exp $
# Copyright (C) 2010-2011,2013 Cubicroot Co. Ltd.
# Kanadzuchi::
                     
 ##  ## ###### ##    
 ######   ##  ####   
 ######   ## ##  ##  
 ##  ##   ## ######  
 ##  ##   ## ##  ##  
 ##  ##   ## ##  ##  
package Kanadzuchi::MTA;
use strict;
use warnings;
use Kanadzuchi::RFC2822;
use Kanadzuchi::RFC3463;
use Kanadzuchi::Address;
use Encode;

#  ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ ____ ____ 
# ||C |||l |||a |||s |||s |||       |||M |||e |||t |||h |||o |||d |||s ||
# ||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
sub version { return '0.0.2'; }
sub description { return q(); }
sub emailheaders { return []; }
sub reperit { return q(); }

sub SMTPCOMMAND {
    # +-+-+-+-+-+-+-+-+-+-+-+
    # |S|M|T|P|C|O|M|M|A|N|D|
    # +-+-+-+-+-+-+-+-+-+-+-+
    #
    # @Description  Return SMTP command names and patterns
    # @Param
    # @Returns      (Ref->Hash) SMTP Commands
    return {
        'helo' => qr{\b(?:HELO|EHLO)\b},
        'mail' => qr{\bMAIL F(?:ROM|rom)\b},
        'rcpt' => qr{\bRCPT T[Oo]\b},
        'data' => qr{\bDATA\b},
    };
}

sub xsmtpagent { 
    # +-+-+-+-+-+-+-+-+-+-+
    # |x|s|m|t|p|a|g|e|n|t|
    # +-+-+-+-+-+-+-+-+-+-+
    #
    # @Description  Return pseudo-header for SMTP Agent(MTA)
    # @Param <str>  (String) SMTP agnet name
    # @Returns      (String) Pseudo-header
    my $class = shift; 
    my $agent = shift || 'null';
    return 'X-SMTP-Agent: '.$agent.qq(\n);
}

sub xsmtpcommand { 
    # +-+-+-+-+-+-+-+-+-+-+-+-+
    # |x|s|m|t|p|c|o|m|m|a|n|d|
    # +-+-+-+-+-+-+-+-+-+-+-+-+
    #
    # @Description  Return pseudo-header for SMTP Command
    # @Param <str>  (String) SMTP command name
    # @Returns      (String) Pseudo-header
    my $class = shift; 
    my $smtpc = shift || 'CONN';
    return 'X-SMTP-Command: '.$smtpc.qq(\n);
}

sub xsmtpdiagnosis { 
    # +-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    # |x|s|m|t|p|d|i|a|g|n|o|s|i|s|
    # +-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    #
    # @Description  Return pseudo-header for Diagnostic-Code
    # @Param <str>  (String) Diagnosis message
    # @Returns      (String) Pseudo-header
    my $class = shift; 
    my $xdiag = shift || return q();
    return 'X-SMTP-Diagnosis: '.$xdiag.qq(\n);
}

sub xsmtpstatus {
    # +-+-+-+-+-+-+-+-+-+-+-+
    # |x|s|m|t|p|s|t|a|t|u|s|
    # +-+-+-+-+-+-+-+-+-+-+-+
    #
    # @Description  Return pseudo-header for SMTP Status
    # @Param <str>  (String) SMTP Status(D.S.N.)
    # @Returns      (String) Pseudo-header
    my $class = shift; 
    my $dstat = shift || return q();
    return 'X-SMTP-Status: '.$dstat.qq(\n);
}

sub xsmtprecipient { 
    # +-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    # |x|s|m|t|p|r|e|c|i|p|i|e|n|t|
    # +-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    #
    # @Description  Return pseudo-header for Final-Recipient
    # @Param <str>  (String) Recipient Address
    # @Returns      (String) Pseudo-header
    my $class = shift; 
    my $xrcpt = shift || return q();
    return 'X-SMTP-Recipient: '.$xrcpt.qq(\n);
}

sub xsmtpcharset { 
    # +-+-+-+-+-+-+-+-+-+-+-+-+
    # |x|s|m|t|p|c|h|a|r|s|e|t|
    # +-+-+-+-+-+-+-+-+-+-+-+-+
    #
    # @Description  Return pseudo-header for Content-Type
    # @Param <str>  (String) Recipient Address
    # @Returns      (String) Pseudo-header
    my $class = shift; 
    my $xchar = shift || return q();
    return 'X-SMTP-Charset: '.$xchar.qq(\n);
}

1;
__END__
