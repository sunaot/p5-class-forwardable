use strict;
use warnings;

package Foo;

use Class::Forwardable;

sub new {
    my($class) = shift;
    my $self = bless {
        accessor => Target->new(),
    }, $class;
    Class::Forwardable->delegate($self, accessor => qw(one two));
    return $self;
}


package main;

use Test::More;

subtest 'You can also define delegators in constructor.' => sub {
    my $foo = Foo->new();
    is $foo->one(), 1;
    is $foo->two(), 2;
};

done_testing;

package Target;

sub new { bless {}, shift; }
sub one { 1; }
sub two { 2; }
