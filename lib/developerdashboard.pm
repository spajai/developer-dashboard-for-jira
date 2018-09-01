package developerdashboard;
use strict;
use warnings;
use File::FindLib 'lib';
use File::FindLib 'cpanlib';

use Dancer2;

use Report;
use Core;
use Report;
use Report::Data;
use Custom::Report;
use Dev;
use Utils;
use Run;
my $log    = Core->new->dashboard_logger;
my $report = Report::Data->new();
my $dev    = Dev->new();
my $util   = Utils->new();
my $cust      = Custom::Report->new();

my $temp = {};

##############################
#   Tickets Api
##############################

get '/api/v1/ticket/count' => sub {
    header('Content-Type' => 'application/json');
    return to_json $report->get_ticket_count(params->{dev} || undef);
};

get '/api/v1/ticket/summary' => sub {
    header('Content-Type' => 'application/json');
    return to_json $report->get_data_for_graph();
};

get '/api/v1/ticket/trends' => sub {
    header('Content-Type' => 'application/json');
    return to_json $report->get_trend_data();
};

get '/api/v1/ticket/count-by-year' => sub {
    header('Content-Type' => 'application/json');
    return to_json $report->get_ticket_by_month(params->{year} || undef);
};

get '/api/v1/ticket/hidden' => sub {
    header('Content-Type' => 'application/json');
    return to_json $report->get_hidden_tickets(params->{id} || undef);
};

post '/api/v1/admin/ticket/set-hidden' => sub {
    header('Content-Type' => 'application/json');
    return to_json { 'status' => $report->set_hidden_tickets(params->{id} || undef)};
};

get '/api/v1/ticket/meta/:id?' => sub {
    header('Content-Type' => 'application/json');
    my $id = route_parameters->get('id') || undef;
    return to_json $report->get_ticket_meta($id, params->{start} || undef);
};

#############################
#   Trends api
#############################

get '/view/trends' => sub {
    template 'trends';
};

##############################
#   developer/users api
#############################

get '/api/v1/dev/list/id' => sub {
    header('Content-Type' => 'application/json');
    my @user_id = $util->get_users('id');
    return to_json \@user_id;
};

get '/api/v1/dev/list/name' => sub {
    header('Content-Type' => 'application/json');
    my @user_names = $util->get_users('name');
    return to_json \@user_names;
};

get '/api/v1/dev/list' => sub {
    header('Content-Type' => 'application/json');
    my $dev_list = $util->get_users();
    return to_json $dev_list;
};

get '/view/devtickets' => sub {
    template 'dev-stats'
};

###############################
#   admin Api
##############################

get '/view/admin/dev/add' => sub {
    template 'add_dev';
};

post '/api/v1/admin/dev/add' => sub {
    header('Content-Type' => 'application/json');
    my $data = from_json(request->body);
    return to_json { status => $dev->add_dev($data) };
};

put '/api/v1/admin/dev' => sub {
    header('Content-Type' => 'application/json');
    my $data = from_json(request->body);
    return to_json { status => $dev->update_dev($data) };
};

del '/api/v1/admin/dev' => sub {
    header('Content-Type' => 'application/json');
    my $data = from_json(request->body);
    return to_json { status => $dev->delete_dev($data) };
};

get '/view/logstation' => sub {
    template 'logarea';
};

###############################
#   report Api
##############################
get '/view/admin/system_interface' => sub {
    template 'system_interface';
};

get '/api/v1/report/status' => sub {
    header('Content-Type' => 'application/json');

};

get '/api/v1/report/dashboard-modified' => sub {
    header('Content-Type' => 'application/json');
    return to_json($report->last_report());
};

get '/api/v1/admin/report/restart-report-processor' => sub {
    my $pid = fork();
    if (!$pid) {
        Run->new->process_report();    #fork and forgot
    }
};

###############################
#   upload Api
##############################
get '/upload' => sub {
    template 'upload';
};

get '/view/admin/update_dev' => sub {
    template 'update_dev'
};

