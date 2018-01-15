DOCUMENT=moonproject
NOW=$(shell date +%Y-%m-%d_%H-%M-%S)

all:
	find include -name "*.md" -exec sh -c 'pandoc --to=latex --variable=documentclass:report --output=`dirname {}`/`basename {} .md`.tex {}' \; 
	pdflatex $(DOCUMENT).tex -interaction=nonstopmode -halt-on-error
	bibtex $(DOCUMENT)
	pdflatex $(DOCUMENT).tex -interaction=nonstopmode -halt-on-error
	pdflatex $(DOCUMENT).tex -interaction=nonstopmode -halt-on-error
	pdflatex $(DOCUMENT).tex -interaction=nonstopmode -halt-on-error
