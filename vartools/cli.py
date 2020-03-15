import click
from os import getcwd
from os.path import exists as path_exists
from os.path import dirname
from os.path import join as path_join
from os.path import abspath
from os.path import isfile
from configparser import RawConfigParser

@click.group()
#@click.argument('test')
def db():
    """ all database related commands """
    pass

BASEDIR = dirname(__file__)

@click.command()
@click.argument('dbpath')
def link(dbpath):
    """ connects to the database at the given path, if it exits """
    dbpath_abs = abspath(dbpath)
    if isfile(dbpath_abs):
        # need to get absolute path of where it is installed on the machine
        configdir = path_join(BASEDIR, 'config.ini')
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
    configdir = path_join(BASEDIR, 'config.ini')
    print(configdir)
    parser.read(configdir)
    return parser.get('database','path')

@click.command()
def show():
    """ show the path of the currently linked database """
    print(getdbpath())

@click.command()
@click.argument('name')
def init(name):
    """ initialize a sqlite database with default schema """

    from vartools.database import dbinitdef

    dbpath_abs = abspath(name)
    dbinitdef(dbpath_abs)
    click.echo('Initialized the database: ' + name)
    # need to get absolute path of where it is installed on the machine
    configdir = path_join(BASEDIR, 'config.ini')
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
def views_update():
    """ update the views of the sqlite database """

    from vartools.database import db_update_views

    db_update_views()
    return None

@click.command()
@click.argument('files', nargs = -1)
@click.option('-f','--force','force', default = False)
def oo_upload(files, force):
    """
    uploads prepared oocyte .csv files to the linked database
    """

    from vartools.database import oocytes_upload_all

    abs_files = []
    for f in files:
        abs_f = abspath(f)
        if not path_exists(abs_f):
            print('Invalid path name supplied')
            raise SystemExit
        if not isfile(abs_f):
            continue
        abs_files.append(abs_f)
    if len(abs_files) == 0:
        print('Invalid path name supplied')
    oocytes_upload_all(abs_files, force)
    return None


@click.command()
@click.argument('name')
def dropdb(name):
    click.echo('Dropped the database')

@click.command()
@click.argument('gene_list_file_path')
def clinvar_update(gene_list_file_path):

    from vartools.clinvar import clinvar_script

    clinvar_script(gene_list_file_path)

@click.command()
@click.argument('transcript_list_file')
@click.argument('version', default='2.1.1')
def gnomad_update(transcript_list_file, version):
    """
    updates the database with gnomad variants
    for a given list of ENST transcripts in a line
    separated file
    """

    from vartools.gnomad import build_gnomAD_FromTranscriptList

    build_gnomAD_FromTranscriptList(transcript_list_file, version)

@click.group()
def result():
    """ database results functions """
    pass


@click.command()
@click.argument('variant')
@click.argument('assay')
def oo_download(variant, assay):
    """ download the data for a variant / assay pair  in a .csv file """

    from vartools.result import download_variant_assay_csv

    download_variant_assay_csv(variant, assay)
    return None

@click.command()
@click.argument('file_name')
@click.option('-t','-top_constraint','top_c', default = "False")
@click.option('-b','-bot_constraint','bot_c', default = "False")
def re_fit_oo(file_name, top_c, bot_c):
    from vartools.result import re_fit_data
    if top_c == "True":
        top_c = True
    elif top_c == "False":
        top_c = False
    else:
        sys.exit("Invalid option: " + top_c)
    if bot_c == "True":
        bot_c = True
    elif bot_c == "False":
        bot_c = False
    else:
        sys.exit("Invalid option: " + bot_c)
    re_fit_data(file_name, top_c, bot_c)
    return None

@click.command()
@click.argument('variant')
@click.argument('assay')
def pub_download(variant, assay):

    from vartools.result import download_pub_variant_assay

    download_pub_variant_assay(variant, assay)
    return None

@click.command()
@click.option('-c','-check_all','check_all',default = "True")
def directory(check_all):

    from vartools.result import create_directory

    if check_all == "True":
        check = True
    elif check_all == "False":
        check = False
    else:
        sys.exit("Invalid option: " + check_all)
    create_directory(check)
    return None


@click.command()
def rebuild_database():

    from vartools.datadump import rebuild_datadump

    rebuild_datadump()
    return None


@click.command()
@click.argument('gene')
def datadump(gene):

    from vartools.datadump import export_datadump

    rebuild_datadump()
    export_datadump(gene)
    return None

result.add_command(datadump)
result.add_command(directory)
result.add_command(pub_download)
result.add_command(oo_download)
result.add_command(re_fit_oo)

db.add_command(result)
db.add_command(link)
db.add_command(show)
db.add_command(init)
db.add_command(views_update)
db.add_command(clinvar_update)
db.add_command(gnomad_update)
db.add_command(oo_upload)

@click.group()
def oo():
    """ oocyte related commands """
    pass


@click.command()
@click.argument('files', nargs = -1)
@click.option('-o','--output', 'output', default=getcwd())
def prepare(files, output):
    """ convert an excel file to the oocytes format """

    from vartools.oo_prepare import convert_all

    abs_files = []
    for f in files:
        abs_f = abspath(f)
        if not path_exists(abs_f):
            print('Invalid path name supplied')
            raise SystemExit
        if not isfile(abs_f):
            continue
        abs_files.append(abs_f)
    if len(abs_files) == 0:
        print('Invalid path name supplied')
    install_dir = dirname(__file__)
    header_abs = path_join(install_dir, 'blank.oo')
    convert_all(abs_files, header = header_abs, outdir = output)

oo.add_command(prepare)

@click.group()
def master():
    pass

master.add_command(db)
master.add_command(oo)

def main():
    master()

