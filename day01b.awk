#!/usr/bin/awk -f

{
  nums[NR]=$0
}
END {
  for (n in nums)
    for (m in nums)
      for (o in nums)
        if (nums[n]+nums[m]+nums[o] == 2020) {
          print nums[n]*nums[m]*nums[o]
          exit
        }
}
