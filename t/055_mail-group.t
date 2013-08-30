# $Id: 055_mail-group.t,v 1.31.2.20 2013/08/30 23:05:12 ak Exp $
#  ____ ____ ____ ____ ____ ____ ____ ____ ____ 
# ||L |||i |||b |||r |||a |||r |||i |||e |||s ||
# ||__|||__|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
use lib qw(./t/lib ./dist/lib ./src/lib);
use strict;
use warnings;
use Kanadzuchi::Test;
use Test::More;

#  ____ ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ 
# ||G |||l |||o |||b |||a |||l |||       |||v |||a |||r |||s ||
# ||__|||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|
#
my $BaseGrp = 'Kanadzuchi::Mail::Group';
my $Classes = {
    'neighbor'      => 'Kanadzuchi::Mail::Group::Neighbor',
    'smartphone'    => 'Kanadzuchi::Mail::Group::Smartphone',
    'webmail'       => 'Kanadzuchi::Mail::Group::WebMail',
    'aesmartphone'  => 'Kanadzuchi::Mail::Group::AE::Smartphone',
    'alsmartphone'  => 'Kanadzuchi::Mail::Group::AL::Smartphone',
    'alwebmail'     => 'Kanadzuchi::Mail::Group::AL::WebMail',
    'arcellphone'   => 'Kanadzuchi::Mail::Group::AR::Cellphone',
    'arsmartphone'  => 'Kanadzuchi::Mail::Group::AR::Smartphone',
    'arwebmail'     => 'Kanadzuchi::Mail::Group::AR::WebMail',
    'atsmartphone'  => 'Kanadzuchi::Mail::Group::AT::Smartphone',
    'atcellphone'   => 'Kanadzuchi::Mail::Group::AT::Cellphone',
    'aucellphone'   => 'Kanadzuchi::Mail::Group::AU::Cellphone',
    'ausmartphone'  => 'Kanadzuchi::Mail::Group::AU::Smartphone',
    'auwebmail'     => 'Kanadzuchi::Mail::Group::AU::WebMail',
    'awcellphone'   => 'Kanadzuchi::Mail::Group::AW::Cellphone',
    'awsmartphone'  => 'Kanadzuchi::Mail::Group::AW::Smartphone',
    'besmartphone'  => 'Kanadzuchi::Mail::Group::BE::Smartphone',
    'bgcellphone'   => 'Kanadzuchi::Mail::Group::BG::Cellphone',
    'bgsmartphone'  => 'Kanadzuchi::Mail::Group::BG::Smartphone',
    'bmsmartphone'  => 'Kanadzuchi::Mail::Group::BM::Smartphone',
    'brcellphone'   => 'Kanadzuchi::Mail::Group::BR::Cellphone',
    'brsmartphone'  => 'Kanadzuchi::Mail::Group::BR::Smartphone',
    'brwebmail'     => 'Kanadzuchi::Mail::Group::BR::WebMail',
    'bssmartphone'  => 'Kanadzuchi::Mail::Group::BS::Smartphone',
    'cacellphone'   => 'Kanadzuchi::Mail::Group::CA::Cellphone',
    'casmartphone'  => 'Kanadzuchi::Mail::Group::CA::Smartphone',
    'cawebmail'     => 'Kanadzuchi::Mail::Group::CA::WebMail',
    'chcellphone'   => 'Kanadzuchi::Mail::Group::CH::Cellphone',
    'chsmartphone'  => 'Kanadzuchi::Mail::Group::CH::Smartphone',
    'clsmartphone'  => 'Kanadzuchi::Mail::Group::CL::Smartphone',
    'cncellphone'   => 'Kanadzuchi::Mail::Group::CN::Cellphone',
    'cnsmartphone'  => 'Kanadzuchi::Mail::Group::CN::Smartphone',
    'cnwebmail'     => 'Kanadzuchi::Mail::Group::CN::WebMail',
    'cocellphone'   => 'Kanadzuchi::Mail::Group::CO::Cellphone',
    'cosmartphone'  => 'Kanadzuchi::Mail::Group::CO::Smartphone',
    'crcellphone'   => 'Kanadzuchi::Mail::Group::CR::Cellphone',
    'czcellphone'   => 'Kanadzuchi::Mail::Group::CZ::Cellphone',
    'czsmartphone'  => 'Kanadzuchi::Mail::Group::CZ::Smartphone',
    'czwebmail'     => 'Kanadzuchi::Mail::Group::CZ::WebMail',
    'decellphone'   => 'Kanadzuchi::Mail::Group::DE::Cellphone',
    'desmartphone'  => 'Kanadzuchi::Mail::Group::DE::Smartphone',
    'dewebmail'     => 'Kanadzuchi::Mail::Group::DE::WebMail',
    'dksmartphone'  => 'Kanadzuchi::Mail::Group::DK::Smartphone',
    'docellphone'   => 'Kanadzuchi::Mail::Group::DO::Cellphone',
    'dosmartphone'  => 'Kanadzuchi::Mail::Group::DO::Smartphone',
    'ecsmartphone'  => 'Kanadzuchi::Mail::Group::EC::Smartphone',
    'egsmartphone'  => 'Kanadzuchi::Mail::Group::EG::Smartphone',
    'egwebmail'     => 'Kanadzuchi::Mail::Group::EG::WebMail',
    'escellphone'   => 'Kanadzuchi::Mail::Group::ES::Cellphone',
    'essmartphone'  => 'Kanadzuchi::Mail::Group::ES::Smartphone',
    'eswebmail'     => 'Kanadzuchi::Mail::Group::ES::WebMail',
    'frcellphone'   => 'Kanadzuchi::Mail::Group::FR::Cellphone',
    'frsmartphone'  => 'Kanadzuchi::Mail::Group::FR::Smartphone',
    'frwebmail'     => 'Kanadzuchi::Mail::Group::FR::WebMail',
    'grsmartphone'  => 'Kanadzuchi::Mail::Group::GR::Smartphone',
    'gtsmartphone'  => 'Kanadzuchi::Mail::Group::GT::Smartphone',
    'hkcellphone'   => 'Kanadzuchi::Mail::Group::HK::Cellphone',
    'hksmartphone'  => 'Kanadzuchi::Mail::Group::HK::Smartphone',
    'hnsmartphone'  => 'Kanadzuchi::Mail::Group::HN::Smartphone',
    'hrcellphone'   => 'Kanadzuchi::Mail::Group::HR::Cellphone',
    'hrsmartphone'  => 'Kanadzuchi::Mail::Group::HR::Smartphone',
    'husmartphone'  => 'Kanadzuchi::Mail::Group::HU::Smartphone',
    'idsmartphone'  => 'Kanadzuchi::Mail::Group::ID::Smartphone',
    'iecellphone'   => 'Kanadzuchi::Mail::Group::IE::Cellphone',
    'iesmartphone'  => 'Kanadzuchi::Mail::Group::IE::Smartphone',
    'ilcellphone'   => 'Kanadzuchi::Mail::Group::IL::Cellphone',
    'ilsmartphone'  => 'Kanadzuchi::Mail::Group::IL::Smartphone',
    'ilwebmail'     => 'Kanadzuchi::Mail::Group::IL::WebMail',
    'incellphone'   => 'Kanadzuchi::Mail::Group::IN::Cellphone',
    'insmartphone'  => 'Kanadzuchi::Mail::Group::IN::Smartphone',
    'inwebmail'     => 'Kanadzuchi::Mail::Group::IN::WebMail',
    'irwebmail'     => 'Kanadzuchi::Mail::Group::IR::WebMail',
    'iscellphone'   => 'Kanadzuchi::Mail::Group::IS::Cellphone',
    'issmartphone'  => 'Kanadzuchi::Mail::Group::IS::Smartphone',
    'itcellphone'   => 'Kanadzuchi::Mail::Group::IT::Cellphone',
    'itsmartphone'  => 'Kanadzuchi::Mail::Group::IT::Smartphone',
    'jmsmartphone'  => 'Kanadzuchi::Mail::Group::JM::Smartphone',
    'jpcellphone'   => 'Kanadzuchi::Mail::Group::JP::Cellphone',
    'jpsmartphone'  => 'Kanadzuchi::Mail::Group::JP::Smartphone',
    'jpwebmail'     => 'Kanadzuchi::Mail::Group::JP::WebMail',
    'kesmartphone'  => 'Kanadzuchi::Mail::Group::KE::Smartphone',
    'krwebmail'     => 'Kanadzuchi::Mail::Group::KR::WebMail',
    'lbsmartphone'  => 'Kanadzuchi::Mail::Group::LB::Smartphone',
    'lkcellphone'   => 'Kanadzuchi::Mail::Group::LK::Cellphone',
    'lksmartphone'  => 'Kanadzuchi::Mail::Group::LK::Smartphone',
    'lusmartphone'  => 'Kanadzuchi::Mail::Group::LU::Smartphone',
    'lvwebmail'     => 'Kanadzuchi::Mail::Group::LV::WebMail',
    'masmartphone'  => 'Kanadzuchi::Mail::Group::MA::Smartphone',
    'mdwebmail'     => 'Kanadzuchi::Mail::Group::MD::WebMail',
    'mesmartphone'  => 'Kanadzuchi::Mail::Group::ME::Smartphone',
    'mksmartphone'  => 'Kanadzuchi::Mail::Group::MK::Smartphone',
    'mosmartphone'  => 'Kanadzuchi::Mail::Group::MO::Smartphone',
    'mucellphone'   => 'Kanadzuchi::Mail::Group::MU::Cellphone',
    'mxcellphone'   => 'Kanadzuchi::Mail::Group::MX::Cellphone',
    'mxsmartphone'  => 'Kanadzuchi::Mail::Group::MX::Smartphone',
    'mysmartphone'  => 'Kanadzuchi::Mail::Group::MY::Smartphone',
    'ngsmartphone'  => 'Kanadzuchi::Mail::Group::NG::Smartphone',
    'nicellphone'   => 'Kanadzuchi::Mail::Group::NI::Cellphone',
    'nismartphone'  => 'Kanadzuchi::Mail::Group::NI::Smartphone',
    'nlcellphone'   => 'Kanadzuchi::Mail::Group::NL::Cellphone',
    'nlsmartphone'  => 'Kanadzuchi::Mail::Group::NL::Smartphone',
    'nocellphone'   => 'Kanadzuchi::Mail::Group::NO::Cellphone',
    'nosmartphone'  => 'Kanadzuchi::Mail::Group::NO::Smartphone',
    'nowebmail'     => 'Kanadzuchi::Mail::Group::NO::WebMail',
    'npcellphone'   => 'Kanadzuchi::Mail::Group::NP::Cellphone',
    'npsmartphone'  => 'Kanadzuchi::Mail::Group::NP::Smartphone',
    'nzcellphone'   => 'Kanadzuchi::Mail::Group::NZ::Cellphone',
    'nzsmartphone'  => 'Kanadzuchi::Mail::Group::NZ::Smartphone',
    'nzwebmail'     => 'Kanadzuchi::Mail::Group::NZ::WebMail',
    'omsmartphone'  => 'Kanadzuchi::Mail::Group::OM::Smartphone',
    'pacellphone'   => 'Kanadzuchi::Mail::Group::PA::Cellphone',
    'pasmartphone'  => 'Kanadzuchi::Mail::Group::PA::Smartphone',
    'pesmartphone'  => 'Kanadzuchi::Mail::Group::PE::Smartphone',
    'phsmartphone'  => 'Kanadzuchi::Mail::Group::PH::Smartphone',
    'pksmartphone'  => 'Kanadzuchi::Mail::Group::PK::Smartphone',
    'plcellphone'   => 'Kanadzuchi::Mail::Group::PL::Cellphone',
    'plsmartphone'  => 'Kanadzuchi::Mail::Group::PL::Smartphone',
    'prcellphone'   => 'Kanadzuchi::Mail::Group::PR::Cellphone',
    'prsmartphone'  => 'Kanadzuchi::Mail::Group::PR::Smartphone',
    'ptsmartphone'  => 'Kanadzuchi::Mail::Group::PT::Smartphone',
    'ptwebmail'     => 'Kanadzuchi::Mail::Group::PT::WebMail',
    'pysmartphone'  => 'Kanadzuchi::Mail::Group::PY::Smartphone',
    'rosmartphone'  => 'Kanadzuchi::Mail::Group::RO::Smartphone',
    'rowebmail'     => 'Kanadzuchi::Mail::Group::RO::WebMail',
    'rssmartphone'  => 'Kanadzuchi::Mail::Group::RS::Smartphone',
    'rusmartphone'  => 'Kanadzuchi::Mail::Group::RU::Smartphone',
    'ruwebmail'     => 'Kanadzuchi::Mail::Group::RU::WebMail',
    'sasmartphone'  => 'Kanadzuchi::Mail::Group::SA::Smartphone',
    'secellphone'   => 'Kanadzuchi::Mail::Group::SE::Cellphone',
    'sesmartphone'  => 'Kanadzuchi::Mail::Group::SE::Smartphone',
    'sgcellphone'   => 'Kanadzuchi::Mail::Group::SG::Cellphone',
    'sgsmartphone'  => 'Kanadzuchi::Mail::Group::SG::Smartphone',
    'sgwebmail'     => 'Kanadzuchi::Mail::Group::SG::WebMail',
    'sksmartphone'  => 'Kanadzuchi::Mail::Group::SK::Smartphone',
    'skwebmail'     => 'Kanadzuchi::Mail::Group::SK::WebMail',
    'srsmartphone'  => 'Kanadzuchi::Mail::Group::SR::Smartphone',
    'svsmartphone'  => 'Kanadzuchi::Mail::Group::SV::Smartphone',
    'thsmartphone'  => 'Kanadzuchi::Mail::Group::TH::Smartphone',
    'thwebmail'     => 'Kanadzuchi::Mail::Group::TH::WebMail',
    'trsmartphone'  => 'Kanadzuchi::Mail::Group::TR::Smartphone',
    'twsmartphone'  => 'Kanadzuchi::Mail::Group::TW::Smartphone',
    'twwebmail'     => 'Kanadzuchi::Mail::Group::TW::WebMail',
    'uasmartphone'  => 'Kanadzuchi::Mail::Group::UA::Smartphone',
    'ugsmartphone'  => 'Kanadzuchi::Mail::Group::UG::Smartphone',
    'ukcellphone'   => 'Kanadzuchi::Mail::Group::UK::Cellphone',
    'uksmartphone'  => 'Kanadzuchi::Mail::Group::UK::Smartphone',
    'ukwebmail'     => 'Kanadzuchi::Mail::Group::UK::WebMail',
    'uscellphone'   => 'Kanadzuchi::Mail::Group::US::Cellphone',
    'ussmartphone'  => 'Kanadzuchi::Mail::Group::US::Smartphone',
    'uswebmail'     => 'Kanadzuchi::Mail::Group::US::WebMail',
    'uycellphone'   => 'Kanadzuchi::Mail::Group::UY::Cellphone',
    'uysmartphone'  => 'Kanadzuchi::Mail::Group::UY::Smartphone',
    'vesmartphone'  => 'Kanadzuchi::Mail::Group::VE::Smartphone',
    'vnsmartphone'  => 'Kanadzuchi::Mail::Group::VN::Smartphone',
    'vnwebmail'     => 'Kanadzuchi::Mail::Group::VN::WebMail',
    'zacellphone'   => 'Kanadzuchi::Mail::Group::ZA::Cellphone',
    'zasmartphone'  => 'Kanadzuchi::Mail::Group::ZA::Smartphone',
    'zawebmail'     => 'Kanadzuchi::Mail::Group::ZA::WebMail',
};

