package App::Taskd::Task;

use strict;
use warnings;

sub new {
    my( $class, $logger, $scheduler ) = @_;

    if ( ! $logger ) {
        die "No logger passed to $class->new";
    }
    if ( ! $scheduler ) {
        my $error_str = "No scheduler passed to $class->new";
        $logger->error( $error_str );
        die $error_str;
    }

    my $self = {
        logger    => $logger,
        scheduler => $scheduler,
    };

    return bless $self, $class;
}

sub get_timespec {
    my( $self ) = @_;
    my $error_str = "App::Taskd::Task::get_timespec() called for $self; subclasses must override this";
    $self->get_logger()->error( $error_str );
    die $error_str;
}

sub get_logger {
    my( $self ) = @_;
    return $self->{logger};
}

sub get_scheduler {
    my( $self ) = @_;
    return $self->{scheduler};
}

sub get_next_runtime_after {
    my( $self, $reference_time ) = @_;
    my $timespec = $self->get_timespec();
    return $self->get_scheduler()->get_next_time_after( $timespec, $reference_time );
}

sub run {
    my( $self ) = @_;
    my $error_str = "App::Taskd::Task::run() called for $self; subclasses must override this";
    $self->get_logger()->error( $error_str );
    die $error_str;
}

1;

