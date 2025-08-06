#!/usr/bin/env bash
cd /home/aar75/long_read_polysome/exp7/analysis/20250805/;
mkdir bedtools_quantify;


for sample_file in bed/*.bed;
 do 
 
  sample_name=$(grep -o "run[0-9]_barcode[0-9][0-9]" <<< $sample_file)
  echo "$sample_name";
  echo "$sample_file";
 
  bedtools intersect -a /home/aar75/long_read_polysome/exp2/20240826/cORF.bed -b $sample_file -f 0.95 -c > bedtools_quantify/${sample_name}_95_cORF.bed &
  bedtools intersect -a /home/aar75/long_read_polysome/exp2/20240826/translated_nORFs.bed -b $sample_file -f 0.95 -c > bedtools_quantify/${sample_name}_95_nORF.bed 
done

