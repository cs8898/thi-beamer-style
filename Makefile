all: beamer todo

.PHONY: clean

todo:
	@echo ""
	@echo "TODO Check"
	@echo "=========="
	@grep -r -n --include="*.tex" "TODO" ./ || exit 0
	@echo ""
	@if [ "$$(grep -r -n --include="*.tex" "TODO" ./ | wc -l)" -ne "0" ]; then\
		echo " $$(grep -r -n --include="*.tex" "TODO" ./ | wc -l) remaining TODOs";\
		exit 1;\
	fi
	

beamer: THI-Beamer-Style.pdf

THI-Beamer-Style.pdf: THI-Beamer-Style.tex
	pdflatex --shell-escape -synctex=1 -interaction=nonstopmode THI-Beamer-Style.tex || exit 0
	bibtex THI-Beamer-Style.aux || exit 0
	pdflatex --shell-escape -synctex=1 -interaction=nonstopmode THI-Beamer-Style.tex || exit 0
	pdflatex --shell-escape -synctex=1 -interaction=nonstopmode THI-Beamer-Style.tex

clean:
	rm THI-Beamer-Style.{pdf,out,nav,aux,bbl,blg,fls,log,fdb_latexmk,synctex.gz,toc,snm} || exit 0