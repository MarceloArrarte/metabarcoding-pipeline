FROM ubuntu:24.04 AS development

WORKDIR /usr/src

RUN apt-get update && \
    apt install zip unzip curl bash dos2unix software-properties-common --assume-yes

RUN curl -s https://get.sdkman.io | bash

ENV PATH="$HOME/.sdkman/bin:$PATH"

# RUN bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && \
#     sdk install java 17.0.10-tem && \
#     JAVA_HOME=$(sdk home java 17.0.10-tem)"

RUN bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && \
    sdk install java 17.0.10-tem && \
    sdk default java 17.0.10-tem"

RUN bash -c "update-alternatives --install /usr/bin/java java $HOME/.sdkman/candidates/java/17.0.10-tem/bin/java 1"
RUN bash -c "update-alternatives --set java $HOME/.sdkman/candidates/java/17.0.10-tem/bin/java"
RUN bash -c "update-alternatives --install /usr/bin/javac javac $HOME/.sdkman/candidates/java/17.0.10-tem/bin/javac 1"
RUN bash -c "update-alternatives --set javac $HOME/.sdkman/candidates/java/17.0.10-tem/bin/javac"

ENV JAVA_HOME="$HOME/.sdkman/candidates/java/current"
ENV PATH="$JAVA_HOME/bin:$PATH"

# FROM prueba AS development

RUN bash -i -c "cat ~/.bashrc && \
    echo $PATH && \
    echo \"JAVA HOME: $JAVA_HOME\" && \
    java -version"

RUN bash -i -c "curl -s https://get.nextflow.io | bash"

RUN bash -i -c "chmod +x nextflow && \
    mv nextflow /usr/local/bin && \
    nextflow info"

ENV NXF_VER=22.10.8

RUN bash -i -c "nextflow run hello"

# COPY environment_setup.sh ./

# RUN bash -i -c "sed -i 's/\r//' environment_setup.sh && \
#     sed -i 's/^sudo //' environment_setup.sh && \
#     bash environment_setup.sh"

RUN mkdir /usr/src/.virtualenvs

RUN bash -c "apt install \
    python3.12 \
    pip \
    python3.12-venv \
    --assume-yes"

RUN bash -c "mkdir /.virtualenvs"
WORKDIR /usr/src/.virtualenvs

# process output_documentation:
RUN bash -c "apt install markdown --assume-yes && \
    python3 -m venv ./output_documentation && \
    source output_documentation/bin/activate && \
    pip install markdown pymdown-extensions"

# process QC:
RUN apt install fastp --assume-yes

# process fastqc:
RUN apt install fastqc --assume-yes

# process kmer_freqs:
RUN bash -c "python3 -m venv ./kmer_freqs && \
    source kmer_freqs/bin/activate && \
    pip install Bio"

# process read_clustering:
RUN bash -c "python3 -m venv ./read_clustering && \
    source read_clustering/bin/activate && \
    pip install umap-learn matplotlib scikit-learn hdbscan pandas"

# process split_by_cluster:
RUN apt install seqtk --assume-yes

# process read_correction:
RUN apt install canu --assume-yes

# process draft_selection:
RUN apt install fastani --assume-yes

# process racon_pass:
RUN apt install minimap2 racon --assume-yes

# process medaka_pass:
RUN bash -c "add-apt-repository --yes ppa:deadsnakes/ppa && \
    apt update && \
    apt install python3.11 python3.11-venv python3.11-dev --assume-yes && \
    python3.11 -m venv ./medaka_pass && \
    source medaka_pass/bin/activate && \
    pip install medaka pyabpoa"

# process consensus_classification:
RUN apt install ncbi-blast+ --assume-yes
WORKDIR /usr/src
RUN bash -c "mkdir db db/taxdb && \
    apt install wget --assume-yes && \
    wget https://ftp.ncbi.nlm.nih.gov/blast/db/16S_ribosomal_RNA.tar.gz && \
    tar -xzvf 16S_ribosomal_RNA.tar.gz -C db && \
    wget https://ftp.ncbi.nlm.nih.gov/blast/db/taxdb.tar.gz && \
    tar -xzvf taxdb.tar.gz -C db/taxdb && \
    rm 16S_ribosomal_RNA.tar.gz taxdb.tar.gz"

WORKDIR /usr/src/.virtualenvs
# process join_results: Nada que instalar, solo es un script bash

# process get_abundances:
RUN bash -c "python3 -m venv ./get_abundances && \
    source get_abundances/bin/activate && \
    pip install matplotlib pandas requests"

# process plot_abundances:
RUN bash -c "python3 -m venv ./plot_abundances && \
    source plot_abundances/bin/activate && \
    pip install matplotlib pandas numpy"
    
WORKDIR /usr/src


FROM development AS production

COPY ./nanoclust /usr/src/pipeline
WORKDIR /usr/src/pipeline
RUN bash -c "find ./bin -type f -name '*.py' -exec dos2unix {} \; && \
    find ./templates -type f -name '*.py' -exec dos2unix {} \;"

ENTRYPOINT [ "/bin/bash" ]

CMD [ "run_main.sh" ]