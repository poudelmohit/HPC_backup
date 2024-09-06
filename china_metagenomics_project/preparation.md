cd /network-share/Student/mp067823/extra/china_metagenomics_project

# defining a variable for current project directory:
nano ~/.bashrc
## added the current directory path to variable: metagenomic_proj_dir

source ~/.bashrc

ls $metagenomics_proj_dir


# downloading raw DATA:

mkdir SOFTWARE

## downloading fastq-dump (tool to download multiple FASTQ files easily)

wget --output-document ./SOFTWARE/sratoolkit.tar.gz https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/current/sratoolkit.current-ubuntu64.tar.gz

cd SOFTWARE && ls

tar -vxf sratoolkit.tar.gz
ls 
export PATH=$PATH:$metagenomics_proj_dir/SOFTWARE/sratoolkit.3.1.1-ubuntu64/bin
echo $PATH

fastq-dump --version  # checking version.

## installing conda:

wget 'https://repo.anaconda.com/archive/Anaconda3-2024.06-1-Linux-x86_64.sh'

sha256sum Anaconda3-*
bash Anaconda3-*.sh # press enter and yes whenver asked, and for "Do you wish to update your shell profile.." say No
export PATH=$PATH:/home/mp067823/anaconda3/bin

cd ..

# creating a conda env for all R and python packages:
conda env list
conda create -n metagenome -y
conda init
conda activate metagenome
conda deactivate

clear


# downloaded Accession list of the 90 samples:
mkdir raw_data
cat SRR_Acc_List.txt | xargs fastq-dump --outdir raw_data

# we can see 90 fastq files in the raw_data directory:

# running FASTQC to check the quality of these files:

 mkdir -p data_preprocessing/fastqc_out # creating new directory to store fastqc results

    for file in raw_data/*.fastq;
	    do fastqc $file -t 12 -o data_preprocessing/fastqc_out
    done
    ls -lh data_preprocessing/fastqc_out

## summarizing the fastqc output using R:

cd data_preprocessing/fastqc_out


R
    .libPaths(c('/network-share/Student/SOFTWARE/R_packages',.libPaths()))
    install.packages('curl')
        if(!require(fastqcr)){ install.packages('fastqcr')}
        library(fastqcr)

        samples = unlist(lapply(list.files(pattern='_fastqc.zip'), function(x) strsplit(x, '_')[1]))
        x = strsplit(x, '_')
        setwd("data_preprocessing/fastqc_out")

        qc <- qc_aggregate(qc.dir='.', progressbar = TRUE)
    
        summary(qc)
        qc_fails(qc, "module")
        qc_fails(qc, "sample")

        quit('no')

# looking at the result of FASTQC, it seems like there is no adapter contamination. So, it should be fine




# Adapter removal:
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


