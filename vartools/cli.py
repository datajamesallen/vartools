import click
import os
import sqlite3
from configparser import RawConfigParser

@click.group()
#@click.argument('test')
def db():
    pass

@click.command()
@click.argument('dbpath')
def connect(dbpath):
    """ connects to the database at the given path, if it exits """
    dbpath_abs = os.path.abspath(dbpath)
    if os.path.isfile(dbpath_abs):
        data = open('config.ini','r+')
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
    parser.read('config.ini')
    return parser.get('database','path')

@click.command()
def show():
    print(getdbpath())

@click.command()
@click.argument('name')
def initdb(name):
    click.echo('Initialized the database')

@click.command()
@click.argument('name')
def dropdb(name):
    click.echo('Dropped the database')

db.add_command(show)
db.add_command(connect)

@click.group()
def oo():
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

def main():
    master()

