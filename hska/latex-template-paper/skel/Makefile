
DOCUMENT=<LATEXTEMPLATE>


doc:
	pdflatex $(DOCUMENT).tex
	makeglossaries $(DOCUMENT)
	pdflatex $(DOCUMENT).tex
	pdflatex $(DOCUMENT).tex

fast:
	pdflatex $(DOCUMENT).tex
clean:
	rm *aux *glg *glo *gls *ist *lof *log *out *toc *pyg

cleanall:
	rm *aux *glg *glo *gls *ist *lof *log *out *toc *pyg *pdf


