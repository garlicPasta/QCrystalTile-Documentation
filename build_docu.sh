#!/bin/bash
files=( "title" "david" "samuel" "jakob" "andre" )

for file in "${files[@]}"
do
  cat "src/${file}.md"
  echo
done > union_docu.md

pandoc --filter pandoc-citeproc --toc --include-in-header src/titlesec.tex union_docu.md -o union_docu.pdf
rm union_docu.md
evince union_docu.pdf



