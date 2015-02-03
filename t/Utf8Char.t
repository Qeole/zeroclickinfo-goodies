#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use DDG::Test::Goodie;

zci answer_type => "utf8char";
zci is_cached   => 1;

ddg_goodie_test(
    [qw( DDG::Goodie::Utf8Char )],
    'utf-8 u+263a'  => test_zci(qr/^U\+263A = /),   # primary_example_queries
#    'utf8 ☺'        => test_zci(qr/ = U\+263A$/),   # primary_example_queries
    'UTF-8 Code \t' => test_zci(qr/^'\s' = U\+9$/), # secondary_example_queries
    
    'utf8 a'        => test_zci("'a' = U+61"),      # Character to code
#    'utf8 é'        => test_zci(qr/ = U\+E9$/),
#    'utf8 €'        => test_zci(qr/ = U\+20AC$/),
    'utf8 \n'       => test_zci(qr/\n.* = U\+A$/m),
    'utf8 \e'       => test_zci("' ' = U+20"),
    'utf8 \0'       => test_zci(qr/ = U\+0$/),
    
    'utf8 code a'   => test_zci("'a' = U+61"),
    'code utf8 a'   => test_zci("'a' = U+61"),
    'utf-8 a'       => test_zci("'a' = U+61"),
    'code utf-8 a'  => test_zci("'a' = U+61"),
    'utf-8 code a'  => test_zci("'a' = U+61"),
    'UTF8 a'        => test_zci("'a' = U+61"),
    'UTF8 Code a'   => test_zci("'a' = U+61"),
    
    'utf8 263a'     => test_zci(qr/^U\+263A = /),    # Code to character
    'utf8 0x263a'   => test_zci(qr/^U\+263A = /),
    'utf8 x263a'    => test_zci(qr/^U\+263A = /),
    'utf8 u263a'    => test_zci(qr/^U\+263A = /),
    'utf8 u+263a'   => test_zci(qr/^U\+263A = /),
    'utf8 U+263A'   => test_zci(qr/^U\+263A = /),
    'utf8 Code 61'  => test_zci("U+61 = 'a'"),
    'utf8 u+10FFFF' => test_zci(qr/^U\+10FFFF = /),
    
    'utf8'          => undef,   # No arg
    'utf8 code'     => undef,   # No arg
    'utf8 u+110000' => undef,   # Too high
    'utf8 263aaf'   => undef,   # Too high
    'utf8 0000263a' => undef,   # Too long
    'utf8 263g'     => undef,   # Not a hex
    'utf8 +263a'    => undef,   # Missing '+'
    'utf8 263a FOO' => undef,   # Something else
    'utf8 \y'       => undef,   # Not a char
    'utf8 263 code' => undef,   # "Code" can't be at the end
);

done_testing;
