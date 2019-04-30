#!/bin/bash
#SBATCH --job-name=rna_seq  ### Job name
#SBATCH --mail-type=END,FAIL ### Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=firstname.lastname@nyulangone.org # Where to send mail
#SBATCH --ntasks=4 ### Run on a 4 CPU
#SBATCH --mem=64gb ### Job memory request
#SBATCH --time=10:00:00 ### Time limit hrs:min:sec
#SBATCH --output=./rna_seq_%j.log ### Standard output and error log
#SBATCH -p cpu_short ### Node

# Download the Human Genome (hg38)
wget ftp://igenome:G3nom3s4u@ussd-ftp.illumina.com/Homo_sapiens/UCSC/hg38/Homo_sapiens_UCSC_hg38.tar.gz
tar -zxvf Homo_sapiens_UCSC_hg38.tar.gz

# Load modules
module load sratoolkit/2.9.1
module load fastqc/0.11.7
module load trimgalore/0.5.0
module load python/cpu/2.7.15-ES ### CutAdapt is hidden in here
module load bbmap/38.25
module load samtools/1.9
module load subread/1.6.3

# Download datasets
fastq-dump ${1} --split-files --gzip -O ./

# Remove fastq-dump directory
rm -r ~/ncbi

# Rename files
mv ./${1}*fastq.gz ./${2}.fastq.gz

# Trim
trim_galore --q 30 \
--phred33 \
-o ./ \
--paired \
--fastqc \
./${2}_1.fastq.gz \
./${2}_2.fastq.gz

# Align
bbmap.sh \
-Xmx26G \
ref=./hg38/Homo_sapiens/UCSC/hg38/Sequence/WholeGenomeFasta/genome.fa \
in=./${2}_val_1.fq.gz \
in2=./${2}_val_2.fq.gz \
outm=./${2}.sam \
minid=0.90 \
ambiguous=random \
nodisk \

# Convert SAM to BAM, sort
samtools view -S -b ${2}.sam > ${2}..bam
samtools sort ${2}.bam -o ${2}_sorted.bam

# Create feature counts matrix
featureCounts -s 2 -p -B -C -P --ignoreDup --primary -a ./hg38/Homo_sapiens/UCSC/hg38/Annotation/Genes.gencode/genes.gtf -g gene_id -o ${2}_feature_counts ./${2}_sorted.bam
