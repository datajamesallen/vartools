import sqlite3
import os
import datetime
import sys

now = datetime.datetime.now()

dbname = "../var.db"
glun1wt = ["h1a-WT"]
glun2wt = ["h2A-WT","h2B-WT","h2C-WT","h2D-WT"]
def dbupload(datalist):
    # first convert data into the proper data type so that SQLite knows how to deal with it
    newdatalist = []
    for row in datalist:
        intro = row[:3]
        dat = row[3:24]
        info = row[24:26]
        fit = row[26:32]
        assay = row[32]
        date_rec = datetime.datetime.strptime(row[33],'%Y-%m-%d')
        date_inj = datetime.datetime.strptime(row[34],'%Y-%m-%d')
        volt = row[35]
        last = row[36:]
        newdat = []
        for item in dat:
            if item == None:
                newdat.append(item)
            else:
                newdat.append(float(item))
        newfit = []
        for item in fit:
            if item == None:
                newfit.append(item)
            else:
                newfit.append(float(item))
        newrow = intro + newdat + info + newfit + [assay] + [date_rec] + [date_inj] + [volt] + last
        newdatalist.append(newrow)
    # next find what constructs are in the file
    # figure out which ones are WT and which are Variant
    varlist = []
    wtlist = []
    for row in newdatalist:
        # check if the construct is wildtype
        if row[1] in glun1wt and row[2] in glun2wt:
            wtlist.append((row[1], row[2]))
        else:
            varlist.append((row[1],row[2]))
    varset = set(varlist)
    # this will be the list of variants by individual subunit
    variants = []
    for Variant in varset:
        if Variant[0] not in glun1wt:
            variants.append(Variant[0])
        if Variant[1] not in glun2wt:
            variants.append(Variant[1])
    wtset = set(wtlist)
    # for each variant, give it it's corresponding wild type pair
    # each file / experiment should be broken up by variant/wildtype pairings
    wtdata = []
    remaining = []
    for Variant in variants:
        for row in newdatalist:
            # check if the construct is wildtype
            if row[1] in glun1wt and row[2] in glun2wt:
                wtdata.append([Variant] + row + [now])
            else:
                remaining.append(row)
    vardata = []
    for row in remaining:
        if row[1] in glun1wt and row[2] in glun2wt:
            continue
        else:
            if row[1] in glun1wt:
                Variant = row[2]
            elif row[2] in glun2wt:
                Variant = row[1]
            else:
                sys.exit("could not figure out variant")
            vardata.append([Variant] + row + [now])
    con = sqlite3.connect(dbname)
    c = con.cursor()
    rowlen = 44
    varexstring = "REPLACE INTO varoocytes values (" + ("?," * rowlen)[:-1] + ")"
    wtexstring = "REPLACE INTO wtoocytes values (" + ("?," * rowlen)[:-1] + ")"
    for row in wtdata:
        print(row)
        c.execute(wtexstring, row)
    for row in vardata:
        print(row)
        c.execute(varexstring, row)
    con.commit()
    con.close()
    return(None)

def ooload():
    print("Loading all files from the /varkit-o/dir/done directory")
    direc = "../../varkit-o/dir/done"
    for oofile in os.listdir(direc):
        with open(direc + '/' + oofile, 'r') as f:
            data = f.readlines()
            datalist = []
            for row in data:
                rowlist = row.split(",")
                if rowlist[0] == "COLUMN":
                    continue
                datarow = rowlist[1:]
                datarow = [None if item == '' or item == '\n' else item for item in datarow]
                datalist.append(datarow)
            dbupload(datalist)
ooload()
