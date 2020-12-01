#!/usr/bin/awk -f

{
  nums[NR]=$0
}
END {
  for (n in nums)
    for (m in nums)
      if (nums[n]+nums[m] == 2020) {
        print nums[n]*nums[m]
        exit
      }
}
