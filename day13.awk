#!/usr/bin/awk -f

BEGIN {
  FS=","
}
NR == 1 {
  startTime = $0
}
/,/ {
  currentTime = startTime
  while (!firstBus) {
    for (i=1; i<=NF; i++) {
      if ($i == "x") continue
      if (!(currentTime % $i)) {
        firstBus = $i
        print (currentTime-startTime) * firstBus
        exit
      }
    }
    currentTime++
  }
}
