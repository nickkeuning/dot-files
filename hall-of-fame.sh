# pipe clipboard, print all lines with failing tests, split on period and drop test name, join with period
pbpaste | awk 'BEGIN {OFS = "."} /\[FAIL\]/ {print $6}' | uniq | awk 'BEGIN {print"/TestCaseFilter:\"Category=Integration&("} {print "FullyQualifiedName~"$1"|"} END {print ")\""}' | tr -d "\n" | pbcopy
