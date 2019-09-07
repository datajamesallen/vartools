import os
import sqlite3
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
    schemadir = os.path.join(BASEDIR, 'schema.sql')
    executeScriptsFromFile(schemadir, con)
    return None

