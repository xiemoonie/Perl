#!/usr/bin/perl -w
use strict;
use warnings;
use Switch;
my %rot13;

my $filename = '.\texto.txt';
my $message;

print "Press: \n 1 for cifrado \n 2 for descifrado";
my $act = <STDIN>;

open( FH, '<', $filename ) or die $!;

while (<FH>) {
    $message = $_;
    print $_;
}

close(FH);

sub rot13() {
    $message = shift;
    my $new_message = undef;
    if ( $act == 1 ) {
     
        if ( keys(%rot13) == 0 ) {
            my @letter_keys = ( "A" .. "Z", "a" .. "z" );
            my @letter_values =
              ( "N" .. "Z", "A" .. "M", "n" .. "z", "a" .. "m" );
            for ( my $i = 0 ; $i <= $#letter_keys ; $i++ ) {
                $rot13{ $letter_keys[$i] } = $letter_values[$i];
            }
        }

    }
    elsif ( $act == 2 ) {
        if ( keys(%rot13) == 0 ) {
            my @letter_keys =
              ( "N" .. "Z", "A" .. "M", "n" .. "z", "a" .. "m" );
            my @letter_values = ( "A" .. "Z", "a" .. "z" );
            for ( my $i = 0 ; $i <= $#letter_keys ; $i++ ) {
                $rot13{ $letter_keys[$i] } = $letter_values[$i];
            }
        }
    }
    foreach ( split( "", $message ) ) {
        if ( exists $rot13{$_} ) {

            #letters
            $new_message .= $rot13{$_};
        }
        else {
            #numbers and symbols
            $new_message .= $_;
        }
    }

    return $new_message;
}

$message = &rot13( $message, $act );

open( FH, '>', $filename ) or die $!;
print FH $message;
close(FH);
