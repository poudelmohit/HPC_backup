# at this point, raw data present im set1 and set2 are gone through fastqc and resulting files are unzipped in same directory.

# this file contains all the codes used for quality control before identifying donor FOR SET1:


# adapter removal:
cd /network-share/Student/mp067823/Carnivore_Metagenomics/mohit/set1/set1_extracted/
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


ls paired_seqs

cd paired_seqs
    mkdir filtered_paired_seqs
    mkdir nopass_paired_seqs
    files=$(ls | grep '.assembled.fastq')
    for f in $files
    do 
        prefix1=$(echo 'filtered_paired_seqs/')$(echo $f | sed 's/.assembled.fastq//')
        prefix2=$(echo 'nopass_paired_seqs/')$(echo $f | sed 's/.assembled.fastq//')
        /network-share/Student/SOFTWARE/prinseq-lite-0.20.4/prinseq-lite.pl -fastq $f -min_qual_score 20 -derep 23  -out_good $prefix1 -out_bad $prefix2
    done

ls filtered_paired_seqs | wc -l
