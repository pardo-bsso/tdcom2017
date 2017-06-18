MEXT = md

# All markdown files in the working directory
SRC = $(wildcard *.$(MEXT))
SVGS= $(wildcard src/*.svg)
PNGS= $(addprefix out/, $(subst src/,,$(SVGS:.svg=.png)) )
PDFS= $(addprefix out/, $(SRC:.md=.pdf) )
DOCX= $(addprefix out/, $(SRC:.md=.docx) )

pdf: $(PDFS) $(PNGS)
docx: $(DOCX) $(PNGS)

all: $(PDFS)

out/%.pdf: %.md
	pandoc --latex-engine=xelatex --template templates/default.latex -V pagestyle=ath -o $@ $<

out/%.docx: %.md
	pandoc -t docx -o $@ $<

out/%.png: src/%.svg
	inkscape -z -D -d 150 -b white -e $@ $< && mogrify -density 300 -units PixelsPerInch $@
