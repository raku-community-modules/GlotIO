use lib 'lib';

use GlotIO;
my GlotIO $glot .= new: key => 't/key'.IO.lines[0];

use Data::Dump;
say Dump $glot.list(:4page, :!mine);
