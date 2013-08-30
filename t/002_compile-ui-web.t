use strict;
use warnings;
use lib qw(./t/lib ./dist/lib ./src/lib);
use Test::More;

my $Modules = [ qw/
    Kanadzuchi::UI::Web
    Kanadzuchi::UI::Web::About
    Kanadzuchi::UI::Web::Aggregate
    Kanadzuchi::UI::Web::DailyUpdates
    Kanadzuchi::UI::Web::Delete
    Kanadzuchi::UI::Web::Dispatch
    Kanadzuchi::UI::Web::Index
    Kanadzuchi::UI::Web::ListOf
    Kanadzuchi::UI::Web::MasterTables
    Kanadzuchi::UI::Web::Profile
    Kanadzuchi::UI::Web::Search
    Kanadzuchi::UI::Web::Summary
    Kanadzuchi::UI::Web::Test
    Kanadzuchi::UI::Web::Token
    Kanadzuchi::UI::Web::Update
/ ];

SKIP: {
    eval {
        require CGI::Application;
        require CGI::Application::Dispatch;
        require CGI::Application::Plugin::TT;
        require CGI::Application::Plugin::Session;
        require CGI::Application::Plugin::HTMLPrototype;
    };

    skip( 'CGI::Application::* is not installed', scalar @$Modules ) if $@;
    foreach my $module ( @$Modules ){ use_ok $module; }
}
done_testing();

__END__
