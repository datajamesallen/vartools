"""
A library for working with genetic data on human variants

author: James Allen
developed for SFTlab and CFERV
"""

import re

# for abbreviating amino acid names
aadict = {'Ala': 'A', 'Cys': 'C', 'Asp':'D', 'Glu':'E','Phe':'F','Gly':'G',
'His':'H','Ile':'I','Lys':'K','Leu':'L','Met':'M','Asn':'N','Pro':'P',
'Gln':'Q','Arg':'R','Ser':'S','Thr':'T','Val':'V','Trp':'W','Tyr':'Y',
'Ter':'X','del':'del','ins':'ins','dup':'dup','Del':'del','Dup':'dup','*':'X'}

# for abbreviating gene names
genedict = {'GRIN1':'h1a','GRIN2A':'h2A','GRIN2B':'h2B','GRIN2C':'h2C',
'GRIN2D':'h2D','GRIA1':'hA1','GRIA2':'hA2','GRIA3':'hA3','GRIA4':'hA4',
'GRIK1':'hK1','GRIK2':'hK2','GRIK3':'hK3','GRIK4':'hK4','GRIK5':'hK5',
'GRINA':'hA','GRIN3A':'h3A','GRIN3B':'h3B','GRID1':'hD1','GRID2':'hD2',
'DLG4':'hdlg4'}

# for finding the 'cannonical' nm RefSeq for each each gene
nmdict = {'GRIN1':'NM_007327.3','GRIN2A':'NM_000833.4','GRIN2B':'NM_000834.3',
'GRIN2C':'NM_000835.4','GRIN2D':'NM_000836.2','GRIN3A':'NM_133445.2',
'GRIN3B':'NM_138690.2','GRIA1':'NM_000827.3','GRIA2':'NM_00826.3',
'GRIA3':'NM_007325.4', 'GRIA4':'NM_000820.3','GRIK1':'NM_000820.3',
'GRIK2':'NM_021956.4','GRIK3':'NM_000831.3','GRIK4':'NM_014619.4',
'GRIK5':'NM_002088.4','GRID1':'NM_017551.2','GRID2':'NM_001510.3',
'DLG4':'NM_001365.4'}

# for finding the 'cannonical' gnomad ENST for each gene
enstdict = {'GRIN1':'ENST00000371553.7','GRIN2A':'ENST00000396573.6',
'GRIN2B':'ENST00000609686.3','GRIN2C':'ENST00000293190.9',
'GRIN2D':'ENST00000263269.3','GRIN3A':'ENST00000361820.3',
'GRIN3B':'ENST00000234389.3','GRIA1':'ENST00000518783.1',
'GRIA2':'ENST00000296526.11','GRIA3':'ENST00000264357.5',
'GRIA4':'ENST00000282499.9','GRIK1':'ENST00000399907.5',
'GRIK2':'ENST00000421544.6','GRIK3':'ENST00000373091.7',
'GRIK4':'ENST00000527524.7','GRIK5':'ENST00000262895.7',
'GRID1':'ENST00000327946.11','GRID2':'ENST00000282020.8',
'GRINA':'ENST00000313269.5'}

def getnm(gene):
    try:
        nm = nmdict[gene]
    except:
        quit('invalid gene: ' + gene)
    return(nm)

def getenst(gene):
    try:
        enst = enstdict[gene]
    except:
        quit('invalid gene: ' + gene)
    return(enst)

def abrev_aa(aa):
    """
    abreviates a three-letter amino acid

    converts from Thr -> T, Ser -> S, Gln -> Q etc.
    """
    try:
        abrev = aadict[aa]
    except:
        quit('invalid AA: ' + aa)
    return(abrev)

def abrev_gene(gene):
    """
    abreviates the gene name

    converts from GRIN2A -> h2A, GRIN2B -> h2B, GRIK5 -> hK5
    """
    try:
        subunit = genedict[gene]
    except:
        quit('invalid gene:' + gene)
    return(subunit)

