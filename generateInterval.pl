#!usr/bin/perl
use strict;
use warnings;
use Bio::SeqIO;

###############################
#Simon Renny-Byfield, UC Davis, 10th November 2014, version 2
#redacted the use of BioPerl in the second version.
###############################

#usage script.pl <fasta> 

#This script takes fasta files and splits the sequences into individual files

#open the input file
open ( FASTA, "<$ARGV[0]" ) || die "Could not open file:$!\n";

#open an output file
open( OUT , ">$ARGV[0]".".txt" ) || die "Could not open file:$!\n";

my @posi;
my $substr = "N";
my $name="";
my $string="";
my %seq;

while ( <FASTA> ) {
	if  ( m/>(\S+)/ ) {
		$name = $1;
	}#if
	else {
		$seq{$name}.=$_;
	}#else
	
}#while
close FASTA;
print "loaded in file..\n";


#now for each sequence
for my $key ( keys ( %seq ) ) {
		my $pos = -1;
		my $name = $key;
		my $str = $seq{$key};
  		while (1) {
  			$pos = index($str, $substr, $pos + 1);
  			last if $pos < 0;
  			push ( @posi , $pos  );
  		}#while
  		my $ranges = &num2range(@posi);
  		@posi=();
  		#print $ranges , "\n";
  		my @range = split /,/ , $ranges;
  		foreach (@range) {
  			my @size = split /-/, $_;
  			next unless scalar @size > 1;
  			my $len = $size[1] - $size[0];
  			#print $size[0] ,"\t" , $size[1] ,"\t" , $len , "\n";
  			#if ( $len >= 100 ) {
  				print OUT "$name\t$size[0]\t$size[1]\n";
  			#}#if
  		}#foreach
  		
		$name = $1;
}#
close OUT;
exit;


sub num2range {
  local $_ = join ',' => sort { $a <=> $b } @_;
  s/(?<!\d)(\d+)(?:,((??{$++1})))+(?!\d)/$1-$+/g;
  return $_;
}