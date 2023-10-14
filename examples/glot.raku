use v6.c;

use GlotIO;
my GlotIO $glot .= new: key => 't/key'.IO.lines[0];

use Data::Dump;

my $s = $glot.create: 'raku', [ 'main.raku' => 'use lib "."; use Foo; say "Hello, World!"', 'Foo.rakumod' => 'unit module Foo;', ], 'Module import example', :mine;

say Dump $s;

say $glot.delete: $s<id>;

#my $snippet = $glot.get: 'edmxttmtd5';
#say $snippet<title>;
#$snippet<title> = 'New title';
#say Dump $glot.update: $snippet;
