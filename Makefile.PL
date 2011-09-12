use inc::Module::Install;
all_from 'lib/Plack/Middleware/Log/Handler.pm';
readme_from;

requires 'Plack';
requires 'Log::Handler';

test_requires 'Test::More' => 0.96; # subtest/done_testing
test_requires 'HTTP::Request::Common';
auto_include_deps;

tests_recursive;

repository 'http://github.com/tomi-ru/Plack-Middleware-Log-Handler';
bugtracker 'http://github.com/tomi-ru/Plack-Middleware-Log-Handler/issues';

WriteAll;
