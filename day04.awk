#!/usr/bin/awk -f

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
    delete passport
    valid++
    next
  }
}
END {
  print valid
}
