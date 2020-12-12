#!/usr/local/bin/gawk -f

function testInst(    acc, prev_i, visited, current_inst, i) {
  for (i=1; i<=NR; i++) {
    if (visited[i]) {
      return 0
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
  print acc
  exit
}
{
  inst[NR] = $0
}
END {
  for (iter=1; iter<=NR; iter++) {
    split(inst[iter], current_inst, " ")
    switch (current_inst[1]) {
    case "nop":
      gsub("nop", "jmp", inst[iter])
      testInst()
      gsub("jmp", "nop", inst[iter])
      break
    case "jmp":
      gsub("jmp", "nop", inst[iter])
      testInst()
      gsub("nop", "jmp", inst[iter])
      break
    }
  }
}
