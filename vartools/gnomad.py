# script for getting gnomad data based on a list of Genes

# this script requires gsutil

from urllib.request import urlopen
from urllib.error import HTTPError
from requests import get as requests_get
from os.path import dirname
from os.path import isfile
from os.path import join as path_join
from os import getcwd
from os import remove as os_remove
from sqlite3 import connect as sqlite3_connect
#import json
from configparser import RawConfigParser
import progressbar as pb

from vartools.database import dbcon

def parse_transcript_list(transcript_list_file):
    """ 
    Takes a file containing a line separated list of ensembl transcripts,
    then returns a data structure containing the
    gene name, chromosome, and locus start and end
    """
    if not isfile(transcript_list_file):
        print('Invalid File name')
        raise SystemExit
    transcript_list = []
    with open(transcript_list_file, 'r') as f:
        r = f.readlines()
        for row in r:
            transcript_list.append(row.rstrip())
    transcript_dict = {}
    for transcript in transcript_list:
        url = ('https://rest.ensembl.org/lookup/id/' +
                transcript + '?content-type=application/json')
        print(url)
        response = requests_get(url)
        data = response.json()
        if "error" in data:
            response = data["error"]
            raise ValueError(response)
        chromosome = data["seq_region_name"]
        locus_intervals = ("chr" + str(chromosome) + ":" + str(data["start"]) +
                           "-" + str(data["end"]))
        if chromosome not in transcript_dict:
            transcript_dict[chromosome] = []
        transcript_dict[chromosome].append((transcript, locus_intervals))
    return transcript_dict

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
    if version == "2.1.1":
        url = ('https://storage.googleapis.com/gnomad-public/release/' +
            version + '/liftover_grch38/vcf/' + gmd_subset + '/gnomad.' + gmd_subset +
            '.r' + version + '.sites.' + chrom + '.liftover_grch38.vcf.bgz')
    if version == "3.0":
        url = ('https://storage.googleapis.com/gnomad-public/release/' +
            version + '/vcf/' + gmd_subset + '/gnomad.' + gmd_subset +
        '.r' + version + '.sites.chr' + chrom + '.vcf.bgz')

    print("Downloading data from: ", url)

    writepath = path_join(getcwd(), 'gnomad_' + version + '_chr' + chrom + '.vcf.bgz')

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

from hail import init as hl_init
from hail import stop as hl_stop
from hail import import_vcf
from hail import literal as hl_literal
from hail import filter_intervals
from hail import parse_locus_interval
from hail import empty_set as hl_empty_set
from hail import null as hl_null
from pandas import concat as pd_concat

