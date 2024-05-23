#!/usr/bin/perl -w

use strict;
use warnings;

my $usage ="Usage: $0 <genomes list file>";

### Get a list of the genome sequence files

my $dir = '.' ;
opendir DIR, $dir or die $!;
my @dir = readdir(DIR);
close DIR;
my @files;
foreach my $filename (@dir) {
    if (-f $filename and
	$filename =~ m/.+genomic\.fna/ ) {
	push @files, $filename;
	warn "$filename\n";
    }
}

### Read list of genomes to be included
my $genomes_list_file = shift or die "$usage\n";
my %genomes_list;
open(GENOMES_LIST, "<$genomes_list_file") or die $!;
while (my $line = <GENOMES_LIST>) {
    chomp $line;
    unless ($line=~m/^\#/) {
	if ($line =~ m/^(\S+)\s+(.*)/) {
	    my ($accession, $genome_name) = ($1, $2);
	    foreach my $filename (@files) {
		if ($filename =~ m/$accession/) {
		    #warn "$filename exists\n";
		    $genome_name =~ s/\s+/_/g;
		    $genomes_list{$filename} = $genome_name;
		} else {
		    warn "Can't find a file $filename";
		}	    
	    }
	}
    }
}
close GENOMES_LIST;

foreach my $filename (keys %genomes_list) {
    my $genome = $genomes_list{$filename};
    my $cmd = "ln -s $filename \"$genome.contig\"  && ln -s $filename \"$genome.fasta\"";
    warn "$cmd\n";
    system($cmd);
}
