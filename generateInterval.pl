#!usr/bin/perl
use strict;
use warnings;
use Bio::SeqIO;

###############################
#Simon Renny-Byfield, UC Davis, 7th November 2014, version 1
###############################

#usage script.pl <fasta> 

#This script takes fasta files and splits the sequences into individual files

#Initialize the Bio:SeqIO object; 
#my $seqIO = Bio::SeqIO -> new ( -format => "fasta" , -file => $ARGV[0] );

my $str = "TGTGTGTGTGNNNNNNNNNNNNNNNNNNNTTTTNNNNTTTNNTTT";
my $substr = "N";
#start looping through the sequences
#while ( my $seqObj = $seqIO->next_seq() ) {
my $pos = -1;	
#my $str = $seqObj->seq();
  while (1) {
  	$pos = index($str, $substr, $pos + 1);
  	last if $pos < 0;
  	print $pos . "\n";
  }#while	
#}#while

exit;
