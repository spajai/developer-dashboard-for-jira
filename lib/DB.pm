package DB;

# MySQL database configuration
use strict;
use warnings;
use File::FindLib 'lib';
use DBI;
use Conf;

sub new {
    my $class = shift;
    return bless({}, $class);

}

# connect to MySQL database
sub connect_db {
    my $self     = shift;
    my $c        = Conf->new();
    my $dsn      = $c->{database_dsn} || 'DBI:mysql:developer_report';
    my $username = $c->{database_user} || "root";
    my $password = $c->{database_pw} || 'root';
    my %attr     = (
        PrintError           => 0,    # turn off error reporting via warn()
        RaiseError           => 1,    # turn on error reporting via die()
        AutoCommit           => 1,
        mysql_auto_reconnect => 1,
    );
    return DBI->connect($dsn, $username, $password, \%attr) || die "Unable to connect to DB $@";
}

1;
