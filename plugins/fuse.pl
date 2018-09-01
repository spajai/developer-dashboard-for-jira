#!/usr/bin/perl -w 
use Fuse::Simple qw(main);
use LWP::UserAgent;
use JSON;
use Data::Dumper;
sub get_ticket_info
{
    my ($url) = (@_);
    my $ua = LWP::UserAgent->new();
    my $resp = $ua->get($url); 
    #print Dumper(from_json($resp->content)), "\n" ;
    return from_json($resp->content); 

 
}

sub transform_data 
{
    my ($in_data) = (@_); 
    my $trans_data = {} ; 
    for my $val (values(%{$in_data})) {
        $trans_data->{$val->{'Issue key'}} = {  %{$val}{'Status', 'Priority', 'Summary' , 'Parent id'} } ;  

    }

    return $trans_data; 

}

my $tickets = get_ticket_info('http://localhost:5000/api/v1/ticket/meta/'); 
my $trans_data = transform_data( $tickets); 

#print Dumper($trans_data); 

 #exit(0);
main(
  "mountpoint" => "/tmp/ftest",      # actually optional
  "debug"      => 0,           # for debugging Fuse::Simple. optional
  "fuse_debug" => 0,           # for debugging FUSE itself. optional
  "threaded"   => 0,           # optional
  "/"          => transform_data($tickets), # required :-)
);
#print Dumper($trans_data); 
