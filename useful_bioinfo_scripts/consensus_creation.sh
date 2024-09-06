#!/bin/bash

export PATH="~/local/bin/stacks:$PATH"

mkdir ustacks_output
for f in $(ls *.fasta);do
    ustacks -t fasta -f $f -o ./ustacks_output -m 25 -M 1 --force-diff-len
done

cd ustacks_output
mkdir cstacks_output
sample_id=$(ls *.alleles.tsv | sed 's/.alleles.tsv//' | sed 's/^/-s /')
cstacks -o cstacks_output $sample_id

