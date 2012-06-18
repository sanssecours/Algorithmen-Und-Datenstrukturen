# Description #

This is a small text describing various topics of the course "Algorithmen und Datestrukturen" held at the University of Technology in Vienna. The whole text is written in German.

# Dependencies #

* [Xelatex](http://www.tug.org/texlive/)
* [Highlight](http://www.andre-simon.de/doku/highlight/en/highlight.html)
* Various Fonts (e.g. [EB-Garamond](https://github.com/georgd/EB-Garamond))

If you do not own some of the fonts mentioned in the document, just replace the font names — they are located under the comment "% -- Fonts --" — with the name of fonts you have already installed on your system.

# Translation #

	# Convert pseudocode examples to LaTeX
	cd Utilities; ./convert_code_to_tex.sh; cd ..
	# Generate document
	xelatex Algodat; biber Algodat; xelatex Algodat
