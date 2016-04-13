use lib 'lib';

use Test;
use GlotIO;

my GlotIO $glot .= new: key => 't/key'.IO.lines[0];

subtest {
    my $res= $glot.list;
    ok $res.keys ⊆ <next content last>, 'return keys match expectations';

    for |$res<content> {
        my $expected = <created file_hash id language modified owner public title url>;
        my $got = .keys;
        say $expected.perl;
        say $got.perl;
        ok $got ⊆ $expected, 'item keys match expectations';
    }
}, '.list method';


done-testing;
