#!/usr/local/bin/gawk -f

{
  lines[NR] = $0
}
NR > 25 {
  isSum = 0
  for (i=NR-25; i<NR; i++) {
    for (j=NR-25; j<NR; j++) {
      if (i == j) continue
      if (lines[i]+lines[j] == $0) isSum = 1
    }
  }
  if (isSum) next
  print $0
  exit
}
