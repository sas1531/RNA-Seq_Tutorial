#!/bin/bash
#SBATCH --job-name=job_submitter
#SBATCH --nodes=1
#SBATCH --mem=200MB
#SBATCH --time=1:00:00
#SBATCH --error=job_sub_error.txt
#SBATCH --output=job_sub_stdout.txt

sbatch --array=1 rna_seq_script.sh ERX140427  LC_C1
sbatch --array=1 rna_seq_script.sh ERX140428  LC_C2
sbatch --array=1 rna_seq_script.sh ERX140429  LC_C3
sbatch --array=1 rna_seq_script.sh ERX140431  LC_C5
sbatch --array=1 rna_seq_script.sh ERX140350  LC_C1_nor
sbatch --array=1 rna_seq_script.sh ERX140351  LC_C2_nor
sbatch --array=1 rna_seq_script.sh ERX140352  LC_C3_nor
sbatch --array=1 rna_seq_script.sh ERX140353  LC_C5_nor
