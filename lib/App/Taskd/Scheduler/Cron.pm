package App::Taskd::Scheduler::Cron;

use strict;
use warnings;

use parent 'App::Taskd::Scheduler';

use Schedule::Cron;

our $singleton_schedule_cron = undef;

sub new {
    my( $class, $logger ) = @_;
    if ( ! $logger ) {
        die "No logger passed to $class->new";
    }

    $singleton_schedule_cron //= Schedule::Cron->new(
        sub { die "App::Taskd::Scheduler::Cron's null dispatcher for Schedule::Cron
            . " was called; there's a bug somehwere" }
    );

    my $self = {
        logger => $logger,
    };
    return bless $self, $class;
}

sub get_next_time_after {
    my( $self, $timespec_str, $reference_time ) = @_;

    my $next_time = eval {
        $singleton_schedule_cron->get_next_execution_time( $timespec_str, $reference_time );
    };
    if ( $@ ) {
        # If the timespec is invalid, Schedule::Cron calls die().
        # Trap that and log a warning instead.
        my $error_str = "$self was given an invalid cron timespec '$timespec_str'";
        $self->get_logger()->error( $error_str );
        die $error_str;
    }

    return $next_time;
}

1;

