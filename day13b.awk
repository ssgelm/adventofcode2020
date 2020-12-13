#!/usr/bin/awk -f

BEGIN {
  FS=","
}
/,/ {
  p = 1
  for (i=1; i<=NF; i++) {
    if ($i == "x") continue
    # We can assume that the answer will be a multiple of p, so if we add that every iteration it's way faster
    while ((currentTime+i-1) % $i != 0) currentTime += p
    # Now that we have a time that works multiple p by $i so it's taken into account
    p *= $i
  }
}
END {
  print currentTime
}
