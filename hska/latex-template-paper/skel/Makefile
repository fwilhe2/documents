
DOCUMENT=<LATEXTEMPLATE>


doc:
	pdflatex -shell-escape -interaction=nonstopmode $(DOCUMENT).tex
	makeglossaries $(DOCUMENT)
	pdflatex -shell-escape -interaction=nonstopmode $(DOCUMENT).tex
	pdflatex -shell-escape -interaction=nonstopmode $(DOCUMENT).tex

fast:
	pdflatex -shell-escape -interaction=nonstopmode $(DOCUMENT).tex

clean:
	rm *aux *glg *glo *gls *ist *lof *log *out *toc *pyg

cleanall:
	rm *aux *glg *glo *gls *ist *lof *log *out *toc *pyg *pdf


