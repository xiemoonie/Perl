#!/usr/bin/perl

use DBI;

my $dsn      = "DBI:mysql:mibd";
my $username = "root";
my $password = 'lubosito';
my $dbh      = DBI->connect( $dsn, $username, $password );

sub list() {
    print "\n Listado de clientes deudores \n";
    my $sql = "SELECT *
             FROM factura 
             INNER JOIN cliente ON cliente.codigo = factura.codigo";
    my $sth = $dbh->prepare($sql);
    $sth->execute();

    my @rows = ();

    while ( my $row = $sth->fetchrow_hashref ) {
        push( @rows, $row );
    }

    foreach my $str (@rows) {
        if ( $str->{estado} eq 'debe' ) {
            print $str->{codigo} . "  ";
            print $str->{codigoFactura} . "  ";
            print $str->{fechaF} . "  ";
            print $str->{nombre} . "\n";
        }
    }
    $sth->finish();

}

list();
