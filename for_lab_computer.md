# Copy files from here (HPC cluster) to lab computer:

    # here is a text file, that contains sample_ID to run in blast for prey identification:

    cat id_classified.txt

  # lets create a folder and save the fasta files of these id:
    mkdir fasta_files_to_blast_for_prey
    ls ../../donor_id_without_duplicates/fastq_files_without_prinseq/filtered_paired_seqs/*.fasta | wc -l
    awk '{print $1}' id_classified.txt | xargs -I {} cp ../../donor_id_without_duplicates/fastq_files_without_prinseq/filtered_paired_seqs/{}.fasta ./fasta_files_to_blast_for_prey

    ls -lh fasta_files_to_blast_for_prey

# NEXT STEP:

    # install blast: 

    mkdir SOFTWARE
    cd /home/mohit/SOFTWARE

    wget https://ftp.ncbi.nlm.nih.gov/blast/executables/LATEST/ncbi-blast-2.16.0+-x64-linux.tar.gz

    tar zxvpf ncbi-*

    ls ncbi-blast*/bin

    export PATH=$PATH:~/SOFTWARE/ncbi-blast-2.16.0+/bin

    echo $PATH/network-share/Student/SOFTWARE/ncbi*/blastdb_new

# installing perl:

    wget https://www.cpan.org/src/5.0/perl-5.22.0.tar.gz

    tar -xvzf perl-5.22.0.tar.gz

    cd perl-5.22.0/
    ./Configure -des -Dprefix=$HOME/localperl

    make

    make install
    perl -v
    man perl

    ~/SOFTWARE/ncbi-blast-2.16.0+/bin/update_blastdb.pl

ssh diego-serrano@127.0.1.1
 
scp /network-share/Student/mp067823/Carnivore_Metagenomics/thesis_project/diagnostic_nucleotide/blast_for_prey/* diego-serrano@127.0.1.1:~/mohit

scp /network-share/Student/SOFTWARE/ncbi*/blastdb_new/* diego-serrano@127.0.1.1:~/mohit/SOFTWARE/blastdb/

LSBL4b@219!


# for blast:
for f in $(ls | grep '.fasta')
    do 
        prefix=$(echo 'blastn_')$(echo $f | sed 's/.fasta//')
        /network-share/Student/software_BIOS5200X/ncbi-blast-2.13.0+/bin/blastn -task megablast\
        -query $f\
        -db /network-share/Student/software_BIOS5200X/ncbi-blast-2.13.0+/blastdb_new/nt\
        -evalue 1e-20\
        -perc_identity 92.0\
        -max_target_seqs 1000\
        -num_threads 5\
        -outfmt "6 qseqid sseqid stitle evalue bitscore length pident qcovs"\
        -out $prefix

        echo "Blast of $f finished"
    done


ls /network-share/Student/SOFTWARE/ncbi*/blastdb_new
clear