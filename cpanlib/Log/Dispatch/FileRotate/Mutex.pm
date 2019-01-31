#
# This file is part of Log-Dispatch-FileRotate
#
# This software is copyright (c) 2005 by Mark Pfeiffer.
#
# This is free software; you can redistribute it and/or modify it under
# the same terms as the Perl 5 programming language system itself.
#

package Log::Dispatch::FileRotate::Mutex;
$Log::Dispatch::FileRotate::Mutex::VERSION = '1.36';
# ABSTRACT: Flock Based File Mutex.

use strict;
use warnings;
use Carp 'croak';

use Log::Dispatch::FileRotate::Flock qw(safe_flock flopen);
use Fcntl ':flock';

my $HAS_THREADS = $INC{'threads.pm'} ? 1 : 0;
my $THREAD_ID   = $HAS_THREADS ? threads->tid() : 0;

sub CLONE {
    $THREAD_ID = threads->tid() if $HAS_THREADS;
}

sub DESTROY {
    my $self = shift;

    my $pid = $self->pid;

    if ($self->{$pid}) {
        $self->unlock;
        close(delete $self->{_fh});
    }

    return;
}


sub new {
    my ($class, $path, %args) = @_;

    $class = ref $class || $class;

    my $self = bless {
        _path => $path,
        %args
    }, $class;

    return $self;
}


sub lock {
    my $self = shift;

    my $pid = $self->pid;

    unless (exists $self->{$pid}) {
        # we have not opened the lockfile in this thread.
        my ($fh, $inode) = flopen($self->{_path});

        $self->_set_permissions;

        unless (defined $fh) {
            return 0;
        }

        $self->{_fh}    = $fh;
        $self->{_inode} = $inode;
        $self->{$pid}   = 1;
    }
    elsif ($self->{$pid} == 0) {
        # file is open, but not locked.
        if (safe_flock($self->{_fh}, LOCK_EX)) {
            my ($inode) = (stat $self->{_path})[1];

            if ($inode != $self->{_inode}) {
                # file was removed or changed underneath us, reopen instead
                delete $self->{$pid};

                close(delete $self->{_fh});

                delete $self->{$pid};
                delete $self->{_inode};

                return $self->lock;
            }

            $self->{$pid} = 1;
        }
    }

    # otherwise this $pid is already holding the lock

    return $self->{$pid} || 0;
}

sub _set_permissions {
    my $self = shift;

    unless (defined $self->{permissions}) {
        return;
    }

    my $file = $self->{_path};

    my $current_mode = (stat $self->{_path})[2] & 07777;

    if ($current_mode ne $self->{permissions}) {
        chmod $self->{permissions}, $self->{_path}
            or croak sprintf 'Failed to chmod %s to %04o: %s',
                $self->{_path}, $self->{permissions} & 07777, $!;
    }
}


sub unlock {
    my $self = shift;

    my $pid = $self->pid;

    if ($self->{$pid}) {
        safe_flock($self->{_fh}, LOCK_UN);
        $self->{$pid} = 0;
    }
}


sub pid {
    return $HAS_THREADS
        ? join('.', $$, $THREAD_ID)
        : $$;
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Log::Dispatch::FileRotate::Mutex - Flock Based File Mutex.

=head1 VERSION

version 1.36

=head1 SYNOPSIS

Internal Use Only!

=head1 DESCRIPTION

Internal Use Only!

=head1 METHODS

=head2 new($path)

Create a new mutex for the given file path.  Only one mutex per path should be
created.  The path will not actually be opened or locked until you call L<lock>.

=head2 lock()

Obtains a lock on the path.  If the thread id or pid has changed since the path
was opened, the path will be re-opened automatically in this thread or process.

=head2 unlock()

Releases the lock if the current thread or process is holding it.

=head2 pid(): string

Get the current process or thread id

=head1 SOURCE

The development version is on github at L<https://https://github.com/mschout/perl-log-dispatch-filerotate>
and may be cloned from L<git://https://github.com/mschout/perl-log-dispatch-filerotate.git>

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website
L<https://github.com/mschout/perl-log-dispatch-filerotate/issues>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

Michael Schout <mschout@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2005 by Mark Pfeiffer.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
