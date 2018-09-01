package Conf;

use strict;
use warnings;

sub new {
    my $class = shift;
    my $self;

    # ---------------------------------------------------- #
    # database settings                                    #
    # ---------------------------------------------------- #

    # The database host
   # $self->{database_host} = 'localhost';

    # The database name
    $self->{database_name} = 'developer_dashboard';

    # The database user
    $self->{database_user} = 'root';

    # The password of database user.
    $self->{database_pw} = 'root';

    # The database DSN for MySQL ==> more: "perldoc DBD::mysql"
    $self->{database_dsn} = "DBI:mysql:database=$self->{database_name}";

    $self->{database_dsn} .= ";host=$self->{database_host};" if (defined $self->{database_host});

    # ---------------------------------------------------- #
    # dashboard root directory avoid last '/'
    # ---------------------------------------------------- #

    $self->{home} = '/developer-dashboard-for-jira';

    # ---------------------------------------------------- #
    #
    # Log4Perl config file location
    # ---------------------------------------------------- #

    $self->{db_logger}             = '/developer-dashboard-for-jira/config/log4perl.conf';
    $self->{db_logger_name}        = 'dblog';
    $self->{dashboard_logger}      = '/developer-dashboard-for-jira/config/log4perl.conf';
    $self->{dashboard_logger_name} = 'dashboardlog';
    $self->{report_logger}         = '/developer-dashboard-for-jira/config/log4perl.conf';
    $self->{report_logger_name}    = 'reportlog';

    # ---------------------------------------------------- #
    # Jira tiket status to be displayed in dsr             #
    # ---------------------------------------------------- #
    $self->{jira_ticket_status} = [ 'In Progress', 'Ready for Review', 'New Deploy Plan', 'Approved', 'To Do', 'Investigate', 'New' ];

    # ---------------------------------------------------- #
    # Health Bar                  = [good , bad ,critical] #
    # ---------------------------------------------------- #
    $self->{health_bar_threshold} = [ 10, 15, 20 ];
    $self->{status_for_health_bar} = [ 'In Progress', 'Ready for Review', 'New Deploy Plan', 'Approved', 'To Do', 'Investigate', 'New' ];

    # ---------------------------------------------------- #
    # Upload and report directory config                   #
    # ---------------------------------------------------- #
    #path where file should be uploaded

    $self->{upload_dir} = '/developer-dashboard-for-jira/uploads';

    #path where finished files should be moved
    $self->{finished_dir} = '/developer-dashboard-for-jira/uploads/finished';

    #threshold after which files to be deleted (old file)
    $self->{reports_cleanup_threshold} = "25";

    # ---------------------------------------------------- #
    # Send email setting                                   #
    # ---------------------------------------------------- #

    ##see https://metacpan.org/pod/MIME::Lite#send
    #to configure according to os
    $self->{send_email} = [ "sendmail", "/usr/lib/sendmail -t -oi -oem" ];
    # $self->{to_email}   = ['email@domain.com'];
    # $self->{cc_email}   = ['email@domain.com'];

    # ---------------------------------------------------- #
    # org name                                             #
    # ---------------------------------------------------- #
    # $self->{org_name} = '<YOUR-ORG_NAME>';
    # $self->{org_bug_report_email} = ['spajai@cpan.org'];
 
    # ---------------------------------------------------- #
    # Jira settings                                        #
    # ---------------------------------------------------- #

    # $self->{custom_jira_jql} = 'labels = XXXX or ';
    # $self->{org_jira_url} = 'https://jira.<YOUR-ORG_NAME>.com/issues/?jql=';
    
    ######################################################
    # Csv to db tickets table column  map 
    # If you need new field add the csv maaping here 
    # and insert new column in db keys are Case sensetive
    ######################################################
    $self->{csv_db_field_map} = {
        'Issue key'                        => 'ticket_id',
        'Custom field (Expected Delivery)' => 'eta',
        'Status'                           => 'status',
        'Priority'                         => 'priority',
        'Summary'                          => 'summary',
        'Project key'                      => 'project',
        'Issue id'                         => 'issue_id',
        'Parent id'                        => 'parent_id',
        'Issue Type'                       => 'issue_type',
        'Resolution'                       => 'resolution',
        'Assignee'                         => 'assignee',
        'Reporter'                         => 'reporter',
        'Creator'                          => 'creator',
        'Updated'                          => 'updated',
        'Last Viewed'                      => 'last_viewed',
        'Resolved'                         => 'resolved',
        'Labels'                           => 'labels',
        'Created'                          => 'created',
    };
    #################################################
    #Custom files upload dir
    ################################################
    #path where file should be uploaded
    $self->{cust_upload_dir} = '/developer-dashboard-for-jira/custom_upload';

    #path where finished files should be moved
    $self->{cust_finished_dir} = '/developer-dashboard-for-jira/custom_upload/finished';

    #threshold after which files to be deleted (old file)
    $self->{cust_reports_cleanup_threshold} = "25";

    return bless($self, $class);
}

1;
