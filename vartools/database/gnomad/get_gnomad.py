# script for getting gnomad data based on a list of Genes

# this script requires gsutil

from urllib.request import urlopen
import requests
import os
import json
import sys

def parse_transcript_list(transcript_list_file):
    """ 
    Takes a file containing a line separated list of ensembl transcripts,
    then returns a data structure containing the
    gene name, chromosome, and locus start and end
    """
    if not os.path.isfile(transcript_list_file):
        print('Invalid File name')
        raise SystemExit
    transcript_list = []
    with open(transcript_list_file, 'r') as f:
        r = f.readlines()
        for row in r:
            transcript_list.append(row.rstrip())
    transcript_dict = {}
    for transcript in transcript_list:
        url = ('https://grch37.rest.ensembl.org/lookup/id/' +
                transcript + '?content-type=application/json')
        print(url)
        response = requests.get(url)
        data = response.json()
        chromosome = data["seq_region_name"]
        locus_intervals = (str(chromosome) + ":" + str(data["start"]) +
                           "-" + str(data["end"]))
        if chromosome not in transcript_dict:
            transcript_dict[chromosome] = []
        transcript_dict[chromosome].append((transcript, locus_intervals))
    return transcript_dict

import progressbar as pb

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
    url = ('https://storage.googleapis.com/gnomad-public/release/' +
           version + '/vcf/' + gmd_subset + '/gnomad.' + gmd_subset +
           '.r' + version + '.sites.' + chrom + '.vcf.bgz')
    print("Downloading data from: ", url)

    writepath = os.path.join(os.getcwd(), 'gnomad_' + version + '_chr' + chrom + '.vcf.bgz')

    response = urlopen(url)
    size = response.info()['Content-Length']
    gigsize = round(int(size)/1000000000,1)
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
            print(str(round(cumCHUNK/1000000000,1)) + '/' + str(gigsize), end='')
            print('\r', end = '')
    print("Download Complete")
    return writepath

import hail as hl

def process_gnomad_data(datapath, chromosome, transcript_list, synonymous = True):
    """
    Uses hail to process the gnomAD dataset 
    """
    hl.init()
    # this try-except block makes sure the program won't spend time 
    # writing the table to disk if it already exists from a previous loop
    try:
        mt = hl.import_vcf(datapath).write('temp_matrix_table_' + chromosome + '.mt',
                                           overwrite = False)
    except:
        #it already exists, so just read it.
        pass
    mt = hl.read_matrix_table('temp_matrix_table_' + chromosome + '.mt')
    #mt = hl.import_vcf(datapath)
    # first filter down to the right number of transcripts
    transcripts, intervals = zip(*transcript_list)
    print(transcripts)
    print(intervals)
    transcripts = hl.literal(list(transcripts))
    print(transcripts)
    mt = hl.filter_intervals(mt, [hl.parse_locus_interval(x,
                             reference_genome = 'GRCh37') for x in intervals]
                            )
    mt.show(5)
    mt = mt.explode_rows(mt.info.vep)
    # get the right tranhi oscript
    mt = mt.annotate_rows(vep = mt.info.vep.split('\|'))
    mt.vep.show(5)
    mt = mt.annotate_rows(enst = mt.vep[6])
    mt.enst.show(5)
    mt = mt.filter_rows(transcripts.contains(mt.enst))
    mt.vep.show(5)
    mt = mt.annotate_rows(vartype = mt.vep[1].split('&'))
    mt.vartype.show(5)
    mt = mt.explode_rows(mt.vartype)
    vartype_list = hl.literal(['frameshift_variant','inframe_deletion',
                               'inframe_insertion','missense_variant',
                               'start_lost','stop_gained'])
    if synonymous:
        vartype_list = vartype_list.extend(['synonymous_variant'])
    mt = mt.filter_rows(vartype_list.contains(mt.vartype))
    mt.show(5)
    mt = mt.annotate_rows(aanum = mt.vep[14])
    mt.show(5)
    mt = mt.annotate_rows(orig_aa = mt.vep[15].split('/')[0])
    mt = mt.annotate_rows(var_aa = mt.vep[15].split('/')[1])
    mt = mt.annotate_rows(cDNA_conseq = mt.vep[10])
    mt = mt.annotate_rows(Protein_conseq = mt.vep[11])
    mt.orig_aa.show(5)
    mt.describe()
    ht = mt.select_rows(mt.info.variant_type, mt.qual, mt.filters,
                        mt.enst, mt.vartype, mt.cDNA_conseq,
                        mt.Protein_conseq, mt.orig_aa, mt.aanum,
                        mt.var_aa, mt.info.AC, mt.info.AN,
                        mt.info.non_neuro_AC, mt.info.non_neuro_AN,
                        mt.info.non_cancer_AC, mt.info.non_cancer_AN,
                        mt.info.non_topmed_AC, mt.info.non_topmed_AN,
                        mt.info.controls_AC, mt.info.controls_AN
                        ).make_table()
    ht.show(5)
    filename = 'gnomad_chr' + chromosome + '_processed.tsv'
    #ht.export(filename)
    os.remove('temp_matrix_table_' + chromosome + '.mt')
    hl.stop()
    return None

def build_gnomAD_FromTranscriptList(transcript_list_file, gmd_version):
    """ builds all gnomAD data from a given gene list file """
    transcript_dict = parse_transcript_list(transcript_list_file)
    print(transcript_dict)
    for chrom, transcript_list in transcript_dict.items():
        for a in [False, True]:
            #datapath = get_gnomad_data(chrom, version = gmd_version, exomes = a)
            datapath = 'gnomad.exomes.r2.1.1.sites.9.vcf.bgz'
            process_gnomad_data(datapath, chrom, transcript_list)
    return None

if __name__ == "__main__":
    gmd_version = '2.1.1'
    transcript_list_file = 'transcript_list.csv'
    build_gnomAD_FromTranscriptList(transcript_list_file, gmd_version)
