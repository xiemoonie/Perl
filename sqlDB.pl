#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';
use DBI;

my $dsn      = "DBI:mysql:";
my $username = "root";
my $password = 'lubosito';

my $dbh = DBI->connect( $dsn, $username, $password );
$dbh->disconnect();
print 1 == $dbh->do("create database mibd")
  ? "Data Base Created \n"
  : "Data Base Already Exists\n";

my $table = `perl ej7.pl`;
print $table;
print "Ingrese codigo de cliente";
my $balance = `perl ej8.pl`;
print $balance;
my $list = `perl ej9.pl`;
print $list;

