use strict;
use warnings;

package Foo;

use Class::Forwardable;

sub def_delegators {
    my $self = shift;
    Class::Forwardable->delegate($self, accessor => qw(one two));
}

sub new {
    my($class) = shift;
    my $self = bless {
        accessor => Target->new(),
    }, $class;
    $self->def_delegators();
    return $self;
}


package main;

use Test::More;

subtest 'Class::Forwardable enables to delegate methods.' => sub {
    my $foo = Foo->new();
    is $foo->one(), 1;
    is $foo->two(), 2;
};

done_testing;

package Target;

sub new { bless {}, shift; }
sub one { 1; }
sub two { 2; }
