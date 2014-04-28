#!/bin/bash
files=("meta" "samuel" "david" "jakob" "andre" )

for file in "${files[@]}"
do
  cat "src/${file}.md"
  echo
done > union_docu.md

pandoc --filter pandoc-citeproc --toc --include-in-header src/titlesec.tex union_docu.md -o union_docu.pdf
rm union_docu.md
pdflatex ./src/title_wrapper.tex
pdfunite ./title_wrapper.pdf union_docu.pdf final_documentation.pdf
evince final_documentation.pdf



