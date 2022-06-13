#!/usr/bin/perl

use strict;
use warnings;

sub convert {
    my ( $nm, $bs, $bs2 ) = @_;
    my $s = "";
    my $t = 0;

    for my $c ( split( //, lc($nm) ) ) {
        my $s = "0123456789abcdefghijklmnopqrstuvwxyz";
        my $str   = substr $s, 0, $bs;

        my $err = index( $str, $c );
        if ( $err == -1 ) {
            print "error";
            exit;
        }
        else {
            $t = $bs * $t + $err;
        }

    }

    while ($t) {
        $s .= ( '0' .. '9', 'a' .. 'z' )[ $t % $bs2 ];
        $t = int( $t / $bs2 );
    }

    return scalar(reverse($s));
}

print "The num: ";
my $num = <STDIN>;
print "The base: ";
my $base = <STDIN>;
print "The base to convert: ";
my $b = <STDIN>;

chomp $num;
chomp $base;
chomp $b;

if ( ( $base >= 2 && $base <= 25 ) && ( $b >= 2 && $b <= 25 ) ) {

    print convert( $num, $base, $b );

}
else {
    print "ERROR";
    exit;
}