use lib 'lib';

use GlotIO;
my GlotIO $glot .= new: key => 't/key'.IO.lines[0];

say $glot.versions: 'perl6';
