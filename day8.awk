#!/usr/local/bin/gawk -f

{
  inst[NR] = $0
}
END {
  acc = 0
  for (i=1; i<=NR; i++) {
    if (visited[i]) {
      print acc
      exit
    }
    visited[i] = 1
    split(inst[i], current_inst, " ")
    switch (current_inst[1]) {
    case "nop":
      continue
    case "acc":
      acc += current_inst[2]
      continue
    case "jmp":
      prev_i = i
      i += current_inst[2] - 1
    }
  }
}
