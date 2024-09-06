#!/bin/bash

rm -rf consensus_sequences_to_blast
# deletes if directory was created earlier

mkdir -p consensus_sequences_to_blast

awk '/^>/{f=("consensus_sequences_to_blast/" substr($0,2) ".fasta")}{print > f}' overall_fasta_to_blast.fasta
