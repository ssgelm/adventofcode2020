#!/usr/local/bin/gawk -f

BEGIN {
  waypoint_x = 10
  waypoint_y = 1
}
{
  action = substr($0, 1, 1)
  count = substr($0, 2, length($0))
  
  switch (action) {
  case "L":
    switch (count) {
    case 90:
      tmp = waypoint_x
      waypoint_x = waypoint_y * -1
      waypoint_y = tmp
      break
    case 180:
      tmp = waypoint_x
      waypoint_x = waypoint_x * -1
      waypoint_y = waypoint_y * -1
      break
    case 270:
      tmp = waypoint_x
      waypoint_x = waypoint_y
      waypoint_y = tmp * -1
      break
    }
    break
  case "R":
    switch (count) {
    case 90:
      tmp = waypoint_x
      waypoint_x = waypoint_y
      waypoint_y = tmp * -1
      break
    case 180:
      waypoint_x = waypoint_x * -1
      waypoint_y = waypoint_y * -1
      break
    case 270:
      tmp = waypoint_x
      waypoint_x = waypoint_y * -1
      waypoint_y = tmp
      break
    }
    break
  case "N":
    waypoint_y += count
    break
  case "E":
    waypoint_x += count
    break
  case "S":
    waypoint_y -= count
    break
  case "W":
    waypoint_x -= count
    break
  case "F":
    x += waypoint_x * count
    y += waypoint_y * count
    break
  }
}
END {
  print (x >= 0 ? x : -x) + (y >= 0 ? y : -y)
}