my $Domains = {
    'neighbor'  => [],
    'webmail'   => [ qw/
        aol.com aol.jp gmail.com googlemail.com yahoo.com yahoo.co.jp hotmail.com
        windowslive.com mac.com me.com excite.com lycos.com lycosmail.com 
        facebook.com groups.facebook.com myspace.com love.com ygm.com latinmail.com
        myopera.com outlook.com/
    ],
    'cellphone' => [ qw/
        msg.globalstarusa.com msg.iridium.com bulksms.net bulletinmessenger.net
        email2sms.routomessaging.com /
                   ],
    'smartphone'=> [ qw/
        vertu.me mobileemail.vodafone.net 360.com ovi.com blackberry.orange.fr 
        nokiamail.com /
    ],
    'aesmartphone'  => [ qw/ du.blackberry.com etisalat.blackberry.com / ],
    'alsmartphone'  => [ qw/ amc.blackberry.com / ],
    'alwebmail'     => [ qw/ albaniaonline.net primo.al / ],
    'arcellphone'   => [ qw/ sms.ctimovil.com.ar nextel.net.ar alertas.personal.com.ar/ ],
    'arsmartphone'  => [ qw/ movistar.ar.blackberry.com claroar.blackberry.com / ],
    'arwebmail'     => [ qw/ uolsinectis.com.ar ciudad.com.ar / ],
    'atcellphone'   => [ qw/ sms.t-mobile.at / ],
    'atsmartphone'  => [ qw/ instantemail.t-mobile.at mobileemail.a1.net / ],
    'aucellphone'   => [ qw/ sms.tim.telstra.com tim.telstra.com optusmobile.com.au / ],
    'ausmartphone'  => [ qw/ telstra.blackberry.com three.blackberry.com optus.blackberry.com / ],
    'auwebmail'     => [ qw/ fastmail.net fastmail.fm aussiemail.com.au / ],
    'awcellphone'   => [ qw/ mas.aw / ],
    'awsmartphone'  => [ qw/ setar.blackberry.com / ],
    'besmartphone'  => [ qw/ base.blackberry.com proximus.blackberry.com blackberry.mobistar.be / ],
    'bgcellphone'   => [ qw/ sms.globul.bg sms.mtel.net sms.vivacom.bg / ],
    'bgsmartphone'  => [ qw/ mtel.blackberry.com globul.blackberry.com / ],
    'bmsmartphone'  => [ qw/ m3wireless.blackberry.com / ],
    'brcellphone'   => [ qw/ torpedoemail.com.br clarotorpedo.com.br / ],
    'brsmartphone'  => [ qw/
        timbrasil.blackberry.com vivo.blackberry.com oi.blackberry.com
        nextel.br.blackberry.com claro.blackberry.com /
    ],
    'brwebmail'     => [ qw/ bol.com.br zipmail.com.br / ],
    'bssmartphone'  => [ qw/ btccybercell.blackberry.com / ],
    'cacellphone'   => [ qw/ txt.bellmobility.ca txt.bell.ca vmobile.ca msg.telus.com / ],
    'casmartphone'  => [ qw/ rogers.blackberry.net virginmobile.blackberry.com bell.blackberry.com / ],
    'cawebmail'     => [ qw/ hushmail.com hush.com zworg.com / ],
    'chcellphone'   => [ qw/ sms.boxis.net gsm.sunrise.ch / ],
    'chsmartphone'  => [ qw/ mobileemail.swisscom.ch sunrise.blackberry.com / ],
    'clsmartphone'  => [ qw/ entelpcs.blackberry.net movistar.cl.blackberry.com clarochile.blackberry.com / ],
    'cncellphone'   => [ qw/ 139.com / ],
    'cnsmartphone'  => [ qw/ chinamobile.blackberry.com chinaunicom.blackberry.com / ],
    'cnwebmail'     => [ qw/ 163.com 188.com / ],
    'cocellphone'   => [ qw/ sms.tigo.com.co comcel.com.co movistar.com.co / ],
    'cosmartphone'  => [ qw/ comcel.blackberry.com movistar.co.blackberry.com / ],
    'crcellphone'   => [ qw/ ice.cr / ],
    'czcellphone'   => [ qw/ vodafonemail.cz / ],
    'czsmartphone'  => [ qw/ o2.blackberry.cz tmobilecz.blackberry.com / ],
    'czwebmail'     => [ qw/ seznam.cz email.cz / ],
    'decellphone'   => [ qw/ vodafone-sms.de o2online.de vodafone-sms.de smsmail.eplus.de / ],
    'desmartphone'  => [ qw/ instantemail.t-mobile.de o2.blackberry.de eplus.blackberry.com / ],
    'dewebmail'     => [ qw/ gmx.de / ],
    'dksmartphone'  => [ qw/ tre.blackberry.com telenor.dk.blackberry.com teliadk.blackberry.com / ],
    'docellphone'   => [ qw/ digitextdm.com / ],
    'dosmartphone'  => [ qw/ clarodr.blackberry.com vivard.blackberry.com / ],
    'ecsmartphone'  => [ qw/ movistar.ec.blackberry.com porta.blackberry.com / ],
    'egwebmail'     => [ qw/ gawab.com giza.cc / ],
    'escellphone'   => [ qw/ correo.movistar.net vodafone.es / ],
    'essmartphone'  => [ qw/ movistar.net amena.blackberry.com / ],
    'eswebmail'     => [ qw/ terra.com / ],
    'frcellphone'   => [ qw/ mms.bouyguestelecom.fr / ],
    'frsmartphone'  => [ qw/ bouyguestelecom.blackberry.com / ],
    'frwebmail'     => [ qw/ cario.fr mageos.com voila.fr / ],
    'grsmartphone'  => [ qw/ windgr.blackberry.com cosmotegr.blackberry.com / ],
    'gtsmartphone'  => [ qw/ claroguatemala.blackberry.com movistar.gt.blackberry.com / ],
    'hkcellphone'   => [ qw/ messaging.accessyou.com mgw.mmsc1.hkcsl.com/ ],
    'hksmartphone'  => [ qw/ threehk.blackberry.com csl.blackberry.com/ ],
    'hnsmartphone'  => [ qw/ clarohn.blackberry.com / ],
    'hrcellphone'   => [ qw/ sms.t-mobile.hr / ],
    'hrsmartphone'  => [ qw/ instantemail.t-mobile.hr / ],
    'husmartphone'  => [ qw/ instantemail.t-mobile.hu / ],
    'idsmartphone'  => [ qw/ indosat.blackberry.com telkomsel.blackberry.com xl.blackberry.com / ],
    'iecellphone'   => [ qw/ sms.mymeteor.ie mms.mymeteor.ie / ],
    'iesmartphone'  => [ qw/ o2mail.ie 3ireland.blackberry.com / ],
    'ilcellphone'   => [ qw/ spikkosms.com / ],
    'ilsmartphone'  => [ qw/ cellcom.blackberry.com pelephone.blackberry.com / ],
    'ilwebmail'     => [ qw/ walla.co.il / ],
    'incellphone'   => [ qw/ aircel.co.in airtelap.com airtelkk.com bplmobile.com / ],
    'insmartphone'  => [ qw/ airtel.blackberry.com hutch.blackberry.com / ],
    'inwebmail'     => [ qw/ ibibo.com in.com rediffmail.com india.com/ ],
    'irwebmail'     => [ qw/ iran.ir / ],
    'iscellphone'   => [ qw/ box.is sms.is / ],
    'issmartphone'  => [ qw/ siminn.blackberry.com / ],
    'itcellphone'   => [ qw/ sms.vodafone.it / ],
    'itsmartphone'  => [ qw/ treitalia.blackberry.com tim.blackberry.com / ],
    'jmsmartphone'  => [ qw/
        cwjamaica.blackberry.net digicel.blackberry.com clarojm.blackberry.com /
    ],
    'jpcellphone'   => [ qw/
        docomo.ne.jp ezweb.ne.jp softbank.ne.jp d.vodafone.ne.jp jp-k.ne.jp
        vertuclub.ne.jp ido.ne.jp eza.ido.ne.jp sky.tu-ka.ne.jp /
    ],
    'jpsmartphone'  => [ qw/
        i.softbank.jp docomo.blackberry.com emnet.ne.jp willcom.com
        bb.emobile.jp /
    ],
    'jpwebmail' => [ qw/
        auone.jp dwmail.jp mail.goo.ne.jp goo.jp infoseek.jp livedoor.com
        nifty.com nifmail.jp kitty.jp x-o.jp /
    ],
    'kesmartphone'  => [ qw/ airtel.blackberry.com safaricom.blackberry.com / ],
    'krwebmail'     => [ qw/ hanmail.net empas.com / ],
    'lbsmartphone'  => [ qw/ alfa.blackberry.com mtctouch.blackberry.com / ],
    'lkcellphone'   => [ qw/ sms.mobitel.lk / ],
    'lksmartphone'  => [ qw/ dialog.blackberry.com / ],
    'lusmartphone'  => [ qw/ 
        tango.blackberry.com mobileemail.luxgsm.lu voxmobile.blackberry.com /
    ],
    'lvwebmail'     => [ qw/ inbox.lv mail.lv / ],
    'masmartphone'  => [ qw/ iam.blackberry.com meditel.blackberry.com / ],
    'mdwebmail'     => [ qw/ mail.md / ],
    'mesmartphone'  => [ qw/ instantemail.t-mobile.me / ],
    'mksmartphone'  => [ qw/ instantemail.t-mobile.mk / ],
    'mosmartphone'  => [ qw/ ctm.blackberry.com smartonemo.blackberry.com / ],
    'mucellphone'   => [ qw/ emtelworld.net / ],
    'mxcellphone'   => [ qw/ msgnextel.com.mx / ],
    'mxsmartphone'  => [ qw/ 
        telcel.blackberry.net movistar.mx.blackberry.com iusacell.blackberry.com /
    ],
    'mysmartphone'  => [ qw/ maxis.blackberry.com digi.my.blackberry.com / ],
    'ngsmartphone'  => [ qw/ gloworld.blackberry.com / ],
    'nicellphone'   => [ qw/ ideasclaro-ca.com / ],
    'nismartphone'  => [ qw/ claronicaragua.blackberry.com movistar.ni.blackberry.com / ],
    'nlcellphone'   => [ qw/ gin.nl sms.orange.nl / ],
    'nlsmartphone'  => [ qw/ kpn.blackberry.com instantemail.t-mobile.nl uts.blackberry.com / ],
    'nocellphone'   => [ qw/ sendega.com / ],
    'nosmartphone'  => [ qw/ telenor.blackberry.com telenor.no.blackberry.com / ],
    'nowebmail'     => [ qw/ runbox.com / ],
    'npcellphone'   => [ qw/ sms.spicenepal.com / ],
    'npsmartphone'  => [ qw/ ncell.blackberry.com / ],
    'nzcellphone'   => [ qw/ sms.vodafone.net.nz / ],
    'nzsmartphone'  => [ qw/ tnz.blackberry.com / ],
    'nzwebmail'     => [ qw/ coolkiwi.com vodafone.co.nz wave.co.nz orcon.net.nz / ],
    'omsmartphone'  => [ qw/ omanmobile.blackberry.com nawras.blackberry.com / ],
    'pacellphone'   => [ qw/ cwmovil.com / ],
    'pasmartphone'  => [ qw/ 
        digicel.blackberry.com movistar.pa.blackberry.com 
        claropanama.blackberry.com cwmovil.blackberry.com /
    ],
    'pesmartphone'  => [ qw/ movistar.pe.blackberry.com claroperu.blackberry.com / ],
    'phsmartphone'  => [ qw/ globe.blackberry.com smart.blackberry.com / ],
    'pksmartphone'  => [ qw/ mobilink.blackberry.com / ],
    'plcellphone'   => [ qw/ orange.pl text.plusgsm.pl / ],
    'plsmartphone'  => [ qw/ era.blackberry.com iplus.blackberry.com / ],
    'prcellphone'   => [ qw/ vtexto.com mmst5.tracfone.com cwemail.com / ],
    'prsmartphone'  => [ qw/ vzwpr.blackberry.com claropr.blackberry.com / ],
    'ptsmartphone'  => [ qw/ tmn.blackberry.com optimus.blackberry.com / ],
    'ptwebmail'     => [ qw/ sapo.pt / ],
    'pysmartphone'  => [ qw/ claropy.blackberry.com / ],
    'rosmartphone'  => [ qw/ cosmotero.blackberry.com / ],
    'rowebmail'     => [ qw/ posta.ro mail.co.ro / ],
    'rssmartphone'  => [ qw/ telenorserbia.blackberry.com / ],
    'rusmartphone'  => [ qw/ mts.blackberry.com beeline.blackberry.com / ],
    'ruwebmail'     => [ qw/ mail.ru yandex.ru / ],
    'sasmartphone'  => [ qw/ stc.blackberry.com mobily.blackberry.com / ],
    'secellphone'   => [ qw/ sms.tele2.se / ],
    'sesmartphone'  => [ qw/ telenor-se.blackberry.com tele2se.blackberry.com / ],
    'sgcellphone'   => [ qw/ m1.com.sg starhub-enterprisemessaing.com / ],
    'sgsmartphone'  => [ qw/ m1.blackberry.com singtel.blackberry.com starhub.blackberry.com / ],
    'sgwebmail'     => [ qw/ insing.com / ],
    'sksmartphone'  => [ qw/ tmobilesk.blackberry.com / ],
    'skwebmail'     => [ qw/ post.sk pobox.sk / ],
    'srsmartphone'  => [ qw/ teleg.blackberry.com / ],
    'svsmartphone'  => [ qw/ movistar.sv.blackberry.com / ],
    'thsmartphone'  => [ qw/ aiscorporatemail.blackberry.com dtac.blackberry.com / ],
    'thwebmail'     => [ qw/ thaimail.com / ],
    'trsmartphone'  => [ qw/ turkcell.blackberry.com avea.blackberry.com / ],
    'twwebmail'     => [ qw/ seed.net.tw mars.seed.net.tw kingnet.com.tw / ],
    'uasmartphone'  => [ qw/ mtsua.blackberry.com / ],
    'ugsmartphone'  => [ qw/ utl.blackberry.com mtninternet.blackberry.com / ],
    'ukcellphone'   => [ qw/ 24xgateway.com text.aql.com orange.net vodafone.net / ],
    'uksmartphone'  => [ qw/ o2.co.uk instantemail.t-mobile.co.uk o2email.co.uk bt.blackberry.com/ ],
    'ukwebmail'     => [ qw/ postmaster.co.uk yipple.com / ],
    'uscellphone'   => [ qw/ sms.airfiremobile.com vtext.com mms.att.net pm.sprint.com / ],
    'ussmartphone'  => [ qw/ 
        sprint.blackberry.net alltel.blackberry.com vzw.blackberry.net
        att.blackberry.com mycingular.blackberry.net /
    ],
    'uswebmail' => [ qw/
        bluetie.com lavabit.com luxsci.com inbox.com mail.com usa.com 
        pobox.com onepost.net mail2world.com myemail.com shtrudel.com /
    ],
    'uycellphone'   => [ qw/ sms.movistar.com.uy / ],
    'uysmartphone'  => [ qw/ movistar.uy.blackberry.com clarouy.blackberry.com / ],
    'vesmartphone'  => [ qw/ movistar.ve.blackberry.com / ],
    'vnsmartphone'  => [ qw/ viettel.blackberry.com / ],
    'vnwebmail'     => [ qw/ pmail.vnn.vn / ],
    'zacellphone'   => [ qw/ sms.co.za voda.co.za / ],
    'zasmartphone'  => [ qw/ cellc.blackberry.com mtn.blackberry.com / ],
    'zawebmail'     => [ qw/ webmail.co.za mighty.co.za / ],
};

