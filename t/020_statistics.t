# $Id: 020_statistics.t,v 1.6.2.1 2013/08/30 23:05:12 ak Exp $
#  ____ ____ ____ ____ ____ ____ ____ ____ ____ 
# ||L |||i |||b |||r |||a |||r |||i |||e |||s ||
# ||__|||__|||__|||__|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
#
use lib qw(./t/lib ./dist/lib ./src/lib);
use strict;
use warnings;
use Kanadzuchi::Test;
use Kanadzuchi::Statistics;
use List::Util;
use Test::More;

#  ____ ____ ____ ____ ____ ____ _________ ____ ____ ____ ____ 
# ||G |||l |||o |||b |||a |||l |||       |||v |||a |||r |||s ||
# ||__|||__|||__|||__|||__|||__|||_______|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|
#
my $T = new Kanadzuchi::Test(
    'class' => q|Kanadzuchi::Statistics|,
    'methods' => [
        'new', 'is_number', 'round', 'size', 'sum',
        'mean', 'variance', 'stddev', 'max', 'var',
        'min', 'quartile', 'median', 'range', 'sd' ],
    'instance' => new Kanadzuchi::Statistics(), );

my $RecurrenceRelations = {
    'Normal'    => [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ],
    'Descend'   => [ 9, 8, 7, 6, 5, 4, 3, 2, 1, 0 ],
    'Cube'      => [ 1, 8, 27, 64, 125, 216, 343, 512, 729, 1000, 1331, 1728 ],
    'Fibonacci' => [ 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987 ],
    'Friedman'  => [ 25, 121, 125, 126, 127, 128, 153, 216, 289, 343, 347, 625, 688, 736, 1022, 1024 ],
    'SophieGermain' => [ 2, 3, 5, 11, 23, 29, 41, 53, 83, 89, 113, 131, 173, 179, 191 ],
};

#  ____ ____ ____ ____ _________ ____ ____ ____ ____ ____ 
# ||T |||e |||s |||t |||       |||c |||o |||d |||e |||s ||
# ||__|||__|||__|||__|||_______|||__|||__|||__|||__|||__||
# |/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|
#
PREPROCESS: {
    isa_ok( $T->instance, $T->class );
    can_ok( $T->class, @{ $T->methods } );

    isa_ok( $T->instance->sample, 'ARRAY', $T->class.'->sample()' );
    is( $T->instance->unbiased(), 1, $T->class.'->unbiased()' );
    is( $T->instance->rounding(), 4, $T->class.'->rounding()' );
}

