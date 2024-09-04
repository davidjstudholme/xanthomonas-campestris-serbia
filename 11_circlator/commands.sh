### Set start position of each circular sequence to the traG gene
for i in *.fasta; do echo $i; circlator fixstart --genes_fa traG.fna $i $i.fixstart; done

### Annotate each of the fixed FASTA files to generate GenBank files for use with EasyFig
# conda activate bakta_env
for i in *.fixstart.fasta; do echo $i; bakta -v --genus Xanthomonas --complete --plasmid unnamed $i; done




### Clean up un-necessary files
rm *fixstart.tsv *fixstart.svg *.promer *.hypotheticals.tsv *.hypotheticals.faa *.json *.png *.embl *.ffn *.gff3 *contigs_with_ends.fa *gff *.faa






