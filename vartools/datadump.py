import time
import math
import sqlite3
import sys
import re
import json
import os
from collections import OrderedDict

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

def load_extension_functions():
    con2 = sqlite3.connect('../var.db')
    print(sqlite3.version)
    print(sqlite3.sqlite_version)
    con2.enable_load_extension(True)
    #cursor = con.cursor()
    libname = "../lib/libsqlitefunctions"
    #cursor.execute("SELECT load_extension('" + libname + "')")
    con2.load_extension(libname)
    return(None)

def rebuild_datadump('../var.db'):
    con = sqlite3.connect(database)
    cursor = con.cursor()
    #load_extension_functions()
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
    con = sqlite3.connect('../var.db')
    cursor = con.cursor()
    query = "SELECT * FROM database WHERE Gene = '" + Gene + "' ORDER BY aaNum"
    cursor.execute(query)

    names = [description[0] for description in cursor.description]
    names = names  + ["orig_AA", "var_AA", "Seizures_ALL", "ID_ALL","top_TOTAL"]
    rows = cursor.fetchall()
    con.close()

    datadumpfile = os.path.join("../output", "database-" + Gene + time.strftime("-%Y%m%d-%H%M%S") + ".csv")
    domaind = domainload(Gene)
    d = makedict(rows, names)
    for row in d:
        parseddrow(row, domaind)

    with open(datadumpfile, "w") as f:
        f.write(",".join(names) + "\n")
        for row in d:
            for key, value in row.items():
                f.write(str(value) + ",")
            f.write("\n")
    return(None)

def zero(row, columns):
    # convert None to 0
    for col in columns:
        if (row[col] == None):
            row[col] = 0
    return(row)

def domainload(Gene):
    with open("domains.json") as f:
        d = json.load(f, object_pairs_hook=OrderedDict)
        d = d["Genes"]
        if Gene in d:
            domaind = OrderedDict(reversed(attributes.items()))
        else:
            domaind = None
        f.close()
    return(domaind)

def parseddrow(row, domaind):
    """ parse each row of the dictionary for the datadump """
    # Create a row that shows the original amino acid on the transcript
    p = re.compile("([RHKDESTNQCUGPAVILMFYWX])[0-9]")
    m = p.search(row["Variant"])
    if m:
        row["origaa"] = m.group(1)
    else:
        row["origaa"] = None

    # Create a row that shows the consequential amino acid of the variant
    p = re.compile("[^h][0-9]([RHKDESTNQCUGPAVILMFYWX])(?!el)")
    m = p.search(row["Variant"])
    if m:
        row["varaa"] = m.group(1)
    else:
        row["varaa"] = None

    # Check if either lemke or clinvar say that a patient with a variant has seizures
    p = re.compile("[Ss]eizures|[eE]pilepsy|[eE]pileptic encephalopathy")
    m1 = p.search(str(row["clinvar_Phenotype"]))
    p = re.compile("yes")
    m2 = p.search(str(row["lemke_Seizures"]))
    # check if either matched
    if m1 or m2:
        row["sz_est"] = "TRUE"
    else:
        row["sz_est"] = "FALSE"

    # Check if either lemke or clinvar say that a patient with a variant has id
    p = re.compile("[Ii]tellectual deficiency|[Ii]tellectual disability|[Mm]ental retardation|ID|DD")
    m1 = p.search(str(row["clinvar_Phenotype"]))
    p = re.compile(".")
    m2 = p.search(str(row["lemke_DevDelay"]))
    if m1 or m2:
        row["id_est"] = "TRUE"
    else:
        row["id_est"] = "FALSE" 

    # columns that need to have their values set to 0 if None
    # this means that a variant not found in gnomAD will have 0, not "None"
    zcolumnlist = ["gnomad_all_AlleleCount", "gnomad_controls_AlleleCount", "gnomad_nontopmed_AlleleCount","clinvar_CountObs", "count_TOPMed"]
    row = zero(row, zcolumnlist)

    # total counts for TOPMed
    row["toptotal_AlleleCount"] = row["gnomad_nontopmed_AlleleCount"] + row["count_TOPMed"]
    #row["toptotal_AlleleNum"] = row["gnomad_nontopmed_AlleleNum"] + row["denom_TOPMed"] / 2

    # Write the domain information from the json file if available for this Gene
    if domaind:
        for entry in domaind:
            if row["aaNum"] <= entry:
                row["Domain"] = entry["Domain"]
                row["Class"] = entry["Class"]
    return(row)

if __name__ == "__main__":
    args = sys.argv
    if len(args) != 2:
        print("Please enter a Gene name to export this datadump")
    Gene = args[1]
    rebuild_datadump()
    export_datadump(Gene)


