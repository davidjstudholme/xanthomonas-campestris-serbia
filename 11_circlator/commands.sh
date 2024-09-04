### Set start position of each circular sequence to the traG gene
for i in *.fasta; do echo $i; circlator fixstart --genes_fa traG.fna $i $i.fixstart; done



