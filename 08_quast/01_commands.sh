### Get NCBI's datasets utility
curl -o datasets 'https://ftp.ncbi.nlm.nih.gov/pub/datasets/command-line/v1/linux-amd64/datasets'
chmod u+x datasets

### Use NCBI's datasets utility to download genome sequences
./datasets download genome accession --inputfile xanthomonas_assm_accs.txt  --exclude-gff3 --exclude-protein --exclude-rna --exclude-genomic-cds --filename xanthomonas_genome_assemblies.zip

### Unzip the the downloaded files and symlink to current directory
unzip xanthomonas_genome_assemblies.zip
ln -s ncbi_dataset/data/GCA_*/GCA_*.fna .
ls *.fna

### Run QUAST
### assumes that QUAST is installed
#conda activate quast_env
quast.py *.fna

