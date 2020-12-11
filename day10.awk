#!/usr/local/bin/gawk -f

{
  adapters[NR]=$0
}
END {
  len = asort(adapters, sortedAdapters)
  for (i=1; i<=len; i++) {
    switch (sortedAdapters[i] - sortedAdapters[i-1]) {
    case 1:
      diffOne++
      break
    case 3:
      diffThree++
      break
    }
  }
  print diffOne * ++diffThree
}
