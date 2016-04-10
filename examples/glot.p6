use lib 'lib';

use GlotIO;
my GlotIO $glot .= new: key => 't/key'.IO.lines[0];

say $glot.stderr: 'perl6', 'note "Hello, World!"';

=finish

say $glot.run: 'perl6', [
    'main.p6' => 'use lib "."; use Foo; doit;',
    'Foo.pm6' => 'unit module Foo; sub doit is export { say "42" }',
];
