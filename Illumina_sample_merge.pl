#!/usr/bin/perl
use strict;
use warnings;

#open up the directory containing all your fastq.gz files
opendir(DIR, $ARGV[0]) or die "cannot open directory $ARGV[0]";
#read in the fastq files
@fastqs = grep(/\.fastq.gz$/,readdir(DIR));

#now find all the unique names in @fastqs
foreach ( @fastqs ) {
	print;
	print , "\n";
}#foreach

exit;
