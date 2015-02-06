DOCUMENT=hpc.md

all:
	pandoc -s --gladtex $(DOCUMENT) -o hpc.htex
	gladtex -d formeln hpc.htex
	rm hpc.htex
	pandoc -s -o hpc.pdf $(DOCUMENT) --listings --toc --toc-depth=1

loop:
	while true; do inotifywait -e modify $(DOCUMENT); make; done

clean:
	rm -r formeln hpc.html hpc.pdf
