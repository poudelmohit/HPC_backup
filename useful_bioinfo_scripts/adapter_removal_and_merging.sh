#!/bin/bash

files=$(ls | grep 'R1_001.fastq.gz')
    #    echo $files
    for f in $files
    do 
        r1=$f
        r2=$(echo $f | sed 's/R1/R2/')
        base=$(echo $f | sed 's/.gz//')
        AdapterRemoval --file1 $r1 --file2 $r2 --threads 12 --basename $base --gzip
    done

    mkdir adapterremoved_reads/
    mv *pair?* adapterremoved_reads
    mkdir adapterremoval_extrafiles/
    mv *discarded.gz adapterremoval_extrafiles/
    mv *singleton.truncated.gz adapterremoval_extrafiles/
    mv *settings adapterremoval_extrafiles/

    cd adapterremoved_reads && ls

## merging of paired seqs:

    mkdir paired_seqs

    files=$(ls | grep '_R1_001.fastq.pair1.truncated.gz')
    
    for f in $files
    do 
        reverse=$(echo $f | sed 's/.pair1./.pair2./')
        prefix=$(echo 'paired_seqs/')$(echo $f | sed 's/_R1_001.fastq.pair1.truncated.gz//')
        # echo $reverse
        # echo $prefix
        /network-share/Student/SOFTWARE/pear-0.9.11-linux-x86_64/bin/pear -f $f -r $reverse -o $prefix
    done
