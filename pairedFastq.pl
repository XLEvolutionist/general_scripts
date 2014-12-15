#!/usr/bin/perl
use strict;
use warnings;
use Bio::Index::Fastq;
use Bio::SeqIO::fastq;

#Simom Renny-Byfield, UC Davis, Dec `14

#this code takes paired fastq files and filters the reads for only those that have 
#a match in both files. That is, any read that has had it's mate discarded will be thrown
#out

#usage <script.pl> <read1> <read2>

#make an index for one of the fastq files.
my $Index_File_Name0 = "$ARGV[0].idx";
#make the index for the first file
my $inx0 = Bio::Index::Fastq->new(
        '-filename' => $Index_File_Name0,
        '-write_flag' => 1);
    $inx0->make_index($ARGV[0]);

#now set up a fastq stream with Bio::SeqIO:fastq
my $in = Bio::SeqIO->new(-format    => 'fastq-sanger',
                           -file      => $ARGV[1]);
#now create two output streams, one for each of the pair                           
my $out0 = Bio::SeqIO->new(-format    => 'fastq-sanger',
                            -file      => ">$ARGV[0].clean");   
my $out1 = Bio::SeqIO->new(-format    => 'fastq-sanger',
                            -file      => ">$ARGV[1].clean");

#now open the Bio::SeqIO::fastq stream (the second file) and try to grab the sequence in
#the first file. If not present skip to the next sequence. This essentially abandons non-
#paired reads.
  
# $seq is a Bio::SeqIO::fastq object
while (my $seq1 = $in->next_seq) {
      #do stuff
      my $id1 = $seq1->id;
      if ( my $seq0 = $inx0->fetch($id1) ) {
      	$out0->write_seq($seq0);
      	$out1->write_seq($seq1);
      }#if
      else {
      	print "Did not match, next seq\n";
      }#else
}#while    

exit;
    
