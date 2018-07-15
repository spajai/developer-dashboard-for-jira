package Email;

use strict;
use warnings;

require MIME::Lite;

use File::FindLib 'lib';
use Conf;

sub new {
    return bless(
        {
            _conf => Conf->new(),
        },
        shift
    );
}




##############    WORK IN PROGRESS INCOMPLETE MODULE DO NOT USE ############ 





sub send_email {
    my $self       = shift;
    my $send_email = shift || $self->{_conf}->{send_email};
    my $to_email   = shift || $self->{_conf}->{to_email};
    my $cc_email   = shift || $self->{_conf}->{cc_email};
    my $sub        = shift;
    my $data       = shift;
    my $from       = shift;
    my $type       = shift || '*/*';
    my $msg        = MIME::Lite->new(
        From    => $data,
        To      => @$to_email,
        Cc      => @$cc_email,
        Subject => $sub,
        Type    => $type,
        Data    => $data,
    );

    return $msg->send(@$send_email);

}

1;
