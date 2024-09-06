# all codes that I am writing on qbicluster will be saved here initially

# 7-25-2024, learning slrum:

## checking if SLURM is installed or not:

sinfo --version # 21.08.5 installed

## here, I would like to import my files from HPC_ubuntu cluster, I used to work with:

    source_path= /network-share/Student/mp067823/Carnivore_Metagenomics/thesis_project/donor_id_without_duplicates/fastq_files_without_prinseq/filtered_paired_seqs
    source_id: mp067823@HV-I-HPC-P01-37

    destination_id: podelm@qbicluster
    destination_path = /home/podelm/Carnivore_Metagenomics

    ### transferring using scp:
    scp -r mp067823@HV-I-HPC-P01-37:/network-share/Student/mp067823/Carnivore_Metagenomics/thesis_project/donor_id_without_duplicates/fastq_files_without_prinseq/filtered_paired_seqs /home/podelm/Carnivore_Metagenomics

    scp -r mp067823@10.112.56.95:/network-share/Student/mp067823/Carnivore_Metagenomics/thesis_project/donor_id_without_duplicates/fastq_files_without_prinseq/filtered_paired_seqs /home/podelm/Carnivore_Metagenomics

    ls filtered_paired_seqs/*.fasta
    mkdir fasta_files && mv filtered_paired_seqs/*.fasta fasta_files
    cd fasta_files && ls | wc -l

