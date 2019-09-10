# script for getting gnomad data based on a list of Genes

# this script requires gsutil

from urllib.request import urlopen
import os

def parse_transcript_list(transcript_list_file):
    """ 
    Takes a transcript list file as an argument
    this should be comma separated, and contain
    3 columns: Chromosome, Gene, RefSeq

    Returns a dictionary, with each chromosome
    as a key, and a list of tuples (Gene, RefSeq)
    """
    if not os.path.isfile(transcript_list_file):
        print('Invalid File name')
        raise SystemExit
    transcript_list = []
    with open(transcript_list_file, 'r') as f:
        r = f.readlines()
        for row in r:
            rowlist = row.rstrip().split(',')
            transcript_list.append(rowlist)
    transcript_list = transcript_list[1:] # remove headers
    # make into a dictionary, with each chrom as the key
    # and a list of tuples (Gene, RefSeq) for each key
    gene_dict = {}
    chrom_list = []
    for row in transcript_list:
        chrom_list.append(row[0])
    chrom_set = set(chrom_list)
    for chrom in chrom_set:
        gene_dict[chrom] = []
        for row in transcript_list:
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
    url = 'https://storage.googleapis.com/gnomad-public/release/' + versimo[moon + '/vcf/' + gmd_subset + '/gnomad.' + gmd_subset + '.r' + version + '.sites.' + chrom + '.vcf.bgz'
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

def process_gnomad_data(datapath, locus_intervals, transcript):
    """
    Uses hail to process the gnomAD dataset 
    """
    hl.init()
    # this try-except block makes sure the program won't spend time 
    # writing the table to disk if it already exists from a previous loop
    try:
        mt = hl.import_vcf(datapath).write('gnomad.exomes.r2.1.1.sites.9.mt', overwrite = False)
    except:
        # it already exists, so just read it.
        pass
    mt = hl.read_matrix_table('gnomad.exomes.r2.1.1.sites.9.mt')
    # first filter down to the right number of transcripts
    mt = hl.filter_intervals(mt, [hl.parse_locus_interval(x,
                             reference_genome = 'GRCh37') for x in intervals]
                            )
    mt = mt.explode_rows(mt.info.vep)
    # get the right transcript
    mt = mt.annotate_rows(vep = mt.info.vep.split('\|'))
    mt = annotate_rows(enst = mt.vep[6]
    mt = filter_rows(enst == transcript)
    mt = mt.annotate_rows(vartype = mt.vep[1].split('&')
    mt = mt.explode_rows(mt.vartype)
    vartype_list = hl.literal(['frameshift_variant','inframe_deletion',
                               'inframe_insertion','missense_variant',
                               'start_lost','stop_gained']
    if synonymous:
        vartype_list = vartype_list + 'synonymous_variant'
    mt = mt.filter_rows(vartype_list.contains(mt.vartype)
    mt = mt.annotate_rows(aanum = mt.vep[14])
    mt = mt.annotate_rows(orig_aa = mt.vep[15].split('/')[0])
    mt = mt.annotate_rows(var_aa = mt.vep[15].split('/')[1])
    mt = mt.annotate_rows(cDNA_conseq = mt.vep[10])
    mt = mt.annotate_rows(Protein_conseq = mt.vep[11])
    ht = mt.select_rows(mt.info.variant_type, mt.qual, mt.filters,
                        mt.enst, mt.vartypelist, mt.cDNA_conseq,
                        mt.Protein_conseq, mt.orig_aa, mt.aanum,
                        mt.var_aa, mt.info.AC, mt.info.AN,
                        mt.info.non_neuro_AC, mt.info.non_neuro_AN,
                        mt.info.non_cancer_AC, mt.info.non_cancer_AN,
                        mt.info.non_topmed_AC, mt.info.non_topmed_AN,
                        mt.info.controls_AC, mt.info.controls_AN
                        ).make_table()
    hl.stop()
    return None

def build_AllGnomadFromGeneList(transcript_list_file, gmd_version):
    """ builds all gnomAD data from a given gene list file """
    gene_dict = parse_transcript_list(transcript_list_file)
    for chrom, transcript_list in gene_dict:
        for a in [False, True]:
            datapath = get_gnomad(chrom, version = gmd_version, exomes = a)
            process_gnomad_data(datapath, transcript_list)
    return None

if __name__ == "__main__":
    gmd_version = '2.1.1'
    transcript_list_file = 'transcript_list.csv'
    gene_dict = parse_transcript_list(transcript_list_file)
    #writepath = get_gnomad(transcript_list, version = gmd_version, exomes = True)
    #process_gnomad(transcript_list)
