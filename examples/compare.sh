#!/bin/bash

if [[ $# -ne 2 ]]; then
  echo "usage: $0 <hfst> <gold-standard>" >&2
  exit 1
fi

[[  -s "$2" ]] || exit 0

grep -o '<[^>]*>\|{[^}]*}' "$2" | sort -u > "$2".mchar
cut -f1 -d: "$2" | hfst-strings2fst -m "$2".mchar -j -o "$2".hfst
hfst-compose "$2".hfst "$1" | hfst-fst2strings -o "$2".res
diff -U0 <(sort -u "$2") <(sort -u "$2".res)
