#!/usr/bin/perl
use strict;
use warnings;
use DBI;

my $dsn      = "DBI:mysql:mibd";
my $username = "root";
my $password = 'lubosito';
my $dbh      = DBI->connect( $dsn, $username, $password );

my $cod = <STDIN>;

sub balance() {

    my $sql = "SELECT * FROM factura";

    my $sth = $dbh->prepare($sql);
    $sth->execute();
    my @rows = ();
    while ( my $row = $sth->fetchrow_hashref ) {
        push( @rows, $row );
    }

    foreach my $str (@rows) {
        if ( $str->{codigo} == $cod && $str->{estado} eq 'debe' ) {
            $cod = $str->{codigoFactura};
            print "codigo de factura" . $str->{codigoFactura} . " \n";
            $sth->finish();
            print "Cantidad --+-- Precio --+-- SubTotal ---+--- Total";
            my $sql1 = qq/select * from detalleproducto where codigoFactura =?/;
            my $sth1 = $dbh->prepare($sql1);
            $sth1->execute($cod);
            my ( $col1, $col2, $col3 );
            $sth1->bind_col( 2, \$col2 );
            $sth1->bind_col( 3, \$col3 );
            my @row;
            my $prodCod;
            my $cant;

            while ( @row = $sth1->fetchrow_array ) {
                print "\n $col3 \t\t";
                $prodCod = $col2;
                $cant    = $col3;
            }

            $sql1 = qq/select * from producto where codigo =?/;
            $sth1 = $dbh->prepare($sql1);
            $sth1->execute($prodCod);
            $sth1->bind_col( 1, \$col1 );
            $sth1->bind_col( 2, \$col2 );
            my $precio = 0;

            while ( @row = $sth1->fetchrow_array ) {
                print "$col2 \t\t";
                $precio = $col2;

            }
            my $total = $cant * $precio;
            print $total. "\t";

            $sql1 = qq/select * from detalleservicio where codigoFactura =?/;
            $sth1 = $dbh->prepare($sql1);
            $sth1->execute($cod);

            $sth1->bind_col( 2, \$col2 );
            $sth1->bind_col( 3, \$col3 );

            while ( @row = $sth1->fetchrow_array ) {
                print "\n $col3 \t\t";
                $prodCod = $col2;
                $cant    = $col3;
            }

            $sql1 = qq/select * from servicio where codigo =?/;
            $sth1 = $dbh->prepare($sql1);
            $sth1->execute($prodCod);
            $sth1->bind_col( 1, \$col1 );
            $sth1->bind_col( 2, \$col2 );
            my $precioservicio = 0;

            while ( @row = $sth1->fetchrow_array ) {
                print $col2. "\t\t";
                $precioservicio = $col2;

            }
            my $servicetotal = $cant * $precioservicio;
            print $servicetotal . "      \t";
            my $final = $servicetotal + $total;
            print "\n \t\t\t\t\t      " . $final;

        }
    }
}
balance();
