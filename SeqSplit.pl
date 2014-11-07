#!usr/bin/perl
use strict;
use warnings;
use Bio::SeqIO;

###############################
#Simon Renny-Byfield, UC Davis, 7th November 2014, version 1
###############################

#usage script.pl <fasta> <max_seq_size>

#This script takes large, genome size, fasta sequences and breaks each sequence (i.e. chromosomes) 
#into smaller subsequences such that each one is at most 10,000,000 bp long. 
#This is the limit that LastZ will work with.

#Initialize the Bio:SeqIO object; 
my $seq_obj = Bio::SeqIO -> new ( -format => "fasta" , -file => $ARGV[0] );

#start looping through the sequences
while ( my $seqIO = $seq_obj->next_seq() ) {
	#get the sequence length
	my $len = $seqIO->length;
	my $name = $seqIO->id;
	#if the length is over 10,000,000 break up the sequence
	if ( my $len >= 10000000 ) {
		my $fileNum = ceil($len/10000000);
		print "$name\t$fileNum\n";
	}
}#while

exit;