#!/bin/bash

# works inside the directory 'ustacks_output' where all files coming from ustacks are saved.

rm -r overall_fasta_to_blast.fasta
# removes pre-created file before writing a new one

for f in $(ls *.tags.tsv);do
    prefix=$(echo ">")$((basename "$f") | sed "s/.tags.tsv//")$(echo "__")    
    grep 'consensus' $f | sed "s/^/$prefix/" | sed 's/consensus/\n/' | tr -d '\t' | sed 's/[0-9]\{3\}$//' >> overall_fasta_to_blast.fasta
done

# to add '>' followed by sample id and double underscore between sample id and the consensus number for the sample
# adds prefix to the start of each line and replace consenus with new line
# also removes all tabs and the three digits present at the last of each sequence line by stacks