#  ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ 
# ||T |||e |||s |||t |||       |||c |||o |||d |||e |||s ||
# ||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|
#

REQUIRE: {
    use_ok $BaseGrp;
    foreach my $c ( keys %$Classes ){
        require_ok "$Classes->{ $c }";
    }
}

METHODS: {
    can_ok( $BaseGrp, qw/reperit postulat communisexemplar nominisexemplaria/);
    foreach my $c ( keys %$Classes ){ 
        can_ok( $Classes->{ $c }, 'reperit' );
    } 

    LEGERE: {
        my $loadedgr = $BaseGrp->postulat;

        isa_ok( $loadedgr, 'ARRAY' );
        foreach my $g ( @$loadedgr ) {
            ok( ( grep { $g eq $_ } values %$Classes ), $g );
        }
    }
}

# 3. Call class method
CLASS_METHODS: foreach my $c ( keys %$Domains ) {
    next if $c eq 'cellphone';

    my $detected = {};
    my $thegroup = q();

    MATCH: foreach my $s ( @{ $Domains->{ $c } } ) {

        $detected = $Classes->{ $c }->reperit( $s );
        $thegroup = lc $Classes->{ $c };
        $thegroup =~ s{\A.+::}{};

        isa_ok( $detected, 'HASH', '->reperit('.$s.')' );
        is( $detected->{'group'}, $thegroup, '->reperit('.$s.')->group = '.$detected->{'group'} );
        ok( $detected->{'provider'}, '->reperit('.$s.')->provider = '.$detected->{'provider'} );
    }

    DONT_MATCH: foreach my $s ( @{$Domains->{$c}} )
    {
        $detected = $Classes->{ $c }->reperit($s.'.org');
        isa_ok( $detected, 'HASH', '->reperit' );
        is( $detected->{'group'}, q(), '->group = ' );
        is( $detected->{'provider'}, q(), '->provider = ' );

    }
}
done_testing();

__END__
