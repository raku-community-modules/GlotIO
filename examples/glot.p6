use lib 'lib';

use GlotIO;
my GlotIO $glot .= new: key => 't/key'.IO.lines[0];

use Data::Dump;
say Dump $glot.create: 'perl6', [
        'main.p6' => 'use lib "."; use Foo; say "Hello, World!"',
        'Foo.pm6' => 'unit module Foo;',
    ], 'Module import example',
    :mine;
