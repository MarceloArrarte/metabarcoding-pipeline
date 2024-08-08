#!/bin/bash

# TO-DO ir agregando los comandos para instalar/configurar las dependencias de cada programa

sudo apt install python3

# process QC:
sudo apt install fastp

# process output_documentation:
sudo apt install markdown
pip install markdown-extensions

# process fastqc:
sudo apt install fastqc

# process kmer_freqs:
pip install Bio

# process read_clustering:
pip install umap-learn matplotlib scikit-learn hdbscan

# process split_by_cluster:
sudo apt install seqtk

# process read_correction:
sudo apt install canu

# process draft_selection:
sudo apt install fastani

# process racon_pass:
sudo apt install minimap2 racon

# process medaka_pass:
pip install medaka # TO-DO tenemos que separar la instalación en virtualenvs porque las dependencias
                   #       de medaka son incompatibles con las de otro programa (creo que fastp)