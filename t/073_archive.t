# $Id: 073_archive.t,v 1.2.2.1 2013/08/30 23:05:12 ak Exp $
#  ____ ____ ____ ____ ____ ____ ____ ____ ____ 
# ||L |||i |||b |||r |||a |||r |||i |||e |||s ||
# ||__|||__|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
use lib qw(./t/lib ./dist/lib ./src/lib);
use strict;
use warnings;
use Kanadzuchi::Test;
use Kanadzuchi::Archive;
use Test::More;

#  ____ ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ 
# ||G |||l |||o |||b |||a |||l |||       |||v |||a |||r |||s ||
# ||__|||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|
#
my $A = new Kanadzuchi::Test(
    'class' => 'Kanadzuchi::Archive',
    'methods' => [ 'ARCHIVEFORMAT', 'new', 'compress', 'is_available' ],
    'instance' => new Kanadzuchi::Archive( 'input' => './examples/17-messages.eml' ),
);

PREPROCESS: {
    isa_ok( $A->instance, $A->class );
    can_ok( $A->class, @{ $A->methods } );
}

CONSTRUCTOR: {
    my $z = $A->instance;
    my $c = $A->class;

    isa_ok( $z, $c );
    isa_ok( $z->input, 'Path::Class::File', '->input = '.$z->input->stringify );
    isa_ok( $z->output, 'Path::Class::File', '->output = '.$z->output->stringify );
    ok( $c->ARCHIVEFORMAT, '->ARCHIVEFORMAT = '.$c->ARCHIVEFORMAT );
    ok( $z->filename, '->filename = '.$z->filename );
    is( $z->format, 'gzip', '->format = gzip' );
    is( $z->prefix, 'gz', '->prefix = gz' );
    is( $z->override, 0, '->override = 0' );
    is( $z->cleanup, 0, '->cleanup = 0' );
    is( $z->level, 6, '->level = 6' );
}

done_testing();
__END__
