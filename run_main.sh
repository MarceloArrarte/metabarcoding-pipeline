# nextflow run main_16S.nf -profile docker --reads 'reads_datasets/barcode01/FAO03535_pass_barcode01_549cf624_0.fastq' --db 'db/16S_ribosomal_RNA' --tax 'db/taxdb/'
nextflow run main.nf --reads 'reads_datasets/*' --db './db/16S_ribosomal_RNA' --tax './db/taxdb/'
# cd debug \
#     && pwd \
#     && java -version \
#     && nextflow info \
#     && nextflow run debug.nf