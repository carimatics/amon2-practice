package MyApp::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;
use MyApp::Util::TimeRange;

any '/' => sub {
    my ($c) = @_;    
    my $counter = $c->session->get('counter') || 0;
    $counter++;
    $c->session->set('counter' => $counter);
    return $c->render('index.tx', {
        page    => 'index',
        counter => $counter,
    });
};

post '/reset_counter' => sub {
    my $c = shift;
    $c->session->remove('counter');
    return $c->redirect('/');
};

post '/account/logout' => sub {
    my ($c) = @_;
    $c->session->expire();
    return $c->redirect('/');
};

get '/timerange' => sub {
    my $c = shift;
    return $c->render('time_range.tx', {
        page => 'timerange',
    });
};

post '/timerange' => sub {
    my ($c) = @_;
    my $begin  = $c->req->parameters->{begin};
    my $end    = $c->req->parameters->{end};
    my $target = $c->req->parameters->{target};
    
    my $range = MyApp::Util::TimeRange->new($begin, $end);
    my $result = $range->includes($target) ? "含まれます" : "含まれません";
    
    return $c->render('time_range.tx', {
            page   => 'timerange',
            begin  => $begin,
            end    => $end,
            target => $target,
            result => $result,
    });
};

1;
