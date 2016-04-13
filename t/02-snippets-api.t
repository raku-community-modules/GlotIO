use lib 'lib';

use Test;
use GlotIO;

my GlotIO $glot .= new: key => 't/key'.IO.lines[0];

subtest {
    my $res= $glot.list;
    ok $res.keys ⊆ <next content last>, 'return keys match expectations';

    my $expected
    = <created files_hash id language modified owner public title url>;
    for |$res<content> {
        ok .keys ⊆ $expected, 'item keys match expectations';
    }
}, '.list method';


done-testing;
