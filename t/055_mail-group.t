# $Id: 055_mail-group.t,v 1.14 2010/06/14 12:39:31 ak Exp $
#  ____ ____ ____ ____ ____ ____ ____ ____ ____ 
# ||L |||i |||b |||r |||a |||r |||i |||e |||s ||
# ||__|||__|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
use lib qw(./t/lib ./dist/lib ./src/lib);
use strict;
use warnings;
use Kanadzuchi::Test;
use Test::More ( tests => 406 );

#  ____ ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ 
# ||G |||l |||o |||b |||a |||l |||       |||v |||a |||r |||s ||
# ||__|||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|
#
my $BaseGrp = q|Kanadzuchi::Mail::Group|;
my $Classes = {
	'neighbor'	=> q|Kanadzuchi::Mail::Group::Neighbor|,
	'webmail'	=> q|Kanadzuchi::Mail::Group::WebMail|,
	'auwebmail'	=> q|Kanadzuchi::Mail::Group::AU::WebMail|,
	'cawebmail'	=> q|Kanadzuchi::Mail::Group::CA::WebMail|,
	'czwebmail'	=> q|Kanadzuchi::Mail::Group::CZ::WebMail|,
	'dewebmail'	=> q|Kanadzuchi::Mail::Group::DE::WebMail|,
	'egwebmail'	=> q|Kanadzuchi::Mail::Group::EG::WebMail|,
	'inwebmail'	=> q|Kanadzuchi::Mail::Group::IN::WebMail|,
	'jpcellphone'	=> q|Kanadzuchi::Mail::Group::JP::Cellphone|,
	'jpsmartphone'	=> q|Kanadzuchi::Mail::Group::JP::Smartphone|,
	'jpwebmail'	=> q|Kanadzuchi::Mail::Group::JP::WebMail|,
	'nowebmail'	=> q|Kanadzuchi::Mail::Group::NO::WebMail|,
	'ruwebmail'	=> q|Kanadzuchi::Mail::Group::RU::WebMail|,
	'uksmartphone'	=> q|Kanadzuchi::Mail::Group::UK::Smartphone|,
	'uswebmail'	=> q|Kanadzuchi::Mail::Group::US::WebMail|,
};

my $Domains = {
	'neighbor'	=> [],
	'webmail'	=> [ qw(aol.com aol.jp gmail.com googlemail.com yahoo.com yahoo.co.jp 
				hotmail.com windowslive.com mac.com me.com ovi.com excite.com
				lycos.com lycosmail.com ) ],
	'auwebmail'	=> [ qw( fastmail.net fastmail.fm ) ],
	'cawebmail'	=> [ qw( hushmail.com hush.com ) ],
	'czwebmail'	=> [ qw( seznam.cz email.cz ) ],
	'dewebmail'	=> [ qw( gmx.de ) ],
	'egwebmail'	=> [ qw( gawab.com giza.cc ) ],
	'inwebmail'	=> [ qw( ibibo.com ) ],
	'jpcellphone'	=> [ qw( docomo.ne.jp ezweb.ne.jp softbank.ne.jp d.vodafone.ne.jp jp-k.ne.jp ) ],
	'jpsmartphone'	=> [ qw( i.softbank.jp docomo.blackberry.com emnet.ne.jp willcom.com ) ],
	'jpwebmail'	=> [ qw( auone.jp dwmail.jp ) ],
	'nowebmail'	=> [ qw( runbox.com ) ],
	'ruwebmail'	=> [ qw( mail.ru yandex.ru ) ],
	'uksmartphone'	=> [ qw( o2.co.uk ) ],
	'uswebmail'	=> [ qw( bluetie.com lavabit.com luxsci.com inbox.com mail.com usa.com ) ],
};

#  ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ 
# ||T |||e |||s |||t |||       |||c |||o |||d |||e |||s ||
# ||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|
#

REQUIRE: {
	use_ok($BaseGrp);
	foreach my $c ( keys(%$Classes) ){ require_ok("$Classes->{$c}") }
}

METHODS: {
	can_ok($BaseGrp, qw(reperit postult));
	foreach my $c ( keys(%$Classes) ){ can_ok( $Classes->{$c}, 'reperit' ) } 

	LEGERE: {
		my $loadedgr = $BaseGrp->postult();

		isa_ok( $loadedgr, q|ARRAY| );
		foreach my $g ( @$loadedgr )
		{
			ok( (grep { $g eq $_ } values(%$Classes)), $g );
		}
	}
}

# 3. Call class method
CLASS_METHODS: foreach my $c ( keys(%$Domains) )
{
	my $detected = {};
	MATCH: foreach my $s ( @{$Domains->{$c}} )
	{
		$detected = $Classes->{ $c }->reperit($s);
		isa_ok( $detected, q|HASH|, '->reperit' );
		ok( $detected->{'class'}, '->class = '.$detected->{'class'} );
		ok( $detected->{'group'}, '->group = '.$detected->{'group'} );
		ok( $detected->{'provider'}, '->provider = '.$detected->{'provider'} );
	}

	DONT_MATCH: foreach my $s ( @{$Domains->{$c}} )
	{
		$detected = $Classes->{ $c }->reperit($s.'.org');
		isa_ok( $detected, q|HASH|, '->reperit' );
		is( $detected->{'class'}, q(), '->class = ' );
		is( $detected->{'group'}, q(), '->group = ' );
		is( $detected->{'provider'}, q(), '->provider = ' );

	}
}

__END__
