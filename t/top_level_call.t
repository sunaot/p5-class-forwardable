use strict;
use warnings;

package Foo;

use Class::Forwardable;

Class::Forwardable->delegate(__PACKAGE__, accessor => qw(one two));

sub new {
    my($class) = shift;
    bless {
        accessor => Target->new(),
    }, $class;
}


package main;

use Test::More;

subtest 'Class::Forwardable->delegate() can be defined on top level.' => sub {
    my $foo = Foo->new();
    is $foo->one(), 1;
    is $foo->two(), 2;
};

done_testing;

package Target;

sub new { bless {}, shift; }
sub one { 1; }
sub two { 2; }
