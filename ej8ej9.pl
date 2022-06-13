#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';
use DBI;

my $dsn      = "DBI:mysql:mibd";
my $username = "root";
my $password = 'lubosito';
my $dbh      = DBI->connect( $dsn, $username, $password );

print 'ingrese codigo';
my $cod    = <STDIN>;
my $status = 'debe';

my $sql1 = qq/ SELECT SUM(t.debe) FROM (
SELECT (producto.precio * detalleproducto.cantidad) AS debe FROM (detalleproducto JOIN producto JOIN factura ON detalleproducto.codigoFactura = factura.codigoFactura AND detalleproducto.codigoP = producto.codigo AND factura.estado =?)
            INNER JOIN cliente ON cliente.codigo = factura.codigo WHERE cliente.codigo =? 
            UNION ALL 
SELECT (servicio.precio * detalleservicio.cantidad) AS debe FROM (detalleservicio JOIN servicio JOIN factura ON detalleservicio.codigoFactura = factura.codigoFactura AND detalleservicio.codigoS = servicio.codigo AND factura.estado =?)
            INNER JOIN cliente ON cliente.codigo = factura.codigo WHERE cliente.codigo =?) t
/;

my $sth = $dbh->prepare($sql1);
my $s   = $sth->execute( $status, $cod, $status, $cod );

my @row = $sth->fetchrow_array;
my $len = @row;

for($a = 0; $a<$len; $a = $a+1)
{
print "\@row[$a] = $row[$a]\n";
}

my $sql =
qq/ SELECT cliente.nombre, cliente.codigo FROM cliente INNER JOIN factura ON cliente.codigo = factura.codigo AND factura.estado ='debe' GROUP BY codigo
/;
$sth = $dbh->prepare($sql);
$s   = $sth->execute();
@row = $sth->fetchrow_array;
$len = @row;

for($a= 0; $a<$len; $a = $a+1)
{
print "\@row[$a] = $row[$a]\n";
}

