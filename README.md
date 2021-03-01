# NAME

Path::Tiny::Archive::Tar - Tar/untar add-on for file path utility

# VERSION

version 0.001

# DESCRIPTION

This module provides two additional methods for [Path::Tiny](https://metacpan.org/pod/Path::Tiny) for working with
tar archives.

# METHODS

## tar

    path("/tmp/foo.txt")->tar("/tmp/foo.tar");
    path("/tmp/foo")->tar("/tmp/foo.tar");

Creates a tar archive and appends a file or directory tree to it. Returns the
path to the archive or undef.

## untar

    path("/tmp/foo.tar")->untar("/tmp/foo");

Extracts a tar archive to specified directory. Returns the path to the
destination directory or undef.

# AUTHOR

Denis Ibaev <dionys@gmail.com>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2021 by Denis Ibaev.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
