#!/usr/bin/bash

VIRTUALENV_DIR=virtualenv
DBC_FILENAME=inverter_dbc

# Create virtualenv if doesn't exist
if [ ! -d "$VIRTUALENV_DIR" ];
then
	echo "Creating virtualenv"
	python3 -m venv $VIRTUALENV_DIR
fi
source $VIRTUALENV_DIR/bin/activate

echo "Updating Requirements"
pip3 install -U pip wheel cantools canmatrix > /dev/null

echo "Building $DBC_FILENAME"
cantools generate_c_source $DBC_FILENAME.dbc

echo "Building sym"
grep -v "SystemSignalLongSymbol" $DBC_FILENAME.dbc > $DBC_FILENAME.tmp.dbc
canconvert $DBC_FILENAME.tmp.dbc $DBC_FILENAME.sym
rm $DBC_FILENAME.tmp.dbc
