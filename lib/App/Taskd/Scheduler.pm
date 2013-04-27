package App::Taskd::Scheduler;

use strict;
use warnings;

sub new {
    my( $class, $logger ) = @_;
    if ( ! $logger ) {
        die "No logger passed to $class->new";
    }

    my $self = {
        logger => $logger,
    };
    return bless $self, $class;
}

sub get_logger {
    my( $self ) = @_;
    return $self->{logger};
}

sub get_next_time_after {
    my( $self, $timespec, $reference_time ) = @_;
    my $error_str = "App::Taskd::Scheduler::get_next_time_after() called for $self; subclasses must override this";
    $self->get_logger()->error( $error_str );
    die $error_str;
}

1;