def process_gnomad_data(datapath, chromosome, transcript_list, exomes = True, synonymous = True):
    """
    Uses hail to process the gnomAD dataset 
    """

    basedir = dirname(__file__)
    logdir = path_join(basedir, 'hail.log')
    hl_init(log = logdir, append = True, default_reference='GRCh38')
    # this try-except block makes sure the program won't spend time 
    # writing the table to disk if it already exists from a previous loop
    #try:
    #    mt = hl.import_vcf(datapath)
    #except:
    #    #it already exists, so just read it.
    #    pass
    mt = import_vcf(datapath)
    # first filter down to the right number of transcripts
    transcripts, intervals = zip(*transcript_list)
    transcripts = hl_literal(list(transcripts))
    mt = filter_intervals(mt, [parse_locus_interval(x,
                             reference_genome = 'GRCh38') for x in intervals]
                            )
    mt = mt.filter_rows(mt.filters == hl_empty_set('str'))
    mt = mt.explode_rows(mt.info.vep)
    # get the right transcript
    mt = mt.annotate_rows(vep = mt.info.vep.split('\|'))
    #print(mt.vep.take(1))
    mt = mt.annotate_rows(gene = mt.vep[3])
    mt = mt.annotate_rows(enst = mt.vep[6])
    mt = mt.filter_rows(transcripts.contains(mt.enst))
    mt = mt.annotate_rows(vartype = mt.vep[1].split('&'))
    mt = mt.explode_rows(mt.vartype)
    vartype_list = hl_literal(['frameshift_variant','inframe_deletion',
                               'inframe_insertion','missense_variant',
                               'start_lost','stop_gained'])
    if synonymous:
        vartype_list = vartype_list.extend(['synonymous_variant'])
    mt = mt.filter_rows(vartype_list.contains(mt.vartype))
    mt = mt.annotate_rows(codon_num = mt.vep[14])
    mt = mt.annotate_rows(aa_change = mt.vep[15])
    #mt = mt.annotate_rows(orig_aa = mt.vep[15].split('/')[0])
    #mt = mt.annotate_rows(var_aa = mt.vep[15].split('/')[1])
    #mt.filter_rows(mt.vartype == "synonymous_variant").var_aa = None
    mt = mt.annotate_rows(transcript_consequence = mt.vep[10])
    mt = mt.annotate_rows(protein_consequence = mt.vep[11])
    mt = mt.annotate_rows(AC = mt.info.AC[0])
    try:
        mt = mt.annotate_rows(non_neuro_AC = mt.info.non_neuro_AC[0])
        mt = mt.annotate_rows(non_neuro_AN = mt.info.non_neuro_AN[0])
    except:
        mt = mt.annotate_rows(non_neuro_AC = hl_null('int'))
        mt = mt.annotate_rows(non_neuro_AN = hl_null('int'))
    try:
        mt = mt.annotate_rows(non_topmed_AC = mt.info.non_topmed_AC[0])
        mt = mt.annotate_rows(non_topmed_AN = mt.info.non_topmed_AN[0])
    except:
        mt = mt.annotate_rows(non_topmed_AC = hl_null('int'))
        mt = mt.annotate_rows(non_topmed_AN = hl_null('int'))
    try:
        mt = mt.annotate_rows(non_cancer_AC = mt.info.non_cancer_AC[0])
        mt = mt.annotate_rows(non_cancer_AN = mt.info.non_cancer_AN[0])
    except:
        mt = mt.annotate_rows(non_cancer_AC = hl_null('int'))
        mt = mt.annotate_rows(non_cancer_AN = hl_null('int'))
    try:
        mt = mt.annotate_rows(controls_AC = mt.info.controls_AC[0])
        mt = mt.annotate_rows(controls_AN = mt.info.controls_AN[0])
    except:
        mt = mt.annotate_rows(controls_AC = hl_null('int'))
        mt = mt.annotate_rows(controls_AN = hl_null('int'))
    try:
        mt = mt.annotate_rows(pab_max = mt.info.pab_max[0])
    except:
        mt = mt.annotate_rows(pab_max = hl_null('int'))
    try:
        mt = mt.annotate_rows(VQSLOD = mt.info.VQSLOD)
    except:
        mt = mt.annotate_rows(VQSLOD = hl_null('int'))
    try:
        mt = mt.annotate_rows(DP = mt.info.DP)
    except:
        mt = mt.annotate_rows(DP = hl_null('int'))
    try:
        mt = mt.annotate_rows(BaseQRankSum = mt.info.BaseQRankSum)
    except:
        mt = mt.annotate_rows(BaseQRankSum = hl_null('int'))
    try:
        mt = mt.annotate_rows(ClippingRankSum = mt.info.ClippingRankSum)
    except:
        mt = mt.annotate_rows(ClippingRankSum = hl_null('int'))
    try:
        mt = mt.annotate_rows(rf_tp_probability = mt.info.rf_tp_probability)
    except:
        mt = mt.annotate_rows(rf_tp_probability = hl_null('int'))

    ht = mt.select_rows(mt.qual,
                        mt.filters, mt.vartype, mt.gene,
                        mt.transcript_consequence, mt.protein_consequence,
                        mt.codon_num, mt.aa_change,
                        mt.info.FS, mt.info.MQRankSum, mt.info.InbreedingCoeff,
                        mt.info.ReadPosRankSum, mt.VQSLOD, mt.info.QD,
                        mt.DP, mt.BaseQRankSum, mt.info.MQ, mt.ClippingRankSum,
                        mt.rf_tp_probability, mt.pab_max,
                        mt.AC, mt.info.AN,
                        mt.non_neuro_AC, mt.non_neuro_AN,
                        mt.non_cancer_AC, mt.non_cancer_AN,
                        mt.non_topmed_AC, mt.non_topmed_AN,
                        mt.controls_AC, mt.controls_AN
                        ).make_table()

    ht = ht.annotate(chromosome = ht.locus.contig, position = ht.locus.position)
    ht = ht.annotate(allele_ref = ht.alleles[0], allele_alt = ht.alleles[1])
    ht = ht.key_by(ht.chromosome, ht.position, ht.allele_ref, ht.allele_alt)
    ht = ht.drop(ht.alleles, ht.locus)
    df = ht.to_pandas()
    hl_stop()
    cols = df.columns.tolist()
    cols = cols[-4:] + cols[:-4]
    df = df[cols]
    df['filters'] = 'PASS'
    df['ref_aa'], df['alt_aa'] = df['aa_change'].str.split('/',1).str
    df.loc[df.vartype == 'synonymous_variant', 'protein_consequence'] = None
    df['Variant'] = df.apply(lambda row: Variant_name(row), axis=1)
    df = df.drop(['aa_change'], axis = 1)
    cols = df.columns.tolist()
    cols = cols[:11] + cols[-2:] + cols[11:-2]
    df = df[cols]
    if exomes:
        ome = 'exomes'
    else:
        ome = 'genomes'
    df['source'] = ome
    #filename = 'gnomad_' + ome + '_chr' + chromosome + '_processed.tsv'
    #df.to_csv(filename, sep='\t', encoding = 'utf-8', index=False)
    #os.remove('temp_matrix_table_' + chromosome + '.mt')
    return df

