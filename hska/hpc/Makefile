DOCUMENT=hpc.md

all:
	pandoc -s -o hpc.html $(DOCUMENT) --mathjax
	pandoc -s -o hpc.pdf $(DOCUMENT)

loop:
	while true; do inotifywait -e modify $(DOCUMENT); make; done

clean:
	rm hpc.html hpc.pdf
