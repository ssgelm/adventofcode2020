#!/usr/local/bin/gawk -f

# For the logic of this one I had to cheat and look at reddit:
#  https://www.reddit.com/r/adventofcode/comments/ka8z8x/2020_day_10_solutions/gfcqavt/

function getConfigurations(streak) {
  return (streak * streak + streak + 2) / 2
}
{
  adapters[NR]=$0
}
END {
  len = asort(adapters, sortedAdapters)
  paths = 1
  for (i=1; i<=len; i++) {
    switch (sortedAdapters[i] - sortedAdapters[i-1]) {
    case 1:
      oneStreak++
      break
    case 3:
      if (oneStreak > 1) paths *= getConfigurations(oneStreak - 1)
      oneStreak = 0
      break
    }
  }
  if (oneStreak > 1) paths *= getConfigurations(oneStreak - 1)
  print paths
}
