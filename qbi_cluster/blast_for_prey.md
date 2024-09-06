# installing blast in qbicluster:
cd /home/podelm
mkdir SOFTWARE
cd /home/podelm/SOFTWARE

wget https://ftp.ncbi.nlm.nih.gov/blast/executables/LATEST/ncbi-blast-2.16.0+-x64-linux.tar.gz
tar zxvpf ncbi-*
ls ncbi-blast*/bin

export PATH=$PATH:~/SOFTWARE/ncbi-blast-2.16.0+/bin
echo $PATH

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

# blast for prey_item:

