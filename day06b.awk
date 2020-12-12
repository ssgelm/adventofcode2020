#!/usr/local/bin/gawk -f

/^$/ {
  for (n in trues) if (trues[n] == people) count++
  delete trues
  people = 0
}
NF {
  split($0,answers,"")
  for (ans in answers) trues[answers[ans]]++
  delete answers
  people++
}
END {
  print count
}
