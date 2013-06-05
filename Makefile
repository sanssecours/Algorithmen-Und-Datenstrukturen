# -----------------------------------------------------------------------------
# 	Generate PDFs from the XeLaTeX files in the current folder
#
# 	Version: 1
# 	Date:    2013-06-04
# 	Author:  René Schwaiger (sanssecours@f-m.fm)
# -----------------------------------------------------------------------------

.PHONY: all clean code2latex doc run

# -- Rules --------------------------------------------------------------------

all: doc

# Remover auto generated files
clean:
	latexmk -C
	rm -r Code

# Generate the documentation
doc: code2latex
	latexmk -xelatex *.tex

# Convert sample code to (Xe)LaTeX code
code2latex:
	Utilities/convert_code_to_tex.sh
