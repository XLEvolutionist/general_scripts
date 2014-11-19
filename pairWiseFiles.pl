#!/usr/bin/perl

use strict; 
use warnings;
use Algorithm::Combinatorics qw(combinations);

#Simon Renny-Byfield, UC Davis, November 11, 2014. version 1

###
#A perl script to input a directory full of fasta files to produce
#complete pairwise lists for input into LastZ.
###

opendir my $dir, "$ARGV[0]" or die "Cannot open directory: $!";
my @files = readdir $dir;
closedir $dir;

@files = grep ( /.fasta$/ , @files);

my $iter = combinations(\@files, 2);

while (my $c = $iter->next) {
    
    my $string = "@$c\n";
    next if $string =~ m/scaffold/;
    my @data = split /\s+/ , $string;
    print $data[0] , "\t" , $data[1] , "\n";
}#while

exit;