#!/bin/bash

# to convert the fastq_file that comes after merging paired reads and/or filtering with prinseq:

files=$(ls *.fastq)
    for f in $files;do
    ## echo $f
    /network-share/Student/SOFTWARE/seqtk/seqtk seq -a $f > $(echo $f | sed s'/.assembled.fastq/.fasta/')
    done

files=$(ls | grep '.fasta')
    for f in $files;do
        prefix=$(echo ">")$((basename "$f") | sed "s/.fasta//")$(echo "|")
        sed -i "s/>/$prefix/" $f
        sed -i "s/ /_/g" $f
    done


