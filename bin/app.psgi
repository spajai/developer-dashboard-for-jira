#!/usr/bin/env perl

use strict;
use warnings;
use File::FindLib 'lib';

# use this block if you don't need middleware, and only have a single target Dancer app to run here
use developerdashboard;



developerdashboard->to_app;

=begin comment
# use this block if you want to include middleware such as Plack::Middleware::Deflater

use developerdashboard;
use Plack::Builder;

builder {
    enable 'Deflater';
    developerdashboard->to_app;
}

=end comment

=cut

=begin comment
# use this block if you want to mount several applications on different path

use developerdashboard;
use developerdashboard_admin;

use Plack::Builder;

builder {
    mount '/'      => developerdashboard->to_app;
    mount '/admin'      => developerdashboard_admin->to_app;
}

=end comment

=cut

