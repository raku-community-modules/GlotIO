unit class GlotIO:ver<1.001001>;

use HTTP::Tinyish;
use JSON::Fast;
use URI::Escape;

has Str $.key;
has $!api-url = 'https://run.glot.io';
has $!ua      = HTTP::Tinyish.new(agent => "Perl 6 NASA.pm6");

method !request ($method, $url, $content?, *%params) {
    #%params  = %params.kv.map: { uri-escape $_ };

    my %res;
    if ( $method eq 'GET' ) {
        %res = $!ua.get: $url;
    }
    elsif ( $method eq 'POST' ) {
        %res = $!ua.post: $url,
            headers => {
                'Content-type'  => 'application/json',
                'Authorization' => "Token $!key",
            },
            content => $content;
    }
    else {
        fail "Unsupported request method `$method`";
    }

    %res<success> or fail "ERROR %res<status>: %res<reason>";
    return from-json %res<content>;
}

method languages {
    self!request('GET', $!api-url ~ '/languages').map: *<name>;
}

method versions (Str $lang) {
    my $uri = $!api-url ~ '/languages/' ~ uri-escape($lang);
    self!request('GET', $uri).map: *<version>;
}

multi method run (Str $lang, @files, :$ver = 'latest') {
    my %content;
    %content<files> = @files.map: {
        %(name => .key, content => .value )
    };
    my $uri = $!api-url ~ '/languages/' ~ uri-escape($lang)
        ~ '/' ~ uri-escape($ver);
    self!request: 'POST', $uri, to-json %content;
}

multi method run (Str $lang, Str $code, :$ver = 'latest') {
    self.run: $lang, [ main => $code ], :$ver;
}

method stdout (|c) {
    my $res = self.run(|c);
    fail "Error: $res" if $res<error>;
    $res<stdout>;
}
method stderr (|c) {
    my $res = self.run(|c);
    fail "Error: $res" if $res<error>;
    $res<stderr>;
}
