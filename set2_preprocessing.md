# at this point, raw data present im set1 and set2 are gone through fastqc and resulting files are unzipped in same directory.

# this file contains all the codes used for quality control before identifying donor FOR SET2:


# Adapter_removal:
cd /network-share/Student/mp067823/Carnivore_Metagenomics/mohit/set2/set2_extracted/
files_set2=$(ls /network-share/Student/mp067823/Carnivore_Metagenomics/mohit/set2/set2_extracted/*_R1_001.fastq.gz)
    # echo $files_set2

for f in $files_set2
do
r1=$f
r2=$(echo $f | sed 's/R1/R2/')
base=$(echo $f | sed 's/.gz//')
AdapterRemoval --file1 $r1 --file2 $r2 --threads 12 --basename $base --gzip
done

cd /network-share/Student/mp067823/Carnivore_Metagenomics/mohit/set2/set2_extracted
ls
mkdir adapterremoved_reads/
    mv *pair?* adapterremoved_reads
    mkdir adapterremoval_extrafiles/
    mv *discarded.gz adapterremoval_extrafiles/
    mv *singleton.truncated.gz adapterremoval_extrafiles/
    mv *settings adapterremoval_extrafiles/

    ls

## checking if adapters are gone using fastqcr:
````
    cd adapterremoved_reads
    mkdir fastqc_out
    for file in ./*.truncated.gz
    do 
        fastqc $file -t 12 -o ./fastqc_out
    done

    R

        .libPaths(c('/network-share/Student/SOFTWARE/R_packages',.libPaths()))
        if(!require(fastqcr)){ install.packages('fastqcr')}
        library(fastqcr)

        setwd('fastqc_out')

        samples = unlist(lapply(list.files(pattern='_fastqc.zip'), function(x) strsplit(x, '_')[[1]][3]))
        x = strsplit(x, '_')
        qc <- qc_aggregate(qc.dir='.', progressbar = TRUE)
    
        summary(qc)
        qc_fails(qc, "module")
        qc_fails(qc, "module")['sample']
        qc_fails(qc, "sample")

        quit('no')

        # here 198/198 has failed in overrepresented sequences module. However, only 2 have failed in adapter content module (312_82_pair1 and 312_82_pair2), so I assume adapter contamination is not a problem for this set and move on.
# Discuss this with Dr. Diego !!!!!        
````

q()
y

###############
moving one failed sample to separate directory:
mkdir Low_Q_reads
mv 312_82_* Low_Q_reads

ls ./*gz | wc -l

# out of initial 198 files, 2 (pair 1 and 2 of same sample) failed fastqcr. So, rest 196 are ready for post-processing.

# Merge paired reads using PEAR:
# here, I would like to merge paired reads using PEAR:

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

# says 99.846 % of reads are assembled.

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

    # just to check if same sample can be on filtered and nopass folder or not:
    ls nopass_paired_seqs | wc -l
    ls nopass_paired_seqs/180_*
    ls filtered_paired_seqs | wc -l
    ls filtered_paired_seqs/180_* 

# from here, I will utilize only the filtered_paired_seqs: