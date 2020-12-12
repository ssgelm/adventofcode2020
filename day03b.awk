#!/usr/bin/awk -f

function countTrees(right, down) {
  trees = 0
  row = 1
  col = 0
  while (row <= NR) {
    col = (col + right) % len
    row += down
    if (area[row, col+1] == "#") trees++
  }
  return trees
}
{
  split($0,line,"")
  for (n in line) {
    area[NR, n]=line[n]
  }
  len = length($0)
  delete line
}
END {
  total = countTrees(1, 1)
  total *= countTrees(3, 1)
  total *= countTrees(5, 1)
  total *= countTrees(7, 1)
  total *= countTrees(1, 2)
  print total
}
