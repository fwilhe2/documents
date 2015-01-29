DOCUMENT=moonproject
NOW=$(shell date +%Y-%m-%d_%H-%M-%S)

all:
	pdflatex $(DOCUMENT).tex -interaction=nonstopmode -halt-on-error
	bibtex $(DOCUMENT)
	pdflatex $(DOCUMENT).tex -interaction=nonstopmode -halt-on-error
	pdflatex $(DOCUMENT).tex -interaction=nonstopmode -halt-on-error
	pdflatex $(DOCUMENT).tex -interaction=nonstopmode -halt-on-error

loop:
	while true; do inotifywait -e modify include/*.tex -e modify *.tex -e modify *.bib; make; done

fast:
	pdflatex $(DOCUMENT).tex -interaction=nonstopmode -halt-on-error

test:
	pdflatex $(DOCUMENT).tex -interaction=nonstopmode -halt-on-error > /dev/null
	bibtex $(DOCUMENT) > /dev/null
	pdflatex $(DOCUMENT).tex | grep -i ".*:[0-9]*:.*\|warning"
	lacheck bachelorthesis_florian_wilhelm.tex > lacheck.$(NOW).log.txt
	chktex bachelorthesis_florian_wilhelm.tex > chktex.$(NOW).log.txt  2>&1

word:
	pandoc -s $(DOCUMENT).tex -o $(DOCUMENT).docx

plain:
	detex $(DOCUMENT).tex > $(DOCUMENT).txt

clean:
	-@rm *.toc 2> /dev/null || true
	-@rm *.aux 2> /dev/null|| true
	-@rm *.bbl 2> /dev/null|| true
	-@rm *.dvi 2> /dev/null|| true
	-@rm *.ps 2> /dev/null|| true
	-@rm *.synctex.gz 2> /dev/null|| true
	-@rm *.log 2> /dev/null|| true
	-@rm *.blg 2> /dev/null|| true
	-@rm *.out 2> /dev/null|| true
	-@rm *.ist 2> /dev/null|| true
	-@rm *.glo 2> /dev/null|| true
	-@rm *.lof 2> /dev/null|| true
	-@rm *.idx 2> /dev/null|| true
	-@rm *.ilg 2> /dev/null|| true
	-@rm *.ind 2> /dev/null|| true
	-@rm *.lol 2> /dev/null|| true
	-@rm *.pdf 2> /dev/null|| true
	-@rm *~ 2> /dev/null|| true
	-@rm *.glg 2> /dev/null|| true
	-@rm *.gls 2> /dev/null|| true
	-@rm *.docx 2> /dev/null|| true
	-@rm *.lot 2> /dev/null|| true
	-@rm include/*.aux 2> /dev/null|| true
	-@rm include/*~ 2> /dev/null|| true

run:
	xdg-open $(DOCUMENT).pdf
