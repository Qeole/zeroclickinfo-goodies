package DDG::Goodie::Utf8Char;
# ABSTRACT: Gives UTF-8 code for a given character, or character for a given UTF-8 code.

use DDG::Goodie;

zci answer_type => "utf8char";
zci is_cached   => 1;

name "Utf8Char";
description "UTF-8 characters and codes";
primary_example_queries 'utf8 ☺', 'utf-8 u+263a';
secondary_example_queries 'UTF-8 Code \t';
code_url "https://github.com/duckduckgo/zeroclickinfo-goodies/blob/master/lib/DDG/Goodie/Utf8Char.pm";
attribution github  => ['https://github.com/Qeole','Qeole'],
            twitter => ['https://twitter.com/qeole','Qeole'];

triggers any => "utf8", "utf-8";

handle remainder => sub {

    # Character to UTF-8 code
    $_ =~ m/^(code\s*)?(.|\\[0abtnfre])$/i;
    if ($2) {
        my $char =
        $2 eq '\0' ? "\0" :
        $2 eq '\a' ? "\a" :
        $2 eq '\b' ? "\b" :
        $2 eq '\t' ? "\t" :
        $2 eq '\n' ? "\n" :
        $2 eq '\f' ? "\f" :
        $2 eq '\r' ? "\r" :
        $2 eq '\e' ? " "  :
        $2;
        return "'" . $char . "' = U+" . uc(sprintf("%x", ord($char)));
    }
    
    # UTF-8 code to character
	$_ =~ m/^(code\s*)?(u\+?|0?x)?([\da-f]{2,6})$/i;
    return unless $3;
    
    my $hex =     $3;
    my $dec = hex($3);
    
    return unless ($dec <= 0x10FFFF);
    
    return 'U+' . uc($hex) . " = '" . chr($dec) . "'";
};

1;
