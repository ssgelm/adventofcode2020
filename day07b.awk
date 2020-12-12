#!/usr/local/bin/gawk -f

function numBags(color,    bagCount,c) {
  if (!(color in bags)) return 0
  bagCount = 0
  for (c in bags[color]) bagCount += (numBags(c) * bags[color][c]) + bags[color][c]
  return bagCount
}
{
  if ($0 ~ /no other bags/) next
  outside_bag = $1 " " $2
  for (i=5; i<=NF; i+=4) {
    inside_bag = $(i+1) " " $(i+2)
    bags[outside_bag][inside_bag] = $i
  }
}
END {
  print numBags("shiny gold")
}
