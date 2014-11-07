#!usr/bin/perl
use strict;
use warnings;

####
#Simon Renny-Byfield, University of California Davis, November 2014
####

## Help text in perldoc format
=head1 SYNOPSIS

cleanChrNames.pl - 	cleans long chromosome names such that they are 
					suitable for entry input to lastz.

=head1 USAGE

cleanChrNames.pl fasta_file

=head1 AUTHOR

Simon Renny-Byfield (sbyfield@ucdavis.edu)

=cut


##open the input file

open ( FASTA , "$ARGV[0]" ) || die "Could not open file:$!\n";

#cycle through the file

while ( <FASTA> ) {
	#see if the line is the header line
	if ( m/>/ ) {
		#give the sequence a new name
		$_=~ m/chromosome\s+(\d+),/;
		print ">Chr$1\n";
	}#if
	else {
		#print the line
		print;
	}#else
}