package Path::Tiny::Archive::Tar;

# ABSTRACT: Tar/untar add-on for file path utility

use strict;
use warnings;

use Archive::Tar ();
use Path::Tiny qw( path );


our $VERSION = '0.001';


BEGIN {
    push(@Path::Tiny::ISA, __PACKAGE__);
}

=method tar

    path("/tmp/foo.txt")->tar("/tmp/foo.tar");
    path("/tmp/foo")->tar("/tmp/foo.tar");

Creates a tar archive and appends a file or directory tree to it. Returns the
path to the archive or undef.

=cut

sub tar {
    my ($self, $dest, $level) = @_;

    $dest = path($dest);

    my $tar = Archive::Tar->new;

    if ($self->is_file) {
        my $file = Archive::Tar::File->new(file => $self->stringify());

        return unless $file;

        $file->name($self->basename);
        $file->prefix('');

        $tar->add_files($file) or return;
    }
    elsif ($self->is_dir) {
        my $paths = $self->iterator({ recurse => 1 });

        while (my $path = $paths->()) {
            my $file = Archive::Tar::File->new(file => $path->stringify());

            return unless $file;

            $file->rename($path->relative($self));

            $tar->add_files($file) or return;
        }
    }
    else {
        return;
    }

    $tar->write($dest->stringify(), defined $level ? $level : ()) or return;

    return $dest;
}

=method untar

    path("/tmp/foo.tar")->untar("/tmp/foo");

Extracts a tar archive to specified directory. Returns the path to the
destination directory or undef.

=cut

sub untar {
    my ($self, $dest) = @_;

    $dest = path($dest);

    my $files = Archive::Tar->iter($self->stringify());

    return unless $files;

    while (my $file = $files->()) {
        $file->extract($dest->child($file->full_path)->stringify()) or return;
    }

    return $dest;
}


1;


=head1 DESCRIPTION

This module provides two additional methods for L<Path::Tiny> for working with
tar archives.

=cut
