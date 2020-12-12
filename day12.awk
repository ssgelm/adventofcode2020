#!/usr/local/bin/gawk -f

{
  action = substr($0, 1, 1)
  count = substr($0, 2, length($0))
  
  if (action == "F") {
    switch (facing) {
    case 0:
      action = "E"
      break
    case 90:
      action = "N"
      break
    case 180:
      action = "W"
      break
    case 270:
      action = "S"
      break
    }
  }

  switch (action) {
  case "L":
    facing += count
    facing %= 360
    break
  case "R":
    facing -= count
    facing %= 360
    if (facing < 0) facing += 360
    break
  case "N":
    y += count
    break
  case "E":
    x += count
    break
  case "S":
    y -= count
    break
  case "W":
    x -= count
    break
  }
}
END {
  print (x >= 0 ? x : -x) + (y >= 0 ? y : -y)
}
