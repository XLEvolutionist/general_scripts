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
my $seqIO = Bio::SeqIO -> new ( -format => "fasta" , -file => $ARGV[0] );

#also intilize a file to contain all the nam
#start looping through the sequences
while ( my $seqObj = $seqIO->next_seq() ) {
	#get the sequence id
	my $name = $seqObj->id;
	#open up a new file with the seq id as name
	open(NEWFASTA, ">$name".".fasta" ) || die "could not open file:$!\n";
	#print the name of the sequence
	print NEWFASTA ">$name\n";
	#grab the sequence string
	my $seqstr = $seqObj->seq();
	#print it
	print NEWFASTA "$seqstr\n";
	#close the file handle
	close(NEWFASTA) 
}#while

exit;