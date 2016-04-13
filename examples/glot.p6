use lib 'lib';

use GlotIO;
my GlotIO $glot .= new: key => 't/key'.IO.lines[0];

use Data::Dump;

my $snippet = $glot.get: 'edmxttmtd5';
say $snippet<title>;
$snippet<title> = 'New title';
say Dump $glot.update: $snippet;
