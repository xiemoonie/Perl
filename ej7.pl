#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';
use DBI;

my $dsn      = "DBI:mysql:mibd";
my $username = "root";
my $password = 'lubosito';
my $dbh      = DBI->connect( $dsn, $username, $password );

if ( !$dbh ) {
    print "Connection problem: $DBI::errstr\n";
}
else {
    eval {
        my @ddl = (
            "CREATE TABLE Producto (
			codigo int(11) NOT NULL PRIMARY KEY,
			precio float(32) NOT NULL
	        ) ENGINE=InnoDB;",
            "CREATE TABLE Servicio (
		  codigo int(11) NOT NULL PRIMARY KEY,
		  precio float(32) NOT NULL
		) ENGINE=InnoDB;",
            "CREATE TABLE Cliente (
		  codigo int(11) NOT NULL PRIMARY KEY,
          nombre varchar(32) NOT NULL
		) ENGINE=InnoDB",
            "CREATE TABLE Factura (
		  codigoFactura int(11)NOT NULL PRIMARY KEY,
          codigo int(11),
          estado varchar(32),
          fechaF date,
          FOREIGN KEY(codigo) REFERENCES Cliente(codigo)
		) ENGINE=InnoDB",
            "CREATE TABLE DetalleProducto(
		  codigoFactura int(11) NOT NULL PRIMARY KEY,
		  codigoP int(11),
          cantidad int(11)
		) ENGINE=InnoDB"
            ,
            "CREATE TABLE DetalleServicio(
		  codigoFactura int(11) NOT NULL PRIMARY KEY,
		  codigoS int(11),
          cantidad int(11)
		) ENGINE=InnoDB"
        );

        # execute all create table statements
        for my $sql (@ddl) {
            $dbh->do($sql);
        }
        my $sql = "INSERT INTO cliente(codigo,nombre)
	   VALUES(?,?)";

        my $stmt = $dbh->prepare($sql);
        $stmt->execute( 1, 'juan' )  or die $DBI::errstr;
        $stmt->execute( 2, 'maria' ) or die $DBI::errstr;
        $stmt->execute( 3, 'ana' )   or die $DBI::errstr;

        $sql = "INSERT INTO producto(codigo,precio)
	   VALUES(?,?)";

        $stmt = $dbh->prepare($sql);
        $stmt->execute( 50, 10.00 ) or die $DBI::errstr;
        $stmt->execute( 51, 20.00 ) or die $DBI::errstr;
        $stmt->execute( 52, 30.00 ) or die $DBI::errstr;

        $sql = "INSERT INTO servicio(codigo,precio)
	   VALUES(?,?)";

        $stmt = $dbh->prepare($sql);
        $stmt->execute( 60, 100.00 ) or die $DBI::errstr;
        $stmt->execute( 61, 200.00 ) or die $DBI::errstr;
        $stmt->execute( 62, 300.00 ) or die $DBI::errstr;

        $sql = "INSERT INTO factura(codigoFactura,codigo,estado,fechaF)
	   VALUES(?,?,?,?)";

        $stmt = $dbh->prepare($sql);
        $stmt->execute( 100, 1, 'pagado', '2022-01-01' ) or die $DBI::errstr;
        $stmt->execute( 101, 1, 'pagado',   '2021-02-01' ) or die $DBI::errstr;
        $stmt->execute( 102, 2, 'pagado',   '2021-03-01' ) or die $DBI::errstr;
        $stmt->execute( 103, 3, 'debe',   '2020-05-01' ) or die $DBI::errstr;
        $stmt->execute( 104, 2, 'pagado', '2021-03-01' ) or die $DBI::errstr;
        $stmt->execute( 105, 3, 'debe',   '2020-05-01' ) or die $DBI::errstr;

        $sql = "INSERT INTO detalleservicio(codigoFactura,codigoS,cantidad)
	   VALUES(?,?,?)";

        $stmt = $dbh->prepare($sql);
        $stmt = $dbh->prepare($sql);
        $stmt->execute( 100, 60, 2 ) or die $DBI::errstr;
        $stmt->execute( 101, 61, 1 ) or die $DBI::errstr;
        $stmt->execute( 102, 62, 3 ) or die $DBI::errstr;
        $stmt->execute( 103, 60, 1 ) or die $DBI::errstr;
        $stmt->execute( 104, 62, 3 ) or die $DBI::errstr;
        $stmt->execute( 105, 60, 1 ) or die $DBI::errstr;


        $sql = "INSERT INTO detalleproducto(codigoFactura,codigoP,cantidad)
	   VALUES(?,?,?)";

        $stmt = $dbh->prepare($sql);
        $stmt->execute( 100, 50, 1 ) or die $DBI::errstr;
        $stmt->execute( 101, 51, 2 ) or die $DBI::errstr;
        $stmt->execute( 102, 52, 2 ) or die $DBI::errstr;
        $stmt->execute( 103, 50, 3 ) or die $DBI::errstr;
   

        $stmt->finish();

        say "All tables created successfully!";
    };

    if ($@) {
        print ":c Problem: $@\n";
    }
}
