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
          if (seats[i-1][j-1] != "#" &&
              seats[i-1][j]   != "#" &&
              seats[i-1][j+1] != "#" &&
              seats[i][j-1]   != "#" &&
              seats[i][j+1]   != "#" &&
              seats[i+1][j-1] != "#" &&
              seats[i+1][j]   != "#" &&
              seats[i+1][j+1] != "#") {
            occupied++
            newSeats[i][j] = "#"
          } else {
            newSeats[i][j] = "L"
          }
          break
        case "#":
          adjOcc = 0
          if (seats[i-1][j-1] == "#") adjOcc++
          if (seats[i-1][j]   == "#") adjOcc++
          if (seats[i-1][j+1] == "#") adjOcc++
          if (seats[i][j-1]   == "#") adjOcc++
          if (seats[i][j+1]   == "#") adjOcc++
          if (seats[i+1][j-1] == "#") adjOcc++
          if (seats[i+1][j]   == "#") adjOcc++
          if (seats[i+1][j+1] == "#") adjOcc++
          if (adjOcc >= 4) {
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
