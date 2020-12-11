#!/usr/local/bin/gawk -f

function deepClone(arr, newArr) {
  for (i=1; i<=NR; i++)
    for (j=1; j<=NF; j++) newArr[i][j] = arr[i][j]
}
function deepEqual(arr1, arr2) {
  for (i=1; i<=NR; i++)
    for (j=1; j<=NF; j++)
      if (arr1[i][j] != arr2[i][j]) return 0
  return 1
}
function nextVisible(x, y, next_x, next_y) {
  while (1) {
    x += next_x
    y += next_y
    if (x < 1 || y < 1 || x > NF || y > NR) return "."
    switch (seats[y][x]) {
    case "#":
      return "#"
      break
    case "L":
      return "L"
      break
    }
  }
}
BEGIN {
  FS=""
}
{
  for (i=1; i<=NF; i++) seats[NR][i]=$i
}
END {
  while (!noDiff) {
    occupied = 0
    for (i=1; i<=NR; i++) {
      for (j=1; j<=NF; j++) {
        switch (seats[i][j]) {
        case ".":
          newSeats[i][j] = "."
          break
        case "L":
          if (nextVisible(j, i, -1, -1) != "#" &&
              nextVisible(j, i,  0, -1) != "#" &&
              nextVisible(j, i,  1, -1) != "#" &&
              nextVisible(j, i, -1,  0) != "#" &&
              nextVisible(j, i,  1,  0) != "#" &&
              nextVisible(j, i, -1,  1) != "#" &&
              nextVisible(j, i,  0,  1) != "#" &&
              nextVisible(j, i,  1,  1) != "#") {
            occupied++
            newSeats[i][j] = "#"
          } else {
            newSeats[i][j] = "L"
          }
          break
        case "#":
          adjOcc = 0
          if (nextVisible(j, i, -1, -1) == "#") adjOcc++
          if (nextVisible(j, i,  0, -1) == "#") adjOcc++
          if (nextVisible(j, i,  1, -1) == "#") adjOcc++
          if (nextVisible(j, i, -1,  0) == "#") adjOcc++
          if (nextVisible(j, i,  1,  0) == "#") adjOcc++
          if (nextVisible(j, i, -1,  1) == "#") adjOcc++
          if (nextVisible(j, i,  0,  1) == "#") adjOcc++
          if (nextVisible(j, i,  1,  1) == "#") adjOcc++
          if (adjOcc >= 5) {
            newSeats[i][j] = "L"
          } else {
            occupied++
            newSeats[i][j] = "#"
          }
          break
        }
      }
    }
    if (deepEqual(seats, newSeats)) {
      noDiff = 1
    } else {
      deepClone(newSeats, seats)
    }
  }
  print occupied
}
