#!usr/bin/perl
use strict;
use warnings;

##
#A short script to split a nonchromosomal BED file (i.e. scaffolds) into one file per scaffold.
##

my %arrays;
#open the bed file
open (BED , "<$ARGV[0]" ) ||  die "could not open file:$!\n";


while (<BED>) {
	chomp;
	#push each line into a hash of arrays
	my @data = split "\t";
	push(@{$arrays{$data[0]}}, $_ );
}#while

#now for each scaffold print out a bed file of repeats

for my $key ( keys ( %arrays ) ) {
	#grab the corresponding array
	my @array = @{$arrays{$key}};
	#open up a bed file for each scaffold
	open ( OUT , ">$key".".bed" ) || die "Could not open file:$!\n";
	print OUT "$_\n" for @array;
}#for