

# Setup

## Install Make

```
sudo apt-get install build-essential
```

(Yes, this is not just make, but I find it handy to use the meta package..)

## Install LaTeX

```
sudo apt-get install texlive-full
```

## Install inotify-tools 
needed for `make loop`

```
sudo apt-get install inotify-tools
```

# Make Targets

## all

This is the default target. It runs pdflatex multiple times + bibtex

## loop

This uses inotifywait to build when a file is saved. Uses the all target to build.

## fast

Runs pdflatex one time. Most useful when an existing build should be updated.

## test

Builds the project, greps for warnings and uses lacheck and chktex to check for errors in the latex-files. lacheck and chktex must be installed for this to work.

## word

Uses pandoc to create a docx-file for spell-checking purposes. Do not expect a perfect word-file.

## plain

Uses detex to create a plain text file for spell-checking purposes. Do not expect a perfect plain-text-file.

## clean

Delets all(?) generated files, including the pdf. I do this always before commiting.

## run

Uses xdg-open to open the compiled file in a PDF viewer.

# Sources

[General hints on modern LaTeX](http://www.olivierverdier.com/posts/2013/07/15/modern-latex)

[Regex for grepping warnings of pdftex](http://tex.stackexchange.com/a/27881)