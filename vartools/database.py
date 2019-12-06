import os
import sys
import sqlite3
import datetime
from configparser import RawConfigParser

BASEDIR = os.path.dirname(__file__)

def dbcon():
    """ returns the sqlite database connection object from the database
    that is currently 'linked' in the config.ini file """
    configdir = os.path.join(BASEDIR, 'config.ini')
    data = open(configdir, 'r+')
    parser = RawConfigParser()
    parser.read(configdir)
    dbpath = parser.get('database','path')
    con = sqlite3.connect(dbpath)
    return con

def dbupload(datalist, force):
    """
    takes the initial data from the datalist, parses and uploads to the database
    """
    glun1wt = ["h1a-WT","r1a-WT"]
    glun1wt_l = ["h1a-wt","r1a-wt"]
    glun2wt = ["r2A-WT","r2B-WT","r2C-WT","r2D-WT","h2A-WT","h2B-WT","h2C-WT","h2D-WT"]
    glun2wt_l = ["r2a-wt","r2b-wt","r2c-wt","r2d-wt","h2a-wt","h2a-wt","h2b-wt","h2c-wt","h2d-wt"]
    now = datetime.datetime.now()
    # first convert data into the proper data type so that SQLite knows how to deal with it
    newdatalist = []
    for row in datalist:
        #print(row)
        intro = row[:3]
        dat = row[3:24]
        info = row[24:26]
        fit = row[26:32]
        assay = row[32]
        try:
            date_rec = datetime.datetime.strptime(row[33],'%Y-%m-%d')
        except:
            try:
                date_rec = datetime.datetime.strptime(row[33], '%d/%m/%y')
            except:
                date_rec = None
        try:
            date_inj = datetime.datetime.strptime(row[34],'%Y-%m-%d')
        except:
            try:
                date_inj = datetime.datetime.strptime(row[34], '%d/%m/%y')
            except:
                date_inj = None
        volt = row[35]
        last = row[36:]
        newdat = []
        for item in dat:
            if item == None:
                newdat.append(item)
            else:
                try:
                    item = float(item)
                    newdat.append(item)
                except:
                    newdat.append(None)
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
        glun1_test_wt = row[1]
        glun2_test_wt = row[2]
        if glun1_test_wt in glun1wt and glun2_test_wt in glun2wt:
            wtlist.append((row[1], row[2]))
        else:
            if (glun1_test_wt.lower() == 'h1a-wt') and (glun1_test_wt.lower() == 'h2a-wt'):
                print("WARNING: incorrectly typed wildtype: " + glun1_test_wt + '/' + glun2_test_wt)
                print("This will be fixed in the database, but not in the file")
                wtlist.append(('h1a-WT','h2A-WT'))
            elif (glun1_test_wt.lower() == 'h1a-wt') and (glun1_test_wt.lower() == 'h2b-wt'):
                print("WARNING: incorrectly typed wildtype: " + glun1_test_wt + '/' + glun2_test_wt)
                print("This will be fixed in the database, but not in the file")
                wtlist.append(('h1a-WT','h2B-WT'))
            else:
                varlist.append((row[1],row[2]))
    varset = set(varlist)
    # this will be the list of variants by individual subunit
    variants = []
    for Variant in varset:
        glun1_var = Variant[0]
        glun2_var = Variant[1]
        if Variant[0] not in glun1wt:
            variants.append(Variant[0])
        if Variant[1] not in glun2wt:
            variants.append(Variant[1])
    wtset = set(wtlist)
    #print(assay, " : ", varset)
    # for each variant, give it it's corresponding wild type pair
    # each file / experiment should be broken up by variant/wildtype pairings
    wtdata = []
    remaining = []
    for Variant in variants:
        for row in newdatalist:
            # check if the construct is wildtype for each data set
            if row[1] in glun1wt and row[2] in glun2wt:
                # add in extra information
                wtdata.append([Variant] + row + [now])
            else:
                remaining.append(row)
    vardata = []
    for row in remaining:
        if row[1] in glun1wt and row[2] in glun2wt:
            continue
        else:
            if row[1].lower() in glun1wt_l:
                Variant = row[2]
            elif row[2].lower() in glun2wt_l:
                Variant = row[1]
            else:
                sys.exit("could not figure out variant")
            vardata.append([Variant] + row + [now])
    con = dbcon()
    c = con.cursor()
    rowlen = 44
    varexstring = "REPLACE INTO varoocytes values (" + ("?," * rowlen)[:-1] + ")"
    wtexstring = "REPLACE INTO wtoocytes values (" + ("?," * rowlen)[:-1] + ")"
    n_wt_rows = 0
    for row in wtdata:
        #print(row)
        c.execute(wtexstring, row)
        n_wt_rows += c.rowcount
    n_var_rows = 0
    for row in vardata:
        #print(row)
        c.execute(varexstring, row)
        n_var_rows += c.rowcount
    # execute code here to wait before commiting to the database.
    if force:
        con.commit()
        con.close()
    else:
        print("The following changes will be made:")
        print("Adding/replacing " + str(n_wt_rows) + " rows of WT data")
        print(assay + " : " + str(wtset))
        print("Adding/replacing " + str(n_var_rows) + " rows of Variant data")
        print(assay + " : " + str(varset))
        response = input("Make these changes? y/n (Enter=yes)")
        if response == "" or response == "y":
            con.commit()
            con.close()
        else:
            con.rollback()
            con.close()
    return None

