#!/bin/bash

# TO-DO ir agregando los comandos para instalar/configurar las dependencias de cada programa

# Instalamos el intérprete de Python. Queda disponible con el comando python3
sudo apt install python3.10

# Instalamos venv para gestionar virtual environments
sudo apt install python3.10-venv
mkdir .virtualenvs
cd .virtualenvs

# process QC:
sudo apt install fastp

# process output_documentation:
sudo apt install markdown

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