#!/bin/bash

# TO-DO ir agregando los comandos para instalar/configurar las dependencias de cada programa

# Instalamos el intérprete de Python. Queda disponible con el comando python3
sudo apt install python3.10 --assume-yes

sudo apt install pip --assume-yes

# Instalamos venv para gestionar virtual environments
sudo apt install python3.10-venv --assume-yes
mkdir .virtualenvs
cd .virtualenvs


# process output_documentation:
sudo apt install markdown --assume-yes
python3 -m venv ./output_documentation
source output_documentation/bin/activate
pip install markdown pymdown-extensions

# process QC:
sudo apt install fastp --assume-yes

# process fastqc:
sudo apt install fastqc --assume-yes

# process kmer_freqs:
python3 -m venv ./kmer_freqs
source kmer_freqs/bin/activate
pip install Bio

# process read_clustering:
python3 -m venv ./read_clustering
source read_clustering/bin/activate
pip install umap-learn matplotlib scikit-learn hdbscan pandas

# process split_by_cluster:
sudo apt install seqtk --assume-yes

# process read_correction:
sudo apt install canu --assume-yes

# process draft_selection:
sudo apt install fastani --assume-yes

# process racon_pass:
sudo apt install minimap2 racon --assume-yes

# process medaka_pass:
# sudo apt install medaka_consensus --assume-yes # no lo encuentra este
python3 -m venv ./medaka_pass
source medaka_pass/bin/activate
pip install medaka pyabpoa

# process consensus_classification:
sudo apt install ncbi-blast+ --assume-yes

# TAMBIÉN: Descargamos una base de datos BLAST para clasificar secuencias consenso
mkdir db db/taxdb
wget https://ftp.ncbi.nlm.nih.gov/blast/db/16S_ribosomal_RNA.tar.gz && tar -xzvf 16S_ribosomal_RNA.tar.gz -C db
wget https://ftp.ncbi.nlm.nih.gov/blast/db/taxdb.tar.gz && tar -xzvf taxdb.tar.gz -C db/taxdb

# process join_results:
# Nada que instalar, solo es un script bash
# terminó de consumir los 25GB de disco
# process get_abundances:
python3 -m venv ./get_abundances
source get_abundances/bin/activate
pip install matplotlib pandas requests

# process plot_abundances:
python3 -m venv ./plot_abundances
source plot_abundances/bin/activate
pip install matplotlib pandas numpy