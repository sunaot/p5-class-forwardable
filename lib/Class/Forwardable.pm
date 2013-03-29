package Class::Forwardable;

use 5.012003;
use strict;
use warnings;

use Scalar::Util qw(blessed);

our $VERSION = '0.01';

sub delegate {
    my($class, $proxy, $accessor, @methods) = @_;
    my $f = $class->new();
    $f->__def_delegate($proxy, $accessor, @methods);
    undef;
}

sub new {
    my $class = shift;
    bless {}, $class;
}

sub __def_delegate {
    my($self, $proxy, $accessor, @methods) = @_;
    my $proxy_class = blessed($proxy) ? ref $proxy : $proxy;
    no strict 'refs';
    for my $m (@methods) {
        *{$proxy_class . '::' . $m} = $self->__delegate_method($accessor, $m);
    }
}

sub __delegate_method {
    my($forwardable_obj, $accessor, $method_name) = @_;
    sub {
        my($self, @args) = @_;
        return $self->{$accessor}->$method_name(@args);
    };
}

# Preloaded methods go here.

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Class::Forwardable - Perl extension for blah blah blah

=head1 SYNOPSIS

  use Class::Forwardable;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for Class::Forwardable, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.


=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

Sunao Tanabe, E<lt>tanabe.sunao@apple.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2013 by Sunao Tanabe

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.12.3 or,
at your option, any later version of Perl 5 you may have available.


=cut
