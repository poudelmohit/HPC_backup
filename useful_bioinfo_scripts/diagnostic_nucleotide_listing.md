#!/bin/bash

## first, for 12S sequences:

# Temporary files:
temp_file1=$(mktemp)
temp_file2=$(mktemp)




# Process lines starting with '>' and extract fields
awk '/^>/ {print $0}' aligned_12S_reformatted.fasta | awk -F'_' '{print $2}' > "$temp_file1"

# Process lines where NR % 2 != 1 and extract specific characters
positions="1477 1480 1481 1482 1485 1493 1494 1497 1506 1518 1552 1606 1608 1609 1622 1651 1660 1662 1663 1675 1676 1679 1686 1711 1718 1726 1775 1747 1749 1756 1757 1758 1765 1766 1768 1769 1778 1783 1785 1787 1808 1811 1825 1834"

awk -v positions="$positions" '
BEGIN {
    split(positions, pos_array, " ")
}
NR % 2 == 0 {
    for (i in pos_array) {
        printf "%s ", substr($0, pos_array[i], 1)
    }
    printf "\n"
}
' aligned_12S_reformatted.fasta > "$temp_file2"

# Combine results and save to a new file
paste -d ' ' "$temp_file1" "$temp_file2" > output_file.txt

# Clean up temporary files
rm "$temp_file1" "$temp_file2"
grep -v '^[0-9]' output_file.txt | sort | uniq 

sed -i "1s/^/Name $positions\n/" output_file.txt

grep -v '^[0-9]' output_file.txt | sort -r | uniq > 12S_diagnostic_positions.txt
rm -r output_file.txt
clear

cat 12S_diagnostic_positions.txt


# Secondly, for Cytb sequences:

# Temporary files:
temp_file1=$(mktemp)
temp_file2=$(mktemp)

cat aligned_12S_reformatted.fasta

# Process lines starting with '>' and extract fields
awk '/^>/ {print $0}' aligned_12S_reformatted.fasta | awk -F'_' '{print $2}' > "$temp_file1"

# Process lines where NR % 2 != 1 and extract specific characters
positions="1477 1480 1481 1482 1485 1493 1494 1497 1506 1518 1552 1606 1608 1609 1622 1651 1660 1662 1663 1675 1676 1679 1686 1711 1718 1726 1775 1747 1749 1756 1757 1758 1765 1766 1768 1769 1778 1783 1785 1787 1808 1811 1825 1834"

awk -v positions="$positions" '
BEGIN {
    split(positions, pos_array, " ")
}
NR % 2 == 0 {
    for (i in pos_array) {
        printf "%s ", substr($0, pos_array[i], 1)
    }
    printf "\n"
}
' aligned_12S_reformatted.fasta > "$temp_file2"

# Combine results and save to a new file
paste -d ' ' "$temp_file1" "$temp_file2" > output_file.txt

# Clean up temporary files
rm "$temp_file1" "$temp_file2"
grep -v '^[0-9]' output_file.txt | sort | uniq 

sed -i "1s/^/Name $positions\n/" output_file.txt

grep -v '^[0-9]' output_file.txt | sort -r | uniq > 12S_diagnostic_positions.txt
rm -r output_file.txt
clear

cat 12S_diagnostic_positions.txt







# next steps:
ls
## create a script that aligns all reads of a sample against the reference sequence and obtains the base present in predefined positions:

mkdir sample_sequences
cp ../donor_id_without_duplicates/fastq_files_without_prinseq/filtered_paired_seqs/6??_*_???.fasta ./sample_sequences

cd sample_sequences

to align each of those reads, I need a ref sequence with known positions of diagnostic nucleotides:
for this, I am using a seq from JALVIEW itself, which is saved as ../12S_ref.fasta

/network-share/Student/SOFTWARE/seqtk/seqtk seq ../12S_ref.fasta > 12S_ref.fasta

# aligninning all reads(fragments) against the ref file:
cat 602_66_S66.fasta 12S_ref.fasta > 602_66_S66_align.fasta
cat 602_66_S66_align.fasta

clustal*/clustalw2 -INFILE=602_66_S66_align.fasta -OUTFILE=sample.fasta -output=Fasta
cat sample.fasta

ls