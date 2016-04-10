[![Build Status](https://travis-ci.org/zoffixznet/perl6-GlotIO.svg)](https://travis-ci.org/zoffixznet/perl6-GlotIO)

# NAME

GlotIO - use glot.io API via Perl 6

# SYNOPSIS

```perl6
use GlotIO;
my GlotIO $glot .= new: :key<89xxxx9f-a3ec-4445-9f14-6xxxe6ff3846>;

say $glot.languages;
```

# DESCRIPTION

This module lets you use API provided [glot.io](http://glot.io) which is
a pastebin that also lets you execute code in a number of languages.

# KEY

Some parts of the API require you register at glot.io and [obtain an
API key](https://glot.io/api)

# METHODS

## `.new`

```perl6
my GlotIO $glot .= new: :key<89xxxx9f-a3ec-4445-9f14-6xxxe6ff3846>;
```

Constructs and returns a new `GlotIO` object. Takes one **optional**
argument: `key`, which is [the API key](https://glot.io/api).
Methods that require the key are marked as such.

## `.languages`

```perl6
say "Glot.io supports $_" for $glot.languages;
```

Returns a list of languages supported by GlotIO.

## `.versions`

```perl6
say "Glot.io supports $_ version of Perl 6"
    for $glot.versions: 'perl6';
```

Returns a list of supported versions for a language that
must be supplied as the mandatory positional argument. List of valid
language names can be obtained via `.languages` method. Using an
invalid language will `fail` an an HTTP 404 error.

## `.run`

```perl6
    say $glot.run: 'perl6', 'say "Hello, World!"';

    say $glot.run: 'perl6', [
        'main.p6' => 'use lib "."; use Foo; doit;',
        'Foo.pm6' => 'unit module Foo; sub doit is export { say "42" }',
    ];

    say $glot.run: 'python', 'print "Hello, World!"', :ver<2>;
```

Requests code to run on Glot. The first positional argument specifies
the language to use (see `.languages` method). Second argument
can either be an `Str` of code to run or an `Array` of `Pair`s. If the
array is specified, the key of each `Pair` specifies the filename and
the value specifies the code for that file. The first file in the
array will be executed by Glot, while the rest are supporting files,
such as modules loaded by the first file.

The optional named argument `ver` can be used to specify the version
of the language to use. See `.versions` method.

Returns a `Hash` with three keys: `stdout`, `stderr` which specify
the output streams received from the program and `error` that
seems to contain an error code, if the program doesn't successfully
exit.

If an incorrect language or version are specified, will `fail` with
an HTTP 404 error.

## `.stdout`

```perl6
    say $glot.stdout: 'perl6', 'say "Hello, World!"';
```

A shortcut for calling `.run` (takes same arguments) and returning
just the `stdout` key. Will `fail` with the entire `Hash` returned
from `.run` if the program errors out.

## `.stderr`

```perl6
    say $glot.stderr: 'perl6', 'note "Hello, World!"';
```

A shortcut for calling `.run` (takes same arguments) and returning
just the `stderr` key. Will `fail` with the entire `Hash` returned
from `.run` if the program errors out.

----

# REPOSITORY

Fork this module on GitHub:
https://github.com/zoffixznet/perl6-GlotIO

# BUGS

To report bugs or request features, please use
https://github.com/zoffixznet/perl6-GlotIO/issues

# AUTHOR

Zoffix Znet (http://zoffix.com/)

# LICENSE

You can use and distribute this module under the terms of the
The Artistic License 2.0. See the `LICENSE` file included in this
distribution for complete details.
