# NAME

Plack::Middleware::Log::Handler - A logger middleware for Log::Hander fan

# SYNOPSIS

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

# DESCRIPTION

Plack::Middleware::Log::Handler is a [Plack::Middleware](https://metacpan.org/pod/Plack%3A%3AMiddleware) component
that allows you to use [Log::Handler](https://metacpan.org/pod/Log%3A%3AHandler) to configure logging object.

# CONFIGURATION

All arguments are passed to `Log::Handler->new()`.

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

# WHY ANOTHER Plack::Middleware::Log::Blabla

I don't like the module that to use just another module like Foo::View::Blabla.
I know this module is one of the Plack::Middleware::Log::Foobar module.
But I recommend Log::Handler than Log::Dispatch or Log::Log4perl.
Log::Handler is more configurable, fast, and flexible (I point "Forward").
So, I wrote this module.

# SEE ALSO

[Log::Handler](https://metacpan.org/pod/Log%3A%3AHandler), [Plack::Builder](https://metacpan.org/pod/Plack%3A%3ABuilder)

# AUTHOR

Naoki Tomita <tomita@cpan.org>

# LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
