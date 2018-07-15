package developerdashboard;
use strict;
use warnings;
use File::FindLib 'lib';

use Dancer2;

use Core;

use Report;
use Report::Data;
use Dev;
use Utils;
use Run;

my $log    = Core->new->dashboard_logger;
my $report = Report::Data->new();
my $dev    = Dev->new();
my $util   = Utils->new();

my $temp = {};

##############################
#   Tickets Api
##############################

get '/api/v1/ticket/count' => sub {
    header('Content-Type' => 'application/json');
    return encode_json $report->get_ticket_count(params->{dev} || undef);
};

get '/api/v1/ticket/count-by-year' => sub {
    header('Content-Type' => 'application/json');
    return encode_json $report->get_ticket_by_month(params->{year} || undef);
};

# get '/api/v1/ticket/hidden' => sub {
# header('Content-Type' => 'application/json');

# };

# post '/api/v1/admin/ticket/set-hidden' => sub {
# header('Content-Type' => 'application/json');

# };

###############################
#   admin Api
##############################

post '/api/v1/admin/dev/add' => sub {
    my $data = decode_json(request->body);
    return $dev->add_dev($data);
};

get '/admin/view/logstation' => sub {
    redirect '/';
};

###############################
#   report Api
##############################
get '/api/v1/report/status' => sub {
    header('Content-Type' => 'application/json');

};

get '/api/v1/report/dashboard-modified' => sub {
    header('Content-Type' => 'application/json');
    return encode_json($report->last_report());
};

get '/api/v1/admin/report/restart-report-processor' => sub {
    my $pid = fork();
    if (!$pid) {
        Report->new->process_report();    #fork and forgot
    }
};

###############################
#   upload Api
##############################
get '/upload' => sub {
    template 'upload';
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
    if (not $pid) {
        Run->new->process_report();
    }
    return;

};

get '/' => sub {
    template 'login';
};

get '/about' => sub {
    template 'about';
};

hook before => sub {
    $util->hit;    #update counter
    if (request->path =~ /(get-|ping)/) {
        header('Content-Type' => 'application/json');
    }

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
    return encode_json { reply => 'pong', success => 1 };
};

get '/api/v1/ping' => sub {
    header('Content-Type' => 'application/json');
    return encode_json { reply => 'pong', success => 1 };
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
            $log->info("Sucessfully login for " . $user_value);
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
    return encode_json($util->hit(params->{type}) || {});
};

get '/api/v1/widget/hit-count' => sub {
    header('Content-Type' => 'application/json');
    return encode_json($util->hit('count'));
};

get '/api/v1/widget/health' => sub {
    header('Content-Type' => 'application/json');
    return encode_json { 'ERROR' => 'Team Name Missing in Query Param' } unless (params->{team});
    return encode_json { 'STATUS' => $report->get_project_health(params->{team}) };
};

get '/api/v1/widget/health' => sub {
    header('Content-Type' => 'application/json');
    return encode_json { 'ERROR' => 'Team Name Missing in Query Param' } unless (params->{team});
    return encode_json { 'STATUS' => $report->get_project_health(params->{team}) };
};

###########################
#   Capture unknown
###########################
any qr{.*} => sub {
    template '404', { home => '/' };
};

true;