def upload_oocyte_dailyrec(filename, force):
    """
    uploads the oocyte daily recording file to the database
    """
    print("Gathering data from " + filename)
    with open(filename) as f:
        data = f.readlines()
        datalist = []
        for row in data:
            rowlist = row.rstrip().split(",")
            datarow = [None if item == '' or item == '\n' else item for item in rowlist]
            datalist.append(datarow)
        dbupload(datalist[1:], force)
    return None

def oocytes_upload_all(filenames, force):
    for filename in filenames:
        ext = filename[-3:]
        if ext not in ("csv"):
            continue
        upload_oocyte_dailyrec(filename, force)
    return None

def executeScriptsFromFile(filename, con):
    """
    executes all sql commands from a file,
    given a filename and a sqlite database connection

    modified from https://stackoverflow.com/questions/19472922/reading-external-sql-script-in-python
    """
    c = con.cursor()

    # Open and read the file as a single buffer
    fd = open(filename, 'r')
    sqlFile = fd.read()
    fd.close()

    # all SQL commands (split on ';')
    sqlCommands = sqlFile.split(';')

    # Execute every command from the input file
    for command in sqlCommands:
        # This will skip and report errors
        # For example, if the tables do not yet exist, this will skip over
        # the DROP TABLE commands
        try:
            c.execute(command)
        except Exception as err:
            pass
            #print("Command skipped: ", command, "because of: ", err)
    return None

def dbinitdef(dbpath):
    print(dbpath)
    """ initialize an new sqlite database with the default schema """
    con = sqlite3.connect(dbpath)
    # get the path of the schema.sql file
    tabledir = os.path.join(BASEDIR, 'tables')
    tables = os.listdir(tabledir)
    for table in tables:
        table_fulldir = os.path.join(tabledir, table)
        executeScriptsFromFile(table_fulldir, con)
    viewdir = os.path.join(BASEDIR, 'views')
    views = os.listdir(viewdir)
    for view in views:
        view_fulldir = os.path.join(viewdir, view)
        executeScriptsFromFile(view_fulldir, con)
    return None

def db_update_views():
    con = dbcon()
    viewdir = os.path.join(BASEDIR, 'views')
    views = os.listdir(viewdir)
    for view in views:
        view_fulldir = os.path.join(viewdir, view)
        executeScriptsFromFile(view_fulldir, con)
    print("The following views were overwritten/updated:")
    print(views)
    return None

    
