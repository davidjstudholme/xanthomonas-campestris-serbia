### Get the genome sequences
ln -s ../01_genome_assemblies/*.fasta 

### Make BLAST databases
for i in *.fasta ; do echo $i ; formatdb -pF -i $i; done

### Install Entrez Direct 
sh -c "$(curl -fsSL https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/install-edirect.sh)"
sh -c "$(wget -q https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/install-edirect.sh -O -)"
export PATH=${HOME}/edirect:${PATH}

### Download the plasmid sequences
esearch -db nucleotide -query "CP066974.1 " | efetch -format fasta > CP066974.1.fna

### Do BLASTN of plasmid versus genome assemblies
for i in *.fasta; do echo $i; blastn -db $i -query CP066974.1.fna -evalue 0.0000000001 -out CP066974.1.versus.$i.blastn -outfmt 6; done



