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

subtest {
    my $res = $glot.create: 'perl6', 'say "Hello, World!"';
    is $res.WHAT, Hash, 'returns a Hash';
    diag "Created paste ID $res<id>";

    like $res<created>,  /^ \d**4 '-' \d\d '-' \d\d 'T' \d\d\:\d\d\:\d\d 'Z' $/,
        '`created` date looks sane';
    like $res<modified>, /^ \d**4 '-' \d\d '-' \d\d 'T' \d\d\:\d\d\:\d\d 'Z' $/,
        '`modified` date looks sane';
    like $res<files_hash>, /^ <[a..z0..9]>**40 $/, '`files_hash` looks sane';
    is   $res<id>.WHAT, Str, '`id` is a Str';
    like $res<id>, /^ <[a..zA..Z0..9]>+ $/, '`id` looks sane';
    is   $res<language>, 'perl6', '`language` is correct';
    is-deeply $res<files>, [{
            content => 'say "Hello, World!"',
            name    => 'main',
        },],
        '`files` is correct';

    is $res<owner>, 'c490baa3-1ecb-42f5-8742-216abbb97f8d',
        '`owner` looks right';
    is $res<public>, True, '`public` is True';
    is $res<title>, 'Untitled', '`title` looks right';
    is $res<url>, "https://snippets.glot.io/snippets/$res<id>",

    # clean up
    $glot.delete: $res<id>;
}, '.create method (Str for code)';

subtest {
    my $res = $glot.create: 'perl6', [
        'main.p6' => 'use lib "."; use Foo; say "Hello, World!"',
        'Foo.pm6' => 'unit module Foo;',
    ], 'Module import example',
    :mine;

    is $res.WHAT, Hash, 'returns a Hash';

    like $res<created>,  /^ \d**4 '-' \d\d '-' \d\d 'T' \d\d\:\d\d\:\d\d 'Z' $/,
        '`created` date looks sane';
    like $res<modified>, /^ \d**4 '-' \d\d '-' \d\d 'T' \d\d\:\d\d\:\d\d 'Z' $/,
        '`modified` date looks sane';
    like $res<files_hash>, /^ <[a..z0..9]>**40 $/, '`files_hash` looks sane';
    is   $res<id>.WHAT, Str, '`id` is a Str';
    like $res<id>, /^ <[a..zA..Z0..9]>+ $/, '`id` looks sane';
    is   $res<language>, 'perl6', '`language` is correct';
    is-deeply $res<files>, [
        {
        content => "use lib \".\"; use Foo; say \"Hello, World!\"",
        name    => "main.p6",
        },
        {
        content => "unit module Foo;",
        name    => "Foo.pm6",
        },
    ], '`files` is correct';

    is $res<owner>, 'c490baa3-1ecb-42f5-8742-216abbb97f8d',
        '`owner` looks right';
    is $res<public>, False, '`public` is False';
    is $res<title>, 'Module import example', '`title` looks right';
    is $res<url>, "https://snippets.glot.io/snippets/$res<id>",

    # clean up
    $glot.delete: $res<id>;
}, '.create method (Array for code)';

done-testing;
