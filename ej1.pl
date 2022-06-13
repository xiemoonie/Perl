#!/usr/bin/perl

use strict;
use warnings;

my $w1 = "hola";
my $w2 = "hola";

sub anagram {
    my ( $word1, $word2 ) = @_;
    return "falso" if $word1 eq $word2 || length $word1 != length $word2;
    my $letters1 = join "", sort split "", $word1;
    my $letters2 = join "", sort split "", $word2;
    if ( $letters1 eq $letters2 ) {
        return "verdadero";
    }
}

print anagram( $w1, $w2 );
