package Plack::Middleware::Log::Handler;
use 5.008001;
use strict;
use warnings;
our $VERSION = '0.01';

use parent 'Plack::Middleware';

use Log::Handler;

sub wrap {
    my ($class, $app, @args) = @_;
    my $self = bless {
        app    => $app,
        logger => Log::Handler->new(@args),
    }, $class;
    
    $self->to_app;
}

sub call {
    my ($self, $env) = @_;
    
    $env->{'psgix.logger'} = sub {
        my $msg = shift;
        $self->{logger}->log($msg->{level}, $msg->{message});
    };
    
    $self->app->($env);
}

1;
__END__

=head1 NAME

Plack::Middleware::Log::Handler - A logger middleware for Log::Hander fan

=head1 SYNOPSIS

  use Plack::Builder;
  
  builder {
      enable "LogWarn";
      enable "Log::Handler",
          file => {
              filename => 'logs/app.log',
              maxlevel => 'debug',
          };
  
      $app;
  };

=head1 DESCRIPTION

Plack::Middleware::Log::Handler is a L<Plack::Middleware> component
that allows you to use L<Log::Handler> to configure logging object.

=head1 CONFIGURATION

All arguments are passed to C<< Log::Handler->new() >>.

It means...

  builder {
      enable "Log::Handler" config => "config/logger.conf";
      $app;
  };

is equal to...

  $logger = Log::Handler->new(config => "config/logger.conf");

And,

  builder {
      enable "Log::Handler"
          file     => { ... },
          file     => { ... },
          sendmail => { ... },
      ;
      
      $app;
  };

this means...

  $logger = Log::Handler->new(
      file     => { ... },
      file     => { ... },
      sendmail => { ... },
  );

=head1 SEE ALSO

L<Log::Handler>, L<Plack::Builder>

=head1 AUTHOR

Naoki Tomita E<lt>tomita@cpan.orgE<gt>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
