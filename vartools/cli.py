import click
import os
import sqlite3
from configparser import RawConfigParser
import _oofit

@click.command()
def helloworld():
    _oofit.fit1([-5.52,-5.00],[50,20],2,0,100,[30])
    return None

@click.group()
#@click.argument('test')
def db():
    """ all database related commands """
    pass

BASEDIR = os.path.dirname(__file__)

@click.command()
@click.argument('dbpath')
def link(dbpath):
    """ connects to the database at the given path, if it exits """
    dbpath_abs = os.path.abspath(dbpath)
    if os.path.isfile(dbpath_abs):
        # need to get absolute path of where it is installed on the machine
        configdir = os.path.join(BASEDIR, 'config.ini')
        # open and parse the config file
        data = open(configdir,'r+')
        parser = RawConfigParser()
        parser.readfp(data)
        parser.set('database','path',dbpath_abs)
        data.truncate(0)
        data.seek(0)
        parser.write(data)
        click.echo(dbpath_abs + ' linked to database')
    else:
        click.echo('There is no sqlite3 database there')

def getdbpath():
    parser = RawConfigParser()
    configdir = os.path.join(BASEDIR, 'config.ini')
    print(configdir)
    parser.read(configdir)
    return parser.get('database','path')

@click.command()
def show():
    """ show the path of the currently linked database """
    print(getdbpath())

from vartools.database.database import dbinitdef

@click.command()
@click.argument('name')
def init(name):
    """ initialize a sqlite database with default schema """
    dbpath_abs = os.path.abspath(name)
    dbinitdef(dbpath_abs)
    click.echo('Initialized the database: ' + name)
    # need to get absolute path of where it is installed on the machine
    configdir = os.path.join(BASEDIR, 'config.ini')
    # open and parse the config file
    data = open(configdir,'r+')
    parser = RawConfigParser()
    parser.readfp(data)
    parser.set('database','path', dbpath_abs)
    data.truncate(0)
    data.seek(0)
    parser.write(data)
    click.echo(dbpath_abs + ' linked to database')

@click.command()
@click.argument('name')
def dropdb(name):
    click.echo('Dropped the database')

from vartools.database.clinvar import clinvar_script

@click.command()
def clinvar_update():
    clinvar_script()

from vartools.database.gnomad import build_gnomAD_FromTranscriptList

@click.command()
@click.argument('transcript_list_file')
@click.argument('version', default='2.1.1')
def gnomad_update(transcript_list_file, version):
    """
    updates the database with gnomad variants
    for a given list of ENST transcripts in a line
    separated file
    """
    build_gnomAD_FromTranscriptList(transcript_list_file, version)

db.add_command(link)
db.add_command(show)
db.add_command(init)
db.add_command(clinvar_update)
db.add_command(gnomad_update)

@click.group()
def oo():
    """ oocyte related commands """
    pass

from vartools.oocytes.prepare import convert_all

@click.command()
@click.argument('files', nargs = -1)
@click.option('--directory', default=os.getcwd())
def prepare(files, directory):
    """ convert an excel file to the oocytes format """
    abs_files = []
    for f in files:
        abs_f = os.path.abspath(f)
        if not os.path.exists(abs_f):
            print('Invalid path name supplied')
            raise SystemExit
        if not os.path.isfile(abs_f):
            continue
        abs_files.append(abs_f)
        print(abs_f)
    if len(abs_files) == 0:
        print('Invalid path name supplied')
    dirname = os.path.dirname(__file__)
    header_abs = os.path.join(dirname, 'oocytes/blank.oo')
    convert_all(abs_files, header = header_abs, outdir = directory)

oo.add_command(prepare)

@click.group()
def master():
    pass

master.add_command(db)
master.add_command(oo)
master.add_command(helloworld)

def main():
    master()

