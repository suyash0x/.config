#!/usr/bin/perl

use strict;
use warnings;

my %braces = (
'(' => ')',
'[' => ']',
'{' => '}',
'\''=> '\'',
'"' => '"',
'`' => '`'
);

my $opening_bracket = <STDIN>;
chomp($opening_bracket);
my $closing_bracket = $braces{$opening_bracket};

print "$closing_bracket\n";


