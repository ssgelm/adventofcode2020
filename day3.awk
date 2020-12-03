#!/usr/bin/awk -f

{
  split($0,line,"")
  for (n in line) {
    area[NR, n]=line[n]
  }
  len = length($0)
  delete line
}
END {
  row = 1
  col = 1
  while (row <= NR) {
    col = ((col + 2) % len) + 1
    row++
    if (area[row, col] == "#") trees++
  }
  print trees
}
