#!/usr/bin/perl
use strict; 
use warnings;
use Getopt::Std;
use Array::Utils qw(:all);

######
#Simon Renny-Byfield, Dec `14 UC Davis
######

#usage perl <script.pl -m <md5 output> -c <md5sums output>

#This script takes output from the Mac OS X md5, and the linux command md5sum
#and compares the hash values for a list of files. This is mostly written to check the 
#integrity of sequencing files generated from WGS Illumina sequencing of 70 teosinte
#individuals from PalMar Chico, Mexico. I doubt it will have much utility for anyone else.

#declare some useful variables
my %opts;
my %md5;
my %sums;

#declare the command line options
getopts('m:c:' , \%opts);  #

#Load the file paths and md5 checksums as key value pairs.


#First load in the md5 style output
#open up the file
open ( MD5 , "<$opts{m}" ) || die "could not open file $opts{m}:$!\n"; 

#cycle through the file
while ( <MD5> ) {
	chomp;
	#remove some useless text
	s/MD5//g;
	s/[(|)]//g;
	#remove the first part of the path as this will change
	s/\/Volumes\///;
	#split the data into checksum and path
	my @data = split "=";
	#remove any unwanted whitespace
	@data = grep(s/\s*//g, @data);
	#load the data into a hash
	$md5{$data[0]} = $data[1];
	print $data[0] , "\n";
}#while
close MD5;

#Load in the md5sum style output

#open up the file
open ( CHK , "<$opts{c}" ) || die "could not open file $opts{c}:$!\n"; 

#cycle through the file
while ( <CHK> ) {
	chomp;
	#remove the first part of the path as this will change
	s/\/Volumes\///;
	#split the data into checkcsum and path
	my @data = split /\s+/;
	#remove any unwanted whitespace
	@data = grep(s/\s*//g, @data);
	#load the data into a hash
	$sums{$data[1]} = $data[0];
}#while
close CHK;

#Now cycle through all the files and check the md5 sums match.
#Report any files in 'md5' but not the 'sums', and report any checksum failures
#list files in a "good" list (where the file is present and the MD5 sum checks out)
#and a "bad" list, where either the file is missing or the checksum is bad.

#generate a list of file paths for each checksum list
my @list1 = keys(%md5);
my @list2 = keys(%sums);

#figure out what is in list1 but not list2, i.e. what files didn't make it to iPlant 
my @minus = array_minus( @list1, @list2 );
#open up an error file to report those missing
open (MISSING , ">missing_files.txt" ) || die "could not open file $!\n";
#report the missing files
print MISSING "$_\n" for @minus;

#open an output file for files passing md5 the check
open ( PASS , ">passed_files.txt" ) || die "Could not open file:$!\n";
#open a file for files that have failed the md5 check
open ( FAIL , ">failed_files.txt" ) || die "Could not open file:$!\n";
 
#figure out what files made it...
my @isect = intersect(@list2, @list1);
#for each of these files perform the check
foreach ( @isect ) {
 	unless (defined $md5{$_} and defined $sums{$_} ) {
 		print STDERR "error missing md5 value\n";
 		print FAIL $_ , "\tmissing MD% value\n";
 	}#unles
 	#grab the md5 sum
 	my $md=$md5{$_};
 	my $sms=$sums{$_};
 	#compare the md5 sums
 	if ( $md eq $sms ) {
 		#if passed print to the passed file
 		print PASS "$_\t$md\t$sms\n";
 	}#if
 	else {
 		#if failed print to the failed file
 		print FAIL "FAILED: $_\t$md\t$sms\n";
 	}#else
 }#foreach
 close PASS;
 close FAIL;
 
 exit;
