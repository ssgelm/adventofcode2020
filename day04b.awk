#!/usr/bin/awk -f

function checkRange(num, min, max) {
  num += 0
  if (num >= min && num <= max) return 1
  return 0
}
function checkHeight(height) {
  unit = substr(height, length(height)-1, 2)
  num = substr(height, 1, length(height)-2)
  if (unit == "in") return checkRange(num, 59, 76)
  if (unit == "cm") return checkRange(num, 150, 193)
  return 0
}
function checkColor(color) {
  return color ~ /^#[a-f0-9]{6}$/
}
function checkEye(eye) {
  return eye ~ /^(amb|blu|brn|gry|grn|hzl|oth)$/
}
function checkPID(pid) {
  return pid ~ /^[0-9]{9}$/
}

BEGIN {
  req_fields[0] = "byr"
  req_fields[1] = "iyr"
  req_fields[2] = "eyr"
  req_fields[3] = "hgt"
  req_fields[4] = "hcl"
  req_fields[5] = "ecl"
  req_fields[6] = "pid"
}
{
  for (i=1; i<=NF; i++) {
    split($i,ppfield,":")
    passport[ppfield[1]] = ppfield[2]
    delete ppfield
  }

  if ($0 == "") {
    for (field in req_fields) {
      cur_field = req_fields[field]
      if (!passport[cur_field]) {
        delete passport
        next
      }
    }
    
    if (checkRange(passport["byr"], 1920, 2002) &&
        checkRange(passport["iyr"], 2010, 2020) &&
        checkRange(passport["eyr"], 2020, 2030) &&
        checkHeight(passport["hgt"]) &&
        checkColor(passport["hcl"]) &&
        checkEye(passport["ecl"]) &&
        checkPID(passport["pid"])) {
      valid++
    }
    delete passport
  }
}
END {
  print valid
}
