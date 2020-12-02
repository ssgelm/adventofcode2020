#!/usr/bin/gawk -f

{
  split($3, password, "")
  letter = substr($2, 1, 1)
  split($1, nums, "-")
  if (xor(password[nums[1]] == letter, password[nums[2]] == letter)) correct++
}
END {
  print correct
}
