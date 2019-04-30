#!/bin/bash
#SBATCH --job-name=job_submitter
#SBATCH --nodes=1
#SBATCH --mem=200MB
#SBATCH --time=1:00:00
#SBATCH --error=job_sub_error.txt
#SBATCH --output=job_sub_stdout.txt

sbatch --array=1 rna_seq_script.sh LC_C1 ERX140427
sbatch --array=1 rna_seq_script.sh LC_C2 ERX140428
sbatch --array=1 rna_seq_script.sh LC_C3 ERX140429
sbatch --array=1 rna_seq_script.sh LC_C5 ERX140431
sbatch --array=1 rna_seq_script.sh LC_C1_nor ERX140350
sbatch --array=1 rna_seq_script.sh LC_C2_nor ERX140351
sbatch --array=1 rna_seq_script.sh LC_C3_nor ERX140352
sbatch --array=1 rna_seq_script.sh LC_C5_nor ERX140353
