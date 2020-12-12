#!/usr/local/bin/gawk -f

NF {
  split($0,answers,"")
  for (ans in answers) trues[answers[ans]]++
  delete answers
}
/^$/ {
  for (n in trues) count++
  delete trues
}
END {
  print count
}
