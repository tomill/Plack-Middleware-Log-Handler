use strict;
use warnings;
use Test::More;

use Plack::Builder;
use Plack::Test;
use HTTP::Request::Common;

my @logs;

my $app = builder {
    enable 'Log::Handler',
        forward => {
            forward_to => sub { push @logs, shift->{message} },
            message_layout => '[%L] %m',
        };
    
    sub {
        my $env = shift;
        $env->{'psgix.logger'}->({ level => 'warn', message => 'Yo!' });
        return [200, [], "OK"]
    };
};

test_psgi $app, sub {
    my $cb = shift;
    my $res = $cb->(GET "/");
    
    is_deeply \@logs, [ "[WARNING] Yo!\n" ];
};

done_testing;
