#!/usr/bin/awk -f

{
  password = $3
  letter = substr($2, 1, 1)
  split($1, nums, "-")
  count = gsub(letter, "", password)
  if (count >= nums[1] && count <= nums[2]) correct++
}
END {
  print correct
}
