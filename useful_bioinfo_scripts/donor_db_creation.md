cd /network-share/Student/mp067823/Carnivore_Metagenomics/thesis_project/donor_identification/donor_db

# downloading 'reference' sequence and creating db:
    # cytb sequence of lynx rufus: ('https://www.ncbi.nlm.nih.gov/nuccore/NC_014456.1?report=fasta&from=15064&to=16203')   

    # 12S sequence of lynx rufus: (https://www.ncbi.nlm.nih.gov/nuccore/NC_014456.1?from=962&to=1921)
    
    # cytb sequence of canis latrans: (https://www.ncbi.nlm.nih.gov/nuccore/NC_008093.1?report=fasta&from=14185&to=15324)

    # 12S sequence of canis latrans: (https://www.ncbi.nlm.nih.gov/nuccore/NC_008093.1?from=70&to=1024&report=fasta)

    ## I downloaded these files manually for database creation.So, I am not using esearch and efetch.
    
    touch reference.fasta
    
    cat canis_latrans_12S.fasta >> reference.fasta
    cat canis_latrans_cytb.fasta >> reference.fasta
    cat lynx_rufus_12S.fasta >> reference.fasta
    cat lynx_rufus_cytb.fasta >> reference.fasta

    grep '>' reference.fasta
    cat reference.fasta | wc -l

    ## reformatting the sequences using seqtk:
    /network-share/Student/SOFTWARE/seqtk/seqtk seq reference.fasta > reference_reformatted.fasta && ls

    cat reference_reformatted.fasta | wc -l

    ## converting into db:    
    makeblastdb -in reference_reformatted.fasta -out donor_DB/donor_DB -parse_seqids -dbtype nucl -title "donor_db"