def getVariant(protein, gene):
    """
    get the 'variant' name from a protein consequence and gene
    
    ex: getvariant('p.Thr141Met', 'GRIN2A')
    # ----> h2A-T141M
    """
    # looks for any 3 letters with the first capitalized
    pattern = re.compile(r'[a-z|A-Z][a-z][a-z]')
    # example: p.Thr141Met - > ['p.','141','']
    splitname = pattern.split(protein)
    # example: p.Thr141Met - > ['Thr','Met']
    aas = pattern.findall(protein)
    mgene = abrev_gene(gene)
    aa1 = abrev_aa(aas[0])
    aaNum = splitname[1]
    aa2 = abrev_aa(aas[1])
    # the 'post' string
    # this area is a little nebulous,
    # but basically most variants won't have a post string
    # attempts to propery format some of the weirder variants
    # like p.Thr141_P150Dup etc.
    post = splitname[2]
    # most of the normal ones will only get split 3 ways (two amino acids)
    if len(splitname) == 4:
        post = splitname[2] + abrev_aa(aas[2])
    # now we try and handle any frameshifts
    # looks for 'fsTer' followed by any integer
    fspattern = re.compile(r'fsTer[1-9][0-9]*$') 
    fs = fspattern.findall(protein)
    if fs:
        fs = fs[0]
        aa2 = ''
        post = re.sub('Ter', 'X', fs)
    variant = mgene + '-' + aa1 + aaNum + aa2 + post
    return(variant)

def findVariant(string):
    """

    """
    start = re.compile(r'h[1-2][A-Da]-[ACEFGHIKLMNPQRSTVWY]^[1-9]+[0-9]*$[ACEFGHIKLMNPQRSTVWY]')
    str1 = start.findall(string)[0]
    variant = str1
    return(variant)

def getaaNum(protein):
    """
    get the amino acid number from a given protein

    ex: p.Thr141Met -> 141
    """
    pattern = re.compile(r'[1-9][0-9][0-9][0-9]|[1-9][0-9][0-9]|[1-9][0-9]|[1-9]')
    result = pattern.findall(protein)
    result = result[0]
    return(result)

def getaaNumVar(Variant):
    """
    does the same as getaaNum, but for 'Variant' names

    ex: h2A-T141K -> 141

    *** if you used getaaNum('h2A-T141K'), you would get 2 because of the 2 in h2A instead of the true value 141
    """
    i = Variant.find('-')
    var = Variant[i:]
    return(getaaNum(var))

def getVariant2(protein, gene):
    """
    get the 'variant' name from a protein consequence and gene
    
    ex: getvariant('p.Thr141Met', 'GRIN2A')
    # ----> h2A-T141M
    """
    startlost = re.compile('?')
    sl = startlost.findall(protein)
    print(sl)
    pattern = re.compile(r'[a-z|A-Z][a-z][a-z]') # looks for any 3 letters with the first capitalized
    # splits up the protein name into a list by the amino acids
    # p.Thr141Met - > ['p.','141','']
    x = pattern.split(protein)
    # all amino acid names found
    # p.Thr141Met - > ['Thr','Met']
    aas = pattern.findall(protein)
    # see abrev_gene
    mgene = abrev_gene(gene)
    # see abrev_aa
    aa1 = abrev_aa(aas[0])
    # from patter.split(protein)
    aaNum = x[1]
    # second aa see abrev_aa
    aa2 = abrev_aa(aas[1])
    # the 'post' string
    # this area is a little nebulous, but basically most variants wont have a post string
    # attempts to propery format some of the weirder variants
    post = x[2]
    # handling some of the weider ones, like p.Thr141_P150Dup etc.
    if len(x) == 4: # most of the normal ones will only get split 3 ways (two amino acids)
        post = x[2] + abrev_aa(aas[2]) # if it is weird then we will attempt to put teh final amino acid at the end
    # now we try and handle any frameshifts
    # looks for 'fsTer' followed by any integer
    fspattern = re.compile(r'fsTer[1-9][0-9]*$')
    fs = fspattern.findall(protein) # if it is not a framshift it wont find that pattern
    if fs: # check that it found it.
        fs = fs[0] # take it out of list form
        aa2 = '' # I don't like the second amino acid being there, I think it is bad nomenclature (plus the variant name is to abreviate)
        post = re.sub('Ter', 'X', fs) #finally replate the Ter with an X
    # create the variant name from the above variables and return it!
    variant = mgene + '-' + aa1 + aaNum + aa2 + post
    return(variant)


#failed list
#
# p.Ter903LysextTer5
# p.Met1?
# p.Ter870delextTer?
# p.His293_Glu294insLeuAsp


