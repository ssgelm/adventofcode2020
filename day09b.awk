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
  weakNumber = $0
}
END {
  for (i=1; i<NR; i++) {
    sum = lines[i]
    for (j=i+1; j<NR; j++) {
      sum += lines[j]
      if (sum == weakNumber) {
        beginning = i
        end = j
        break
      }
    }
  }
  min = lines[beginning]
  max = lines[end]
  for (i=beginning; i<=end; i++) {
    if (lines[i] < min) min = lines[i]
    if (lines[i] > max) max = lines[i]
  }
  print min + max
}
