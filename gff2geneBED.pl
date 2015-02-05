#!usr/bin/perl
use strict;
use warnings;

# Simon Renny-Byfield, UC Davis 2015

# a quick script to convert gff to bed file with gene names

#open up te input GFF
open ( GFF , "<$ARGV[0]" ) || die;

while ( <GFF> ) {
	next if m/Transposon/i;
	next if m/repeat_region/i;
	next unless m/gene/;
	next unless m/ID=gene:/;
	m/ID=gene:(\w+)/;
	my @data = split "\t";
	print "$data[0]\t$data[3]\t$data[4]\t$1\n";
	#print $1 , "\n"; 
}#while 

exit;