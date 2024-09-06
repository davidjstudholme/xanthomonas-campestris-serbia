#!/usr/bin/perl



### david.studholme@bbsrc.ac.uk


use strict;
use warnings ;
use Bio::SeqIO ;

my $sequence_file = shift or die "Usage: $0 <sequence file>\n" ;

my $inseq = Bio::SeqIO->new('-file' => "<$sequence_file",
			    '-format' => 'fasta' ) ;

while (my $seq_obj = $inseq->next_seq ) {
  
    my $id = $seq_obj->id ;
    my $seq = $seq_obj->seq ;
    my $desc = $seq_obj->description ;

    if ($desc =~ m/length=(\d+)\s.*\s+circular=true/) {
	my $depth = $1;
	my $tags = "";
	
	if ($depth > 4500000) {
	    warn "$id is the chromosome\n";
	    $tags = "[topology=circular] [completeness=complete] [location=chromosome]"

	} else {
	    my $name = 'p'.int($depth/1000);
	    warn "$id is plasmid $name\n";
	    $tags = "circular=true [topology=circular] [completeness=complete] [plasmid-name=$name]";
	}
	
	$seq =~ s/\W+//g;
	
	print ">$id $desc $tags\n";
	print "$seq\n";
    
    } else {
	warn "Excluding $id $desc\n";
    }
}