post '/upload' => sub {
    my $data = request->upload('file');
    my $dir = path(config->{appdir}, 'uploads');
    mkdir $dir if not -e $dir;
    my $r = Report->new();

    my $path = path($dir, $r->generate_unique_name($data->basename));

    if (-e $path) {
        return "'$path' already exists";
    }

    $log->info("New file has been uploaded $path");
    $data->link_to($path);

    my $res = chmod 0777, ($path);

    my $pid = fork();
    $log->info("PID $pid has been forked");
    if (! $pid) {
        Run->new->process_report();
    }
    return;

};

get '/' => sub {
    template 'dashboard';
};

get '/about' => sub {
    template 'about';
};

hook before => sub {
    $util->hit;    #update counter
    if (request->path =~ /(.*)admin(.*)/ && !session('user')) {
        $log->debug("path captured path:" . request->path);
        $temp->{path_info} = request->path_info;
        $temp->{path}      = request->path;
        forward '/login';
    }
};

###############################
#   misc Api
##############################
get '/api/v1/admin/ping' => sub {
    header('Content-Type' => 'application/json');
    return to_json { success => 1 };
};

get '/api/v1/ping' => sub {
    header('Content-Type' => 'application/json');
    return to_json { success => 1 };
};

get '/api/v1/websocket' => sub {

    <<JQRY;
Not Available yet
JQRY

};

##############################
#   login/auth Api
##############################
get '/login' => sub {
    template 'login';
};

post '/login' => sub {
    my $user_value = body_parameters->get('user');
    my $pass_value = body_parameters->get('pass');
    my ($user, $valid) = $util->validate_credential($user_value, $pass_value);

    if (!$user) {
        $log->warn("Failed login for unrecognised user $user_value");
        redirect '/login?failed=1';
    } else {
        if ($valid) {
            session user => $user_value;
            $log->info("'$user_value' logged in Successfully");
            my $path      = delete $temp->{path};
            my $path_info = delete $temp->{path_info};
            redirect $path || $path_info || '/';
        } else {
            $log->debug("Login failed - password incorrect for " . $user_value);
            redirect '/login?failed=1';
        }
    }
};

##############################
#   Widget Api
##############################

get '/api/v1/widget/count' => sub {
    header('Content-Type' => 'application/json');
    return to_json($util->hit(params->{type}) || {});
};

get '/api/v1/widget/hit-count' => sub {
    header('Content-Type' => 'application/json');
    return to_json($util->hit('counter'));
};

get '/api/v1/widget/health' => sub {
    header('Content-Type' => 'application/json');
    return to_json { 'error' => 'Team Name Missing in Query Param' } unless (params->{team});
    return to_json { 'status' => $report->get_project_health(params->{team}) };
};

##############################
#   utils Api
##############################

get '/api/v1/util/query' => sub {
    header('Content-Type' => 'application/json');
    return to_json  { query => $util->get_ticket_query() || '' };
};


###############################
#   Custom Api
##############################
get 'custom/upload' => sub {
    template 'upload_1';
};

get '/view/custom' => sub {
    template 'custom'
};

post 'custom/upload' => sub {
    header('Content-Type' => 'application/json');
    my $data = request->upload('file');
    my $dir = path(config->{appdir}, 'custom_upload');
    mkdir $dir if not -e $dir;
    my $r = Report->new();
    my $name = $r->generate_custom_name($data->basename);
    my $path = path($dir, $name);

    if (-e $path) {
        return "'$path' already exists";
    }

    $log->info("New file has been uploaded $path");
    $data->link_to($path);

    my $res = chmod 0777, ($path);

    $cust->process_custom_report();

    return to_json {'name' => $name};

};

get '/api/v1/ticket/custom/trends' => sub {
    header('Content-Type' => 'application/json');
    return to_json { 'error' => 'Report Name Missing in Query Param' } unless (params->{name});
    return to_json $cust->get_trend_data(params->{name});
};

get '/api/v1/ticket/custom/reports' => sub {
    header('Content-Type' => 'application/json');
    return to_json $cust->get_custom_reports();
};

get '/api/v1/widget/custom/count' => sub {
    header('Content-Type' => 'application/json');
    return to_json $cust->get_custom_report_count();
};


###########################
#   Capture unknown
###########################
any qr{.*} => sub {
    template '404', { home => '/' , email => $util->get_org_email };
};

true;
