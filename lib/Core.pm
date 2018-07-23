package Core;
use strict;
use warnings;

use File::FindLib 'lib';

use Parse::CSV;
use Crypt::SaltedHash;
use Conf;
use Log::Log4perl;
sub new {
    bless({ _conf => Conf->new }, shift);
}

sub db_logger{
    my $self = shift;
    Log::Log4perl::init($self->{_conf}->{db_logger});
    return Log::Log4perl->get_logger($self->{_conf}->{db_logger_name});
}

sub dashboard_logger {
    my $self = shift;
    Log::Log4perl::init($self->{_conf}->{dashboard_logger});
    return Log::Log4perl->get_logger($self->{_conf}->{dashboard_logger_name});
}

sub report_logger {
    my $self = shift;
    Log::Log4perl::init($self->{_conf}->{report_logger});
    return Log::Log4perl->get_logger($self->{_conf}->{report_logger_name});
}

sub get_pass {
    my ($self, $secret) = (@_);
    my $csh = Crypt::SaltedHash->new(algorithm => 'SHA-256');
    $csh->add($secret);
    return $csh->generate;
}

sub valid_pass {
    my ($self, $salt, $secret) = (@_);
    return Crypt::SaltedHash->validate($salt, $secret);
}

sub log_conf {
    return $_[0]->{_conf}->{$_[1]};
}

1;
