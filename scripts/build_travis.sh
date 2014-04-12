#!/bin/bash
files=( "title" "david" "samuel" "jakob" "andre" )
echo ">> Starts concating files"
for file in "${files[@]}"
do
  cat "src/${file}.md"
  echo
done > union_docu.md

echo ">> Finished concating"
echo ">> Runs Pandoc"

pandoc --filter pandoc-citeproc --toc --include-in-header src/titlesec.tex union_docu.md -o union_docu.pdf
rm union_docu.md

exit 0
