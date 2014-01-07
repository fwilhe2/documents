#!/bin/bash
# Script to create a new LaTeX-document from template
# Call it with one parameter which is the name of the document

shortname=""
longname="" #TODO: Sinnvoll benutzen...
current_date=$(date +"%d.%m.%Y")

if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
	echo "Please specify the name of the new document as the first argument."
	exit 1
fi

if [ $# -eq 1 ]
  then
	shortname=$1
	longname=$1 #if no longname is given, just take the shortname
fi

if [ $# -eq 2 ]
  then
	shortname=$1
	longname=$2
fi

echo "create directory $shortname"
mkdir $shortname

echo "copy template files to $shortname"
cp -r skel/* $shortname
cp skel/.* $shortname

echo "replace placeholder with '$shortname'"
sed -i "s/<LATEXTEMPLATE>/$shortname/g" $shortname/*

echo "set date in template-file"
sed -i "s/<DATUM>/$current_date/g" $shortname/*

echo "rename LaTeX file"
mv "$shortname/<LATEXTEMPLATE>.tex" $shortname/$shortname.tex

echo "cd into project directory"
cd $shortname

echo "create git repo, add files and do a initial commit"

git init

git add *

git commit -m "Initial commit."
