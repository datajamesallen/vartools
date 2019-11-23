import urllib.request
import xml.etree.ElementTree as ET
from json import dumps as json_dumps
#import xml
from time import sleep
from time import time
from vartools import varfx
from vartools import xmlfx
from sys import exit as sys_exit
from sqlite3 import connect as sqlite3_connect
from copy import deepcopy
from logging import basicConfig
from logging import getLogger
from logging import INFO
from socket import timeout
import progressbar as pb
from os.path import join as path_join
from os.path import dirname
from configparser import RawConfigParser

def init_logger():
    basedir = dirname(__file__)
    logdir = path_join(basedir, 'clinvar.log')
    print('writing log file to ' + logdir)
    basicConfig(format='%(asctime)s,%(levelno)s,%(lineno)s,%(message)s', datefmt='%m%d%Y %I:%M%S %p', filename=logdir, level = INFO)
    logger = getLogger()
    logger.info('Initializing')
    return logger

# functions #

def geturlbar(genelist):
    ''' for constructing the url bar, supply a list of genes '''
    base = 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/'
    # you need to regester an account with NCBI in order to generate an API key
    # I am not sure how long these last, but this one has been working for a while.
    # If this script breaks in the future look into this - James
    apikey = '5b609e53520d9529fe22a5162b07bbeb3608'
    # constructing the genelist from farfunctions.py
    # (edit that file if you want to add genes)
    query = '&term='
    for key in genelist:
        query += key + '[gene]%20OR%20'
        if genelist[-1] == key:
            query += '&RetMax=100000&api_key=' + apikey
    url = base + 'esearch' + '.fcgi?db=' + 'clinvar' + query
    return(url)

# the ncbi api returns the data as xml, this parses the xml
# using the xml.etree.ElementTree library

def xml2dict(xml):
    '''
    the ncbi api returns the data as xml, this parses the xmlfx.py
    (should be included in this directory)
    '''
    tree = ET.parse(xml)
    root = tree.getroot()
    newdict = xmlfx.XmlDictConfig(root)
    return(newdict)

def rmcom(stringi):
    if stringi is not None:
        new = stringi.replace(',',';')
    else:
        new = None
    return(new)

def nestedd(data, l):
    temp = deepcopy(data)
    try:
        for k in l: temp = temp[k]
        return(temp)
    except:
        return(None)

def jprint(parsed):
    print(json_dumps(parsed, indent=2, sort_keys=True))
    return(None)

def xl(l):
    newlist = []
    if l is None:
        return('NULL')
    for s in l:
        if s is None:
            newlist.append('NULL')
        else:
            newlist.append(s)
    return(newlist)

#-----------------------------------------------------------------------------------------
def getscv(var, VariationID):
    """ Get the SCV data from the ClinVar API """

    # check to see if there is any data in here, if not return a None row.
    try:
        germlist = var['VariationReport']['ClinicalAssertionList']['GermlineList']
    except:
        return([[None] * 9])
    if not germlist:
        assres = [None] * 9
    if not germlist['Germline']:
        assres = [None] * 9
    def collect(assr):
        orgname = assr.get('SubmitterName')
        orgid = assr.get('OrgID')
        orgcat = assr.get('OrganizationCategory')
        scv = assr.get('Accession')
        origin = nestedd(assr, ['AlleleOriginList', 'AlleleOrigin', 'Origin'])
        method = nestedd(assr, ['AlleleOriginList', 'AlleleOrigin', 'MethodType'])
        criteria = assr.get('ReviewStatus')
        signifshort = nestedd(assr, ['ClinicalSignificance','Description'])
        rowlist = [VariationID, scv, rmcom(signifshort), rmcom(criteria),
                    origin, method, rmcom(orgname), orgcat, orgid]
        for item in getscvphen(assr, scv, VariationID):
            dbupload(item, "clinvar_scv_phen", hclinvar_scv_phen)
        return(rowlist)
    try:
        germlist['Germline'][0]
        assres = []
        for assr in germlist['Germline']:   
            assres.append(collect(assr))
    except:
        assr = germlist['Germline']
        assres = [collect(assr)]
    return(assres)

def getscvphen(supp, scv, VariationID):
    try:
        phenlist = supp['PhenotypeList']
    except:
        phenres = [None] * 6
        return(phenres)
    if not phenlist:
        phenres = [None] * 6
    if not phenlist['Phenotype']:
        phenres = [None] * 6
    def collect(phen):
        phenname = rmcom(phen.get('Name'))
        phenid = phen.get('target_id')
        xrefid = nestedd(phen, ['XRefList', 'XRef', 'ID'])
        xrefdb = nestedd(phen, ['XRefList', 'XRef', 'DB'])
        phenres = [VariationID, scv, rmcom(phenname), phenid, xrefdb, xrefid]
        return(phenres)
    try:
        phenlist['Phenotype'][0]
        phenres = []
        for phen in phenlist['Phenotype']:
            phenres.append(collect(phen))
    except:
        phen = phenlist['Phenotype']
        phenres = [collect(phen)]
    return(phenres)

