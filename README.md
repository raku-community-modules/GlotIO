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
