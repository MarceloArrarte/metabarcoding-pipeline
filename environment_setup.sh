#!/bin/bash

# TO-DO ir agregando los comandos para instalar/configurar las dependencias de cada programa

setup_log () {
  cyan="\033[1;36m"
  col_reset="\033[0m"
  echo -e "${cyan}#####"
  echo -e "##### INSTALACIÓN: $1"
  echo -e "#####${col_reset}"
}

# Instalamos el intérprete de Python. Queda disponible con el comando python3
setup_log "python"
sudo apt install python3.12 --assume-yes

setup_log "pip"
sudo apt install pip --assume-yes

# Instalamos venv para gestionar virtual environments
setup_log "python3.12-venv"
sudo apt install python3.12-venv --assume-yes
mkdir .virtualenvs
cd .virtualenvs


# process output_documentation:
setup_log "dependencias del proceso output_documentation de NanoCLUST"
sudo apt install markdown --assume-yes
python3 -m venv ./output_documentation
source output_documentation/bin/activate
pip install markdown pymdown-extensions

# process QC:
setup_log "dependencias del proceso QC de NanoCLUST"
sudo apt install fastp --assume-yes

# process fastqc:
setup_log "dependencias del proceso fastqc de NanoCLUST"
sudo apt install fastqc --assume-yes

# process kmer_freqs:
setup_log "dependencias del proceso kmer_freqs de NanoCLUST"
python3 -m venv ./kmer_freqs
source kmer_freqs/bin/activate
pip install Bio

# process read_clustering:
setup_log "dependencias del proceso read_clustering de NanoCLUST"
python3 -m venv ./read_clustering
source read_clustering/bin/activate
pip install umap-learn matplotlib scikit-learn hdbscan pandas

# process split_by_cluster:
setup_log "dependencias del proceso split_by_cluster de NanoCLUST"
sudo apt install seqtk --assume-yes

# process read_correction:
setup_log "dependencias del proceso read_correction de NanoCLUST"
sudo apt install canu --assume-yes

# process draft_selection:
setup_log "dependencias del proceso draft_selection de NanoCLUST"
sudo apt install fastani --assume-yes

# process racon_pass:
setup_log "dependencias del proceso racon_pass de NanoCLUST"
sudo apt install minimap2 racon --assume-yes

# process medaka_pass:
setup_log "dependencias del proceso medaka_pass de NanoCLUST"
setup_log "python3.11 y python3.11-venv"
# Instalamos python3.11 porque la última versión de medaka (2.0.1) requiere python <3.12
sudo add-apt-repository --yes ppa:deadsnakes/ppa
sudo apt update
sudo apt install python3.11
sudo apt install python3.11-venv
sudo apt install python3.11-dev --assume-yes

python3.11 -m venv ./medaka_pass
source medaka_pass/bin/activate
pip install medaka pyabpoa

# process consensus_classification:
setup_log "dependencias del proceso consensus_classification de NanoCLUST"
sudo apt install ncbi-blast+ --assume-yes

# TAMBIÉN: Descargamos una base de datos BLAST para clasificar secuencias consenso
setup_log "Descargando base de datos BLAST para clasificación de secuencias consenso"
cd ../nanoclust
mkdir db db/taxdb
wget https://ftp.ncbi.nlm.nih.gov/blast/db/16S_ribosomal_RNA.tar.gz && tar -xzvf 16S_ribosomal_RNA.tar.gz -C db
wget https://ftp.ncbi.nlm.nih.gov/blast/db/taxdb.tar.gz && tar -xzvf taxdb.tar.gz -C db/taxdb
rm 16S_ribosomal_RNA.tar.gz
rm taxdb.tar.gz
cd ../.virtualenvs

# process join_results:
setup_log "dependencias del proceso join_results de NanoCLUST"
# Nada que instalar, solo es un script bash

# process get_abundances:
setup_log "dependencias del proceso get_abundances de NanoCLUST"
python3 -m venv ./get_abundances
source get_abundances/bin/activate
pip install matplotlib pandas requests

# process plot_abundances:
setup_log "dependencias del proceso plot_abundances de NanoCLUST"
python3 -m venv ./plot_abundances
source plot_abundances/bin/activate
pip install matplotlib pandas numpy
