import json
import math
import os
import re
import sqlite3
import sys
import time
from collections import OrderedDict
from vartools.database import dbcon

BASEDIR = os.path.dirname(__file__)

class StdevFunc:
    def __init__(self):
        self.M = 0.0
        self.S = 0.0
        self.k = 1

    def step(self, value):
        if value is None:
            return
        tM = self.M
        self.M += (value - tM) / self.k
        self.S += (value - tM) * (value - self.M)
        self.k += 1

    def finalize(self):
        if self.k < 3:
            return None
        return math.sqrt(self.S / (self.k-2))

from vartools.varfx import getaaNumVar
from vartools.varfx import un_abrev_gene

def create_all_variants_ext_table():
    con = dbcon()
    cursor = con.cursor()
    con.create_aggregate("stdev",1,StdevFunc)
    query = "DROP TABLE IF EXISTS all_variants_ext"
    cursor.execute(query)
    query = """ CREATE TABLE all_variants_ext (
                    gene VARCHAR(25) NOT NULL,
                    aa_orig VARCHAR(25),
                    aa_var VARCHAR(25),
                    aa_num INT(255),
                    sub_domain VARCHAR(25),
                    domain VARCHAR(25),
                    variant VARCHAR(50) PRIMARY KEY
                );"""
    cursor.execute(query)
    con.commit()
    con.close()
    return None

def update_all_variants_ext():
    """
    extended version of all variants, with extrapolated information
    """
    create_all_variants_ext_table() # drops the old table and makes a new one
    con = dbcon()
    cursor = con.cursor()
    con.create_aggregate("stdev", 1, StdevFunc)
    query = "SELECT * FROM all_variants"
    cursor.execute(query)
    rows = cursor.fetchall()
    variants_ext = []
    for result in rows:
        variant = result[0]
        p = re.compile("([RHKDESTNQCUGPAVILMFYWX])[0-9]")
        m = p.search(variant)
        if m:
            aa_orig = m.group(1)
        p = re.compile("[^h][0-9]([RHKDESTNQCUGPAVILMFYWX])(?!el)")
        m = p.search(variant)
        if m:
            aa_var = m.group(1)
        aa_num = getaaNumVar(variant)
        p = re.compile("(^.+?)-")
        m = p.search(variant)
        if m:
            subunit = m.group(1)
        gene = un_abrev_gene(subunit)
        domain_dict = domainload(gene)
        if domain_dict:
            domain_dict = reversed(domain_dict[gene])
            for entry in domain_dict:
                if int(aa_num) <= int(entry["num"]):
                    sub_domain = entry["Domain"]
                    domain = entry["Class"]
        else:
            sub_domain = None
            domain = None
        all_variants_row = [gene, aa_orig, aa_var, aa_num, sub_domain, domain, variant]
        rowcur = con.cursor()
        query = "INSERT INTO all_variants_ext VALUES (?,?,?,?,?,?,?)"
        rowcur.execute(query, all_variants_row)
        #print(all_variants_row)
        variants_ext.append(all_variants_row)
    con.commit()
    con.close()
    return None

def rebuild_datadump():
    update_all_variants_ext()
    con = dbcon()
    cursor = con.cursor()
    con.create_aggregate("stdev", 1, StdevFunc)
    query = "DROP TABLE IF EXISTS database"
    cursor.execute(query)
    query = "CREATE TABLE database AS SELECT * FROM summary"
    cursor.execute(query)
    con.commit()
    con.close()
    print("Database rebuilt")
    return(None)

def makedict(rows, colnames):
    drows = []
    for row in rows:
        row = list(row)
        zipObj = zip(colnames, row)
        d = OrderedDict(dict(zipObj))
        drows.append(d)
    return(drows)

def export_datadump(Gene):
    con = dbcon()
    cursor = con.cursor()
    query = "SELECT * FROM database WHERE Gene = '" + Gene + "' ORDER BY aa_num"
    cursor.execute(query)
    # get column headers
    names = [description[0] for description in cursor.description]
    database = cursor.fetchall()
    con.close()
    datadumpfile = "database-" + Gene + time.strftime("-%Y%m%d-%H%M%S") + ".csv"
    with open(datadumpfile, "w") as f:
        f.write(",".join(names) + "\n")
        for row in database:
            f.write(",".join([str(item) for item in row]) + "\n")
    print(datadumpfile + " written to disk")
    return None

def zero(row, columns):
    # convert None to 0
    for col in columns:
        if (row[col] == None):
            row[col] = 0
    return(row)

def domainload(Gene):
    domain_dir = os.path.join(BASEDIR, "domains.json")
    with open(domain_dir) as f:
        d = json.load(f, object_pairs_hook=OrderedDict)
        d = d["Genes"]
        domaind = None
        for entry in d:
            if Gene in entry:
                domaind = OrderedDict(reversed(entry.items()))
        f.close()
    return domaind

