#!/bin/bash

# TO-DO ir agregando los comandos para instalar/configurar las dependencias de cada programa

# Instalamos el intérprete de Python. Queda disponible con el comando python3
sudo apt install python3.10

# Instalamos venv para gestionar virtual environments
sudo apt install python3.10-venv
mkdir .virtualenvs
cd .virtualenvs


# process output_documentation:
sudo apt install markdown

# process QC:
sudo apt install fastp

# process fastqc:
sudo apt install fastqc

# process kmer_freqs:
python3 -m venv ./kmer_freqs
source kmer_freqs/bin/activate
pip install Bio

# process read_clustering:
python3 -m venv ./read_clustering
source read_clustering/bin/activate
pip install umap-learn matplotlib scikit-learn hdbscan pandas

# process split_by_cluster:
sudo apt install seqtk

# process read_correction:
sudo apt install canu

# process draft_selection:
sudo apt install fastani

# process racon_pass:
sudo apt install minimap2 racon

# process medaka_pass:
sudo apt install medaka_consensus
python3 -m venv ./medaka_pass
source medaka_pass/bin/activate
pip install medaka pyabpoa

# process consensus_classification:
sudo apt install ncbi-blast+

# TAMBIÉN: Descargamos una base de datos BLAST para clasificar secuencias consenso
mkdir db db/taxdb
wget https://ftp.ncbi.nlm.nih.gov/blast/db/16S_ribosomal_RNA.tar.gz && tar -xzvf 16S_ribosomal_RNA.tar.gz -C db
wget https://ftp.ncbi.nlm.nih.gov/blast/db/taxdb.tar.gz && tar -xzvf taxdb.tar.gz -C db/taxdb

# process join_results:
# Nada que instalar, solo es un script bash

# process get_abundances:
python3 -m venv ./get_abundances
source get_abundances/bin/activate
pip install matplotlib pandas requests

# process plot_abundances:
# Nada que instalar, usa matplotlib y pandas pero ya está instalado en el environment del paso previo