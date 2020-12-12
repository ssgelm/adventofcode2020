#!/usr/local/bin/gawk -f

function findNum(nums, count) {
  min = 0
  max = count - 1

  for (num in nums) {
    midpoint = min + ((max - min + 1) / 2)
    if (nums[num] == "F" || nums[num] == "L") max = midpoint - 1
    if (nums[num] == "B" || nums[num] == "R") min = midpoint
  }
  return min
}
BEGIN {
  PROCINFO["sorted_in"] = "@ind_num_asc"
}
{
  split(substr($0,1,7),row,"")
  split(substr($0,8,3),col,"")
  seatID = findNum(row, 128) * 8 + findNum(col, 8)
  if (seatID > highest) highest = seatID
}
END {
  print highest
}
