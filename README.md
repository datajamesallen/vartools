# vartools

A command line application for reducing repetitive data analysis

I created this to do a better job at organizing my data.


# Installation

I recommend using pip or similar.
This projects is currently not on pypi, but can still be installed by going into this repository's root directory and running

    $ pip3 install .

# Current Features

configure the currently used database

    $ vartools db connect [SQLITE DATABASE]

show the currently used database

    $ vartools db show

prepare oocyte data files

    $ vartools oo prepare [FILENAMES]

# Planned Features

	$ vartools db results datadump
	$ vartools db results trend
	$ vartools db results -v [Variant]
	$ vartools db results -o [Variant]
	$ vartools db upload -o [FILENAMES]

