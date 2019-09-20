"""
This module prepares oocyte data formatted in the CFERV 'daily recording files' format

main function:
    convert_all(filelist, header, outddir)

"""

import openpyxl as xl
import datetime
import string
import re

def readrow(ws, cols, i):
    row = []
    for letter in cols:
        val = ws[letter + str(i)].value
        row.append(val)
    return(row)

def xl2list(xlfile):
    """ creates a list """
    # starting values
    start = 3
    oocols = string.ascii_uppercase
    oononelist = [None] * 26
    oorow = ''
    expcols = ['AA','AB','AC','AD','AE','AF','AG','AH','AI','AJ']
    expnonelist = [None] * 10
    exprow = ''
    fits = [None] * 6
    #prefix = [""]
    # end starting values
    wb = xl.load_workbook(xlfile)
    ws = wb['DataEntry']
    i = start
    oolist = []
    while oorow != oononelist:
        oorow = readrow(ws, oocols, i)
        if oorow[-1] == "DEL":
            i += 1
            continue
        oolist.append(oorow)
        i += 1
    oolist.pop(-1)
    i = start
    explist = []
    while exprow != expnonelist:
        exprow = readrow(ws, expcols, i)
        explist.append(exprow)
        i += 1
    explist.pop(-1)
    dlist = []
    if len(explist) == 1:
        for row in oolist:
            newrow = row + fits + explist[0]
            dlist.append(newrow)
    elif len(explist) == len(oolist):
        for i in range(0, len(oolist)):
            newrow = oolist[i] + fits + explist[i]
            dlist.append(newrow)
    else:
        explist = explist[0]
        for row in oolist:
            newrow = row + fits + explist
            dlist.append(newrow)
    return(dlist)

def writeoofile(dlist, header, xlfile, outdir):
    """ writes a .csv file in the specified format """
    with open(header, 'r') as hfile:
        header = hfile.readlines()
    hfile.close()
    oofile = dlist[0][0]
    p = re.compile(".+-.+-.+-.+-")
    res = p.findall(oofile)
    ph = re.compile("p[hH]")
    phres = ph.search(oofile)
    if (phres):
        oofile = outdir + '/' + res[0][:-1] + '.csv'
    else:
        oofile = outdir + '/' + res[0][:-1] + '.csv'
    with open(oofile, 'w') as opfile:
        for row in header:
            opfile.write(row)
        newdlist = []
        for row in dlist:
            newrow = []
            for value in row:
                if type(value) is int:
                    newval = str(value)
                elif type(value) is float:
                    newval = str(value)
                elif value is None:
                    newval = ""
                elif isinstance(value, datetime.datetime):
                    newval = value.strftime("%Y-%m-%d")
                else:
                    newval = value
                newrow.append(newval)
            newdlist.append(newrow)
            opfile.write(",".join(newrow) + "\n")
    opfile.close()
    print(oofile + ' written to disk')
    return(None)

def ooconv(xlfile, header, outdir):
    """ converts a single excel file into .csv files in the specified outdir """
    dlist = xl2list(xlfile)
    writeoofile(dlist, header, xlfile, outdir)
    return(None)

def convert_all(filelist, header, outdir):
    """ converts a list of excel files into .csv files in the specified outdir """
    for xlfile in filelist:
        ooconv(xlfile, header, outdir)