def Variant_name(row):
    if row['gene'] == 'GRIN2A':
        prefix = 'h2A-'
    if row['gene'] == 'GRIN2B':
        prefix = 'h2B-'
    if row['gene'] == 'GRIN1':
        prefix = 'h1a-'
    if str(row['alt_aa']) == "nan":
        alt = row['ref_aa']
    else:
        alt = row['alt_aa']
    Variant = prefix + row['ref_aa'] + str(row['codon_num']) + alt
    return Variant

def build_gnomAD_FromTranscriptList(transcript_list_file, gmd_version):
    """ builds all gnomAD data from a given gene list file """
    con = dbcon()
    cur = con.cursor()
    table_name = "gnomADv" + gmd_version
    query = "DROP TABLE IF EXISTS '" + table_name + "'"
    cur.execute(query)
    query = "CREATE TABLE '" + table_name + "' AS SELECT * FROM gnomad WHERE 0=1"
    cur.execute(query)
    con.commit()
    con.close()
    transcript_dict = parse_transcript_list(transcript_list_file)
    print(transcript_dict)
    for chrom, transcript_list in transcript_dict.items():
        try:
            exomes_data = get_gnomad_data(chrom, version = gmd_version,
                                      exomes = True)
            exomes_df = process_gnomad_data(exomes_data, chrom,
                                        transcript_list, exomes = True)
            exomes_df_exists = True
            os_remove(exomes_data)
        except HTTPError as err:
            if err.code == 404:
                print("No exomes data found")
                exomes_df_exists = False
            else:
                raise
        try:
            genomes_data = get_gnomad_data(chrom, version = gmd_version,
                                       exomes = False)
            genomes_df = process_gnomad_data(genomes_data, chrom,
                                         transcript_list, exomes = False)
            genomes_df_exists = True
            os_remove(genomes_data)
        except HTTPError as err:
            if err.code == 404:
                print("No genomes data found")
                genomes_df_exists = False
            else:
                raise
        # combine the gnomad exomes data and the gnomad genomes data into one
        # pandas dataframe, and export it to the database
        if (exomes_df_exists and genomes_df_exists):
            combined_df = pd_concat([exomes_df, genomes_df])
        elif exomes_df_exists:
            combined_df = exomes_df
        elif genomes_df_exists:
            combined_df = genomes_df
        else:
            raise ValueError("Unable to find requested gnomAD data")
        combined_df.loc[combined_df.duplicated(subset=['chromosome','position','allele_ref','allele_alt'],keep=False), 'source'] = 'both'
        combined_df = combined_df.drop_duplicates(['chromosome','position','allele_ref','allele_alt']).reset_index(drop=True)
        combined_df = combined_df.sort_values(by=['position'])
        filename = 'chr' + chrom + '_processed.tsv'
        #combined_df.to_csv(filename, sep='\t', encoding = 'utf-8', index=False)
        con = dbcon()
        combined_df.to_sql(table_name, con = con, if_exists = "append", index = False)
        con.commit()
        con.close()
    return None
