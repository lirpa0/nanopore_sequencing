#!/usr/bin/env bash
#SBATCH --job-name=dorado3
#SBATCH --partition=dept_gpu
#SBATCH --gres=gpu:3
#SBATCH --array=1-3

exp_string="exp7"
run_string=$(sed -n "${SLURM_ARRAY_TASK_ID}p" runs.txt) #txt file that has list of runs


#basecall (convert raw nanopore pod5 into sequencing data bam)
./dorado-0.7.2-linux-x64/bin/dorado basecaller hac /net/dali/home/carvunis/aar75/nanopore/${exp_string}/${run_string}/pod5 --kit-name SQK-PCB114-24 > /net/dali/home/carvunis/aar75/nanopore/${exp_string}/${run_string}/basecalled_multiplex.bam

#demultiplex (sort reads based on their barcode)
./dorado-0.7.2-linux-x64/bin/dorado demux -o /net/dali/home/carvunis/aar75/nanopore/${exp_string}/${run_string}/basecalled --no-classify /net/dali/home/carvunis/aar75/nanopore/${exp_string}/${run_string}/basecalled_multiplex.bam

#align reads to the genome (each barcode will have its own bam file)
./dorado-0.7.2-linux-x64/bin/dorado aligner /net/dali/home/carvunis/aar75/GCF_000146045.2_R64_genomic.fna /net/dali/home/carvunis/aar75/nanopore/${exp_string}/${run_string}/basecalled --output-dir /net/dali/home/carvunis/aar75/nanopore/${exp_string}/${run_string}/aligned


