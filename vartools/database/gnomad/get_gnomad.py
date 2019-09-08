# script for getting gnomad data based on a list of Genes

# this script requires gsutil

from urllib.request import urlopen
import os

def parse_gene_list(gene_list_file):
    """ 
    Takes a gene list file as an argument
    this should be comma separated, and contain
    3 columns: Chromosome, Gene, RefSeq

    Returns a dictionary, with each chromosome
    as a key, and a list of tuples (Gene, RefSeq)
    """
    if not os.path.isfile(gene_list_file):
        print('Invalid File name')
        raise SystemExit
    gene_list = []
    with open(gene_list_file, 'r') as f:
        r = f.readlines()
        for row in r:
            rowlist = row.rstrip().split(',')
            gene_list.append(rowlist)
    gene_list = gene_list[1:] # remove headers
    # make into a dictionary, with each chrom as the key
    # and a list of tuples (Gene, RefSeq) for each key
    gene_dict = {}
    chrom_list = []
    for row in gene_list:
        chrom_list.append(row[0])
    chrom_set = set(chrom_list)
    for chrom in chrom_set:
        gene_dict[chrom] = []
        for row in gene_list:
            if row[0] == chrom:
                gene_dict[chrom].append((row[1], row[2]))
    print(gene_dict)
    return gene_dict

def get_gnomad_data(chrom, version, exomes = True):
    """
    Gets the necessary gnomAD given a formatted dictionary
    of Genes and Chromosomes

    Returns the donwloaded vcf.bgz file
    """

    if exomes:
        gmd_subset = 'exomes'
    else:
        gmd_subset = 'genomes'
    # fetch the correct vcf file to download for the chromosome
    url = 'https://storage.googleapis.com/gnomad-public/release/' + version + '/vcf/' + gmd_subset + '/gnomad.' + gmd_subset + '.r' + version + '.sites.' + chrom + '.vcf.bgz'
    print(url)

    writepath = os.path.join(os.getcwd(), 'gnomad_' + version + '_chr' + chrom + '.vcf.bgz')

    response = urlopen(url)

    # partition the result into chunks of data,
    # to that the program does not run out of memory
    # some files may be over 30 GigaBytes
    CHUNK = 16 * 1024
    with open(writepath, 'wb') as f:
        cumCHUNK = 0
        while True:
            chunk = response.read(CHUNK)
            cumCHUNK = cumCHUNK + CHUNK
            if not chunk:
                break
            f.write(chunk)
    return writepath

import hail as hl

def process_gnomad_data(datapath, gene_list):
    """
    Uses hail to process the gnomAD dataset 
    """
    hl.init()
    
    hl.stop()
    return None

def build_AllGnomadFromGeneList(gene_list_file, gmd_version):
    """ builds all gnomAD data from a given gene list file """
    gene_dict = parse_gene_list(gene_list_file)
    for chrom, gene_list in gene_dict:
        for a in [False, True]:
            datapath = get_gnomad(chrom, version = gmd_version, exomes = a)
            process_gnomad_data(datapath, gene_list)
    return None

if __name__ == "__main__":
    gmd_version = '2.1.1'
    gene_list_file = 'gene_list.csv'
    gene_dict = parse_gene_list(gene_list_file)
    #writepath = get_gnomad(gene_list, version = gmd_version, exomes = True)
    #process_gnomad(gene_list)
