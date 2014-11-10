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

#open an output file
open( OUT , ">$ARGV[0]".".txt" ) || die "Could not open file:$!\n";

my @posi;

#my $str = "TGTGTGTGTGNNNNNNNNNNNNNNNNNNNTTTTNNNNTTTNNTTT";
my $substr = "N";
#start looping through the sequences
while ( my $seqObj = $seqIO->next_seq() ) {
my $pos = -1;
my $name = $seqObj->id;	
my $str = $seqObj->seq();
  while (1) {
  	$pos = index($str, $substr, $pos + 1);
  	last if $pos < 0;
  	push ( @posi , $pos  );
  	#print $range[$#range] , "\n";
  }#while
  my $ranges = &num2range(@posi);
  #print $ranges , "\n";
  my @range = split /,/ , $ranges;
  foreach (@range) {
  	my @size = split /-/, $_;
  	my $len = $size[1] - $size[0];
  	#print $size[0] ,"\t" , $size[1] ,"\t" , $len , "\n";
  	if ( $len >= 100 ) {
  		print OUT "$name\t$_\n";
  	}#if
  }#foreach
  @posi=();
}#while

exit;


sub num2range {
  local $_ = join ',' => sort { $a <=> $b } @_;
  s/(?<!\d)(\d+)(?:,((??{$++1})))+(?!\d)/$1-$+/g;
  return $_;
}