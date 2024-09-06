#!/bin/bash

rm -rf consensus_sequences_to_blast
mkdir -p consensus_sequences_to_blasts

awk '/^>/{f=("consensus_sequences_to_blast/" substr($0,2) ".fasta")}{print > f}' overall_fasta_to_blast.fasta
ls consensus_seq*