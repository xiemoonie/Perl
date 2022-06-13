#!/usr/bin/perl
use strict;
use warnings;

sub evaluateExp {
    my $exp = shift;
    my @stack;
    my ($expr) = @_;
    my @nums   = split /\s+/, $expr;
    
    for my $num (@nums) {
        if ( $num =~ /\d+$/ ) {
            push @stack, $num;
          
        }
        else {
            if ( my $fn = $exp->{$num} ) {
                $fn->( \@stack );
            }
            else {
                die "ERROR '$num';";
            }
        }

    }
   
    return pop(@stack);
}

my $op = {
    '*' => sub {
        my ($stack) = @_;
        push @$stack, pop(@$stack) * pop(@$stack);
    },
    '+' => sub {
        my ($stack) = @_;
        push @$stack, pop(@$stack) + pop(@$stack);
    },
    '-' => sub {
        my ($stack) = @_;
        my $s = pop(@$stack);
        push @$stack, pop(@$stack) - $s;
    },
    '/' => sub {
        my ($stack) = @_;
        my $s = pop(@$stack);
        my $res = pop(@$stack) / $s;
        push @$stack, $res;
    },
};
print "Ingrese expresion";
my $mathexp = <STDIN>;
my $result  = evaluateExp( $op, $mathexp );

printf "Resultado:".$result ."";
