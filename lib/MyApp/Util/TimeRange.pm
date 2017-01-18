package MyApp::Util::TimeRange;
use strict;
use warnings;
use utf8;

sub new {
    my $class = shift;
    my ($begin, $end) = @_;
    my $self = {
        begin => $begin,
        end   => $end,
    };
    return bless $self, $class;
}

sub begin {
    my $self = shift;
    unless (@_) {
        return $self->{begin};
    }
    else {
        $self->{begin} = shift;
    }
}

sub end {
    my $self = shift;
    unless (@_) {
        return $self->{end};
    }
    else {
        $self->{end} = shift;
    }
}

sub includes {
    my ($self, $target) =@_;
    my $begin = $self->{begin};
    my $end   = $self->{end};
    
    if ($begin == $end) {
        return $target == $begin;
    }

    return $begin < $end ? $begin <= $target && $target < $end
         :                 $begin <= $target || $target < $end
         ;
}

1;