def getobs(var, VariationID):
    """ Parse the SupportingObservations data found from the ClinVar API """
    supplist = var['VariationReport']['SupportingObservations']
    if not supplist:
        suppres = [None] * 4
    if not supplist['Observation']:
        suppres = [None] * 4
    def collect(supp):
        global personid
        pid = personid
        origin = supp.get('AlleleOrigin')
        testingmethod = nestedd(supp, ['Method', 'MethodName'])
        orgid =  supp.get('OrgID')
        orgname = supp.get('SubmitterName')
        suppres = [VariationID, str(pid), origin, testingmethod, rmcom(orgname), orgid]
        for item in getobsphen(supp, pid, VariationID):
            dbupload(item, "clinvar_obs_phen", hclinvar_obs_phen)
        personid += 1
        return(suppres)
    try:
        supplist['Observation'][0]
        suppres = []
        for supp in supplist['Observation']:
            suppres.append(collect(supp))
    except:
        supp = supplist['Observation']
        suppres = [collect(supp)]
    return(suppres)

def getobsphen(supp, pid, VariationID):
    try:
        phenlist = supp['ObservedPhenotypes']
    except:
        phenres = [None] * 6
        return(phenres)
    if not phenlist:
        phenres = [None] * 4
    if not phenlist['Phenotype']:
        phenres = [None] * 4
    def collect(phen, pid):
        phenname = phen.get('Name')
        phenid = phen.get('target_id')
        fx = phen.get('AffectedStatus')
        xrefid = nestedd(phen, ['XRefList', 'XRef', 'ID'])
        xrefdb = nestedd(phen, ['XRefList', 'XRef', 'DB'])
        phenres = [VariationID, str(pid), fx, rmcom(phenname), phenid, xrefdb, xrefid]
        return(phenres)
    try:
        phenlist['Phenotype'][0]
        phenres = []
        for phen in phenlist['Phenotype']: 
            phenres.append(collect(phen, pid))
    except:
        phen = phenlist['Phenotype']
        phenres = [collect(phen, pid)]
    return(phenres)

def tryconn(url):
    try:
        result = urllib.request.urlopen(url, timeout = 10)
    except timeout:
        logger.error("SOCKET TIME OUT: slow connection retrying")
        return(tryconn(url))
    return(result)

from progressbar import ProgressBar
from progressbar import Percentage
from progressbar import Bar
from progressbar import RotatingMarker
from progressbar import ETA

def queryvar(genelist, logger):
    base = 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/'
    apikey = '5b609e53520d9529fe22a5162b07bbeb3608'
    url = geturlbar(genelist)
    try:
        result = urllib.request.urlopen(url, timeout = 30)
    except timeout:
        logger.error("SOCKET TIME OUT: took longer than 30 seconds to make Gene List query")
        print("took longer than 30 seconds to make initial query")
        sys_exit()
    print("Gene List Query complete. Initiating Variation Report Queries")
    iddict = xml2dict(result)
    idlist = list(map(str, iddict['IdList']['Id']))
    # length of ids list that can now determine how many iterations the loop will occur
    idslen = len(list(idlist))
    widgets = ['Querying Variant Information: ', Percentage(), ' ', Bar(marker=RotatingMarker()), ' ', ETA()]
    timer = ProgressBar(widgets=widgets, maxval = idslen).start()
    global personid
    personid = 1 # this is a unique id that is generated every time this clinvar query is run
    limit = 600
    starttime = time()
    for index, id in enumerate(idlist):
        timer.update(index)
        # limit the number of requests to 10 per second
        if not index + 1 % limit:
            sleeptime = starttime + 60 - time()
            if sleeptime > 0:
                sleep(sleeptime)
            starttime = time()
        query = '&id=' + id + '&rettype=variation&retmax=10000&api_key=' + apikey
        url = base + 'efetch' + '.fcgi?db=' + 'clinvar' + query
        result = tryconn(url) 
        var = xml2dict(result)
        #-----------------------------------------------
        # now check if this variant is worth keeping
        # check that this is the only affected gene.
        # otherwise the variant is too complicated for functional interpretation
        varname = var['VariationReport']['Allele']['Name']
        GeneCount = var['VariationReport']['GeneList']['GeneCount']
        if GeneCount == '1':
            Gene = var['VariationReport']['GeneList']['Gene']['Symbol']
        else:
            logger.info('Multiple Genes in Variation Report. Ignoring variant: %s', varname)
            continue
        # VariationID binds this whole thing together
        # is an important key in my database as well for handling clinvar data

        VariationID = var['VariationReport']['VariationID']
        #------------------------------------------------
        # converting the HGVS notation into separate variables
        # FULL HGVS ex: "NM_000834.4(GRIN2B):c.1547A>G (p.Asn516Ser)"
        # examples will be shown in comments to the right
        first_open_par = varname.find('(') # find index of first (
        second_open_par = varname.rfind('(') # find index of second (
        first_close_par = varname.find(')') # find index of first )
        second_close_par = varname.rfind(')') # find index of second )
        RefSeq = varname[:first_open_par] # "NM_000834.3"
        Protein = varname[second_open_par+1:second_close_par] # "p.Asn516Ser"
        cDNA = varname[first_close_par+2:second_open_par] # "c.1547A>G"
        VariantType = var['VariationReport']['Allele']['VariantType']
        DateCreated = var['VariationReport']['DateCreated']
        try:
            Variant = varfx.getVariant(Protein, Gene)
            aaNum = varfx.getaaNum(Protein)
        except:
            logger.info('Protein consequence not found. Ignoring variant: %s', varname)
            continue

        # functions that collect the data from the json file

        # First and foremost, create the clinvar_variant table
        VariationReport = [Gene, aaNum, cDNA, Protein, Variant, RefSeq,
                        VariationID, VariantType, DateCreated]
        con = dbcon()
        cursor = con.cursor()
        query = "SELECT Variant from clinvar_variant WHERE clinvar_VariationID = ?"
        cursor.execute(query, (VariationID,))
        result = cursor.fetchone()
        con.close()
        if result:
            logger.info("Already found, updating current info on variant: %s", varname)
            con = dbcon()
            cursor = con.cursor()
            # update the newest info fresh by delete all of the old info
            query = "DELETE from clinvar_obs WHERE clinvar_VariationID = ?"
            cursor.execute(query, (VariationID,))
            query = "DELETE from clinvar_obs_phen WHERE clinvar_VariationID = ?"
            cursor.execute(query, (VariationID,))
            query = "DELETE from clinvar_scv WHERE clinvar_VariationID = ?"
            cursor.execute(query, (VariationID,))
            query = "DELETE from clinvar_scv_phen WHERE clinvar_VariationID = ?"
            cursor.execute(query, (VariationID,))
            con.commit()
            con.close()
        else:
            print("New variant: " + varname)
            logger.info("New variant: %s", varname)
        dbupload(VariationReport, "clinvar_variant", hclinvar_variant)
        # Second, we group all the associated data by scv
        # This includes all data on phenotypes that go with that scv as well
        scv = getscv(var, VariationID)
        for item in scv:
            if item == [None] * 9:
                continue
            else:
                dbupload(item, "clinvar_scv", hclinvar_scv)
        # Third, we group everything by individual observations
        # this is normally individual people
        # a little more broken apart
        obs = getobs(var, VariationID)
        for item in obs:
            if item == [None] * 4:
                continue
            else:
                dbupload(item, "clinvar_obs", hclinvar_obs)
    timer.finish()
    return(None)

