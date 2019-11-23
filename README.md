# vartools

A command line application for reducing repetitive data analysis

# Installation

I recommend using pip or similar.
This projects is currently not on pypi, but can still be installed by going into this repository's root directory and running

    $ pip3 install .

# Current Features

configure the currently used database

	$ vartools db init [NEW SQLITE DATABASE NAME] # create a new database with default tables and links it
    $ vartools db link [EXISTING SQLITE DATABASE] # link an already created database
	$ vartools db show                            # shows currently linked database
	$ vartools db oocytes-upload [FILENAMES]      # upload prepared oocyte data to the linked database
	$ vartools db clinvar-update                  # updates clinvar based on a list of genes
	$ vartools db gnomad-update                   # updates gnomad based on a list of genes

prepare oocyte data files

    $ vartools oo prepare [FILENAMES]

# Planned Features

	$ vartools db results datadump
	$ vartools db results trend
	$ vartools db results -v [Variant]
	$ vartools db results -o [Variant]