METHODS: {
    my $object = $T->instance;
    my $classx = $T->class;
    my $rrname = q();

    IS_NUMBER: {
        ok( $classx->is_number(1) );
        ok( $classx->is_number('1') );
        ok( $classx->is_number(-1) );
        ok( $classx->is_number(1.0) );
        ok( $classx->is_number(1.01) );
        ok( $classx->is_number(0e0) );
        ok( $classx->is_number(-1e-01) );
        is( $classx->is_number(' '), 0, $classx.'->is_number( )' );
        is( $classx->is_number('beaf'), 0, $classx.'->is_number(beaf)' );
        is( $classx->is_number([]), 0, $classx.'->is_number([])' );
        is( $classx->is_number({}), 0, $classx.'->is_number({})' );
    }

    ROUND: {
        # round();
        is( $object->round(3.14), 3.14, $classx.'->round(3.14)' );
        is( $object->round(3.141), 3.141, $classx.'->round(3.141)' );
        is( $object->round(3.1415), 3.142, $classx.'->round(3.142)' );
        $object->rounding(0);
        is( $object->round(3.141593), 3.141593, $classx.'->round(3.141593,0)' );
        $object->rounding(1);
        is( $object->round(3.14), 3, $classx.'->round(3.14,1)' );
        $object->rounding(4);
        is( $object->round(3141593e-6), 3.142, $classx.'->round(3141593e-6)' );
    }

    ARRAY_REFERENCE: {
        # Array reference as an argument

        $object->sample([]);
        foreach my $rr ( keys %{ $RecurrenceRelations } ) {
            is( $object->size( $RecurrenceRelations->{ $rr } ), 
                $#{ $RecurrenceRelations->{ $rr } } + 1, $classx.'->size(['.$rr.'])' );
            is( $object->max( $RecurrenceRelations->{ $rr } ), 
                List::Util::max( @{ $RecurrenceRelations->{ $rr } } ), $classx.'->max(['.$rr.'])' );
            is( $object->min( $RecurrenceRelations->{ $rr } ), 
                List::Util::min( @{ $RecurrenceRelations->{ $rr } } ), $classx.'->min(['.$rr.'])' );
        }
    }

    OTHER_STATISTICS_METHODS: {
        # other instance methods

        NORMAL_SAMPLES: {
            # Normal
            $rrname = 'Normal',
            $object->label( $rrname );
            $object->sample( $RecurrenceRelations->{ $rrname } );

            is( $object->label, $rrname, $classx.'->label = '.$rrname );
            is( $object->size, 10, $classx.'->size = '.$rrname );
            is( $object->sum, List::Util::sum( @{ $RecurrenceRelations->{ $rrname } } ), '->sum = '.$rrname );
            is( $object->range, 9, $classx.'->range = '.$rrname );
            is( $object->mean, 4.5, $classx.'->mean = '.$rrname );
            is( $object->median, 4.5, $classx.'->median = '.$rrname );
            is( $object->quartile(1), 2.25, $classx.'->quartile(1) = '.$rrname );
            is( $object->quartile(3), 6.75, $classx.'->quartile(3) = '.$rrname );
            is( $object->max, 9, $classx.'->max = '.$rrname );
            is( $object->min, 0, $classx.'->min = '.$rrname );
            is( $object->stddev, 3.028, $classx.'->stddev = '.$rrname );
            is( $object->variance, 9.167, $classx.'->variance Unbiased = '.$rrname );

            $object->unbiased(0);
            is( $object->variance, 8.25, $classx.'->variance Baiased = '.$rrname );
            $object->unbiased(1);
        }

        DESCEND_SAMPLES: {
            # Descend
            $rrname = 'Descend';
            $object->label( $rrname );
            $object->sample( $RecurrenceRelations->{ $rrname } );

            is( $object->label, $rrname, $classx.'->label = '.$rrname );
            is( $object->size, 10, $classx.'->size = '.$rrname );
            is( $object->sum, List::Util::sum( @{ $RecurrenceRelations->{ $rrname } } ), '->sum = '.$rrname );
            is( $object->range, 9, $classx.'->range = '.$rrname );
            is( $object->mean, 4.5, $classx.'->mean = '.$rrname );
            is( $object->median, 4.5, $classx.'->median = '.$rrname );
            is( $object->quartile(1), 2.25, $classx.'->quartile(1) = '.$rrname );
            is( $object->quartile(3), 6.75, $classx.'->quartile(3) = '.$rrname );
            is( $object->max, 9, $classx.'->max = '.$rrname );
            is( $object->min, 0, $classx.'->min = '.$rrname );
            is( $object->stddev, 3.028, $classx.'->stddev = '.$rrname );
            is( $object->variance, 9.167, $classx.'->variance Unbiased = '.$rrname );

            $object->unbiased(0);
            is( $object->variance, 8.25, $classx.'->variance Baiased = '.$rrname );
            $object->unbiased(1);
        }

        CUBE_SAMPLES: {
            # Cube
            $rrname = 'Cube';
            $object->label( $rrname );
            $object->sample( $RecurrenceRelations->{ $rrname } );

            is( $object->label, $rrname, $classx.'->label = '.$rrname );
            is( $object->size, 12, $classx.'->size = '.$rrname );
            is( $object->sum, List::Util::sum( @{ $RecurrenceRelations->{ $rrname } } ), '->sum = '.$rrname );
            is( $object->range, 1727, $classx.'->range = '.$rrname );
            is( $object->mean, 507, $classx.'->mean = '.$rrname );
            is( $object->median, 279.5, $classx.'->median = '.$rrname );
            is( $object->quartile(1), 54.75, $classx.'->quartile(1) = '.$rrname );
            is( $object->quartile(3), 796.75, $classx.'->quartile(3) = '.$rrname );
            is( $object->max, 1728, $classx.'->max = '.$rrname );
            is( $object->min, 1, $classx.'->min = '.$rrname );
            is( $object->stddev, 576.144, $classx.'->stddev = '.$rrname );
            is( $object->variance, 331942, $classx.'->variance Unbiased = '.$rrname );

            $object->unbiased(0);
            is( $object->variance, 304280.167, $classx.'->variance Biased = '.$rrname );
            $object->unbiased(1);
        }

        FIBONACCI_SAMPLES: {
            # Fibonacci
            $rrname = 'Fibonacci';
            $object->label( $rrname );
            $object->sample( $RecurrenceRelations->{ $rrname } );

            is( $object->label, $rrname, $classx.'->label = '.$rrname );
            is( $object->size, 17, $classx.'->size = '.$rrname );
            is( $object->sum, List::Util::sum( @{ $RecurrenceRelations->{ $rrname } } ), '->sum = '.$rrname );
            is( $object->range, 987, $classx.'->range = '.$rrname );
            is( $object->mean, 151.941, $classx.'->mean = '.$rrname );
            is( $object->median, 21, $classx.'->median = '.$rrname );
            is( $object->quartile(1), 3, $classx.'->quartile(1) = '.$rrname );
            is( $object->quartile(3), 144, $classx.'->quartile(3) = '.$rrname );
            is( $object->max, 987, $classx.'->max = '.$rrname );
            is( $object->min, 0, $classx.'->min = '.$rrname );
            is( $object->stddev, 272.004, $classx.'->stddev = '.$rrname );
            is( $object->variance, 73985.934, $classx.'->variance Unbiased = '.$rrname );

            $object->unbiased(0);
            is( $object->variance, 69633.82, $classx.'->variance Baiased = '.$rrname );
            $object->unbiased(1);
        }

        FRIEDMAN_SAMPLES: {
            # Friedman
            $rrname = 'Friedman';
            $object->label( $rrname );
            $object->sample( $RecurrenceRelations->{ $rrname } );

            is( $object->label, $rrname, $classx.'->label = '.$rrname );
            is( $object->size, 16, $classx.'->size = '.$rrname );
            is( $object->sum, List::Util::sum( @{ $RecurrenceRelations->{ $rrname } } ), '->sum = '.$rrname );
            is( $object->range, 999, $classx.'->range = '.$rrname );
            is( $object->mean, 380.938, $classx.'->mean = '.$rrname );
            is( $object->median, 252.5, $classx.'->median = '.$rrname );
            is( $object->quartile(1), 126.75, $classx.'->quartile(1) = '.$rrname );
            is( $object->quartile(3), 640.75, $classx.'->quartile(3) = '.$rrname );
            is( $object->max, 1024, $classx.'->max = '.$rrname );
            is( $object->min, 25, $classx.'->min = '.$rrname );
            is( $object->stddev, 331.445, $classx.'->stddev = '.$rrname );
            is( $object->variance, 109855.663, $classx.'->variance Unbiased = '.$rrname );

            $object->unbiased(0);
            is( $object->variance, 102989.684, $classx.'->variance Baiased = '.$rrname );
            $object->unbiased(1);
        }

        SOPHIE_GERMAIN_SAMPLES: {
            # SophieGermain
            $rrname = 'SophieGermain';
            $object->label( $rrname );
            $object->sample( $RecurrenceRelations->{ $rrname } );

            is( $object->label, $rrname, $classx.'->label = '.$rrname );
            is( $object->size, 15, $classx.'->size = '.$rrname );
            is( $object->sum, List::Util::sum( @{ $RecurrenceRelations->{ $rrname } }), '->sum = '.$rrname );
            is( $object->range, 189, $classx.'->range = '.$rrname );
            is( $object->mean, 75.067, $classx.'->mean = '.$rrname );
            is( $object->median, 53, $classx.'->median = '.$rrname );
            is( $object->quartile(1), 17, $classx.'->quartile(1) = '.$rrname );
            is( $object->quartile(3), 122, $classx.'->quartile(3) = '.$rrname );
            is( $object->max, 191, $classx.'->max = '.$rrname );
            is( $object->min, 2, $classx.'->min = '.$rrname );
            is( $object->stddev, 67.973, $classx.'->stddev = '.$rrname );
            is( $object->variance, 4620.352, $classx.'->variance Unbiased = '.$rrname );

            $object->unbiased(0);
            is( $object->variance, 4312.329, $classx.'->variance Baiased = '.$rrname );
            $object->unbiased(1);
        }

        ZERO_SAMPLES: {
            # 0
            $rrname = 'Zero';
            $object->label( $rrname );
            $object->sample( [0, +0, -0, 00_0, 00, 0<<0, 0<<1, 0>>0, 0>>1, 0%1] );

            is( $object->label, $rrname, $classx.'->label = '.$rrname );
            is( $object->size, 10, $classx.'->size = '.$rrname );
            is( $object->sum, 0, '->sum = '.$rrname );
            is( $object->range, 0, $classx.'->range = '.$rrname );
            is( $object->mean, 0, $classx.'->mean = '.$rrname );
            is( $object->median, 0, $classx.'->median = '.$rrname );
            is( $object->quartile(1), 0, $classx.'->quartile(1) = '.$rrname );
            is( $object->quartile(3), 0, $classx.'->quartile(3) = '.$rrname );
            is( $object->max, 0, $classx.'->max = '.$rrname );
            is( $object->min, 0, $classx.'->min = '.$rrname );
            is( $object->stddev, 0, $classx.'->stddev = '.$rrname );
            is( $object->variance, 0, $classx.'->variance Unbiased = '.$rrname );

            $object->unbiased(0);
            is( $object->variance, 0, $classx.'->variance Baiased = '.$rrname );
            $object->unbiased(1);
        }

        NEGATIVE_SAMPLES: {
            # -1
            $rrname = 'Negative';
            $object->label( $rrname );
            $object->sample( [ -0, -1, -2, -3, -1e0, -1e1, -1e2 ] );

            is( $object->label, $rrname, $classx.'->label = '.$rrname );
            is( $object->size, 7, $classx.'->size = '.$rrname );
            is( $object->sum, -116.999, '->sum = '.$rrname );
            is( $object->range, 100, $classx.'->range = '.$rrname );
            is( $object->mean, -16.713, $classx.'->mean = '.$rrname );
            is( $object->median, -2, $classx.'->median = '.$rrname );
            is( $object->quartile(1), -6.5, $classx.'->quartile(1) = '.$rrname );
            is( $object->quartile(3), -1, $classx.'->quartile(3) = '.$rrname );
            is( $object->max, 0, $classx.'->max = '.$rrname );
            is( $object->min, -100, $classx.'->min = '.$rrname );
            is( $object->stddev, 36.877, $classx.'->stddev = '.$rrname );
            is( $object->variance, 1359.905, $classx.'->variance Unbiased = '.$rrname );

            $object->unbiased(0);
            is( $object->variance, 1165.633, $classx.'->variance Baiased = '.$rrname );
            $object->unbiased(1);
        }

        ERROR_CASES: {

            EMPTY: {
                # Error Case: Empty
                $object->sample([]);

                is( $object->size, 0, $classx.'->size' );
                is( $object->sum, 'NA', $classx.'->sum' );
                is( $object->range, 'NA', $classx.'->range' );
                is( $object->mean, 'NA', $classx.'->mean' );
                is( $object->median, 'NA', $classx.'->median' );
                is( $object->quartile(1), 'NA', $classx.'->quartile(1)' );
                is( $object->quartile(3), 'NA', $classx.'->quartile(3)' );
                is( $object->max, 'NA', $classx.'->max' );
                is( $object->min, 'NA', $classx.'->min' );
                is( $object->stddev, 'NA', $classx.'->stddev' );
                is( $object->variance, 'NA', $classx.'->variance' );
            }

            NULL: {
                # Error Case: Null
                $object->sample(q{});

                is( $object->size, -1, $classx.'->size' );
                is( $object->sum, 'NA', $classx.'->sum' );
                is( $object->range, 'NA', $classx.'->range' );
                is( $object->mean, 'NA', $classx.'->mean' );
                is( $object->median, 'NA', $classx.'->median' );
                is( $object->quartile(1), 'NA', $classx.'->quartile(1)' );
                is( $object->quartile(3), 'NA', $classx.'->quartile(3)' );
                is( $object->max, 'NA', $classx.'->max' );
                is( $object->min, 'NA', $classx.'->min' );
                is( $object->stddev, 'NA', $classx.'->stddev' );
                is( $object->variance, 'NA', $classx.'->variance' );
            }

            UNDEF: {
                # Error Case: undef
                $object->sample( undef );

                is( $object->size, -1, $classx.'->size' );
                is( $object->sum, 'NA', $classx.'->sum' );
                is( $object->range, 'NA', $classx.'->range' );
                is( $object->mean, 'NA', $classx.'->mean' );
                is( $object->median, 'NA', $classx.'->median' );
                is( $object->quartile(1), 'NA', $classx.'->quartile(1)' );
                is( $object->quartile(3), 'NA', $classx.'->quartile(3)' );
                is( $object->max, 'NA', $classx.'->max' );
                is( $object->min, 'NA', $classx.'->min' );
                is( $object->stddev, 'NA', $classx.'->stddev' );
                is( $object->variance, 'NA', $classx.'->variance' );
            }
        }
    }
}

done_testing();
__END__
