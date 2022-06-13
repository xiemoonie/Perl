#!/usr/bin/perl -w

use JSON;
use LWP::UserAgent;
my $ua = LWP::UserAgent->new;
$ua->agent("MyApp/0.1");

print "City";
my $city = <STDIN>;

my $req = HTTP::Request->new(
        GET => "https://api.openweathermap.org/data/2.5/weather?q="
      . $city
      . "&appid=b6f179d1717ace3ec8adbb9a8845d7eb" );
$req->content_type('application/json');

my $res = $ua->request($req);

if ( $res->is_success ) {
    my $info = $res->content;
    my $j    = decode_json($info);
    printf "\n La ciudad es:" . $city;
    print "\n Clima:" . $j->{weather}->[0]->{main};
    print "\n Descripcion:" . $j->{weather}->[0]->{description};
    print "\n Temperatura:" . $j->{main}->{temp};
    print "\n Humidity:" . $j->{main}->{humidity} . "%";
    print "\n Country:" . $j->{sys}->{country};

}
else {
    print $res->status_line, "n";
}
