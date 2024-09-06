#!/bin/bash

ls *.fastq

    mkdir filtered_paired_seqs
    mkdir nopass_paired_seqs
    files=$(ls | grep '.assembled.fastq')
    for f in $files
    do 
        prefix1=$(echo 'filtered_paired_seqs/')$(echo $f | sed 's/.assembled.fastq//')
        prefix2=$(echo 'nopass_paired_seqs/')$(echo $f | sed 's/.assembled.fastq//')
        /network-share/Student/SOFTWARE/prinseq-lite-0.20.4/prinseq-lite.pl -fastq $f -min_qual_score 20 -derep 124  -out_good $prefix1 -out_bad $prefix2
    done