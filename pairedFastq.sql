#!/usr/bin/perl
use strict;
use warnings;
use Bio::Index::Fastq;


#Simom Renny-Byfield, UC Davis, Dec `14

#this code takes paired fastq files and filters the reads for only those that have 
#a match in bith files. That is any read that has had it's mate discarded will be thrown
#out

#usage <script.pl> <read1> <read2>


# Complete code for making an index for several
    # fastq files

    use strict;

    my $Index_File_Name = shift;
    my $inx = Bio::Index::Fastq->new(
        '-filename' => $Index_File_Name,
        '-write_flag' => 1);
    $inx->make_index(@ARGV);

    # Print out several sequences present in the index
    # in Fastq format
    use Bio::Index::Fastq;
    use strict;

    my $Index_File_Name = shift;
    my $inx = Bio::Index::Fastq->new('-filename' => $Index_File_Name);
    my $out = Bio::SeqIO->new('-format' => 'Fastq','-fh' => \*STDOUT);

    foreach my $id (@ARGV) {
        my $seq = $inx->fetch($id); # Returns Bio::Seq::SeqWithQuality object
	$out->write_seq($seq);
    }

    # or, alternatively

    my $seq = $inx->get_Seq_by_id($id); #identical to fetch