def dbcon():
    """ opens sqlite database connection from config """
    parser = RawConfigParser()
    basedir = dirname(__file__)
    configdir = path_join(basedir, 'config.ini')
    parser.read(configdir)
    dbpath = parser.get('database','path')
    con = sqlite3_connect(dbpath)
    return(con)

def dbupload(data, table, header):
    """ upload clinvar data to the database """
    con = dbcon()
    cursor = con.cursor()
    varquest = ("?," * (len(header) - 1)) + '?'
    headerlist = ",".join(header)
    query = "REPLACE INTO " + table + " (" + headerlist + ") VALUES (" + varquest + ")"
    cursor.execute(query, data)
    con.commit()
    con.close()
    return(None)


hclinvar_variant = ['Gene','aaNum','cDNA','Protein','Variant','RefSeq', 
            'clinvar_VariationID','clinvar_VariationType','clinvar_DateCreated']
hclinvar_scv = ['clinvar_VariationID','clinvar_scvID','clinvar_Conclusion',
            'clinvar_Criteria','clinvar_AlleleSource','clinvar_TestingMethod',
            'clinvar_OrgName','clinvar_OrgType','clinvar_OrgID']
hclinvar_scv_phen = ['clinvar_VariationID','clinvar_scvID','clinvar_Phenotype',
            'clinvar_PhenotypeID','clinvar_phenXRefDB','clinvar_phenXRefID']
hclinvar_obs = ['clinvar_VariationID','clinvar_ObsID','clinvar_AlleleSource',
            'clinvar_TestingMethod','clinvar_OrgName', 'clinvar_OrgID']
hclinvar_obs_phen = ['clinvar_VariationID','clinvar_ObsID','clinvar_AffectedStatus',
            'clinvar_Phenotype','clinvar_PhenotypeID','clinvar_phenXRefDB','clinvar_phenXRefID']

def clinvar_script():

    print("=====================================================")
    print("|  Clinvar Data Miner for Nonsynonymous Variants    |")
    print("|       Created by James Allen 2019 CFERV           |")
    print("-----------------------------------------------------")
    logger = init_logger()
    print("Currently selected Gene list:")
    genelist = []
    for key in varfx.genedict:
        genelist.append(key)
    counter = 0
    for item in genelist:
        if ((counter % 5) == 0 and counter != 0):
            print("")
        print(item + ", ", end = "")
        counter += 1
    print("\n-----------------------------------------------------")
    sleep(1)
    print("Initializing Gene List Query")
    queryvar(genelist, logger)
    logger.info("STATUS: COMPLETE")
    print("Program completed, all variants are now updated in the database")
    return(None)

if __name__ == "__main__":
    clinvar_script()



