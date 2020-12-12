#!/usr/local/bin/gawk -f

function allowsColor(color, allowedColor) {
  if (color == allowedColor) return 1
  if (!(color in bags)) return 0
  for (c in bags[color])
    if (allowsColor(c, allowedColor)) return 1
  return 0
}
{
  if ($0 ~ /no other bags/) next
  outside_bag = $1 " " $2
  for (i=6; i<=NF; i+=4)
    bags[outside_bag][$i " " $(i+1)] = 1
}
END {
  for (i in bags) {
    if (i == "shiny gold") continue
    if (allowsColor(i, "shiny gold")) total++
  }
  print total
}
