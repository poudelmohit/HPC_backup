#!/bin/bash

files=$(ls | grep '.fasta')
    for f in $files;do
        prefix=$(echo ">")$((basename "$f") | sed "s/.fasta//")$(echo "|")
        sed -i "s/>/$prefix/" $f
        sed -i "s/ /_/g" $f
    done
