import streams, strscans

proc solve* =
  let data = newFileStream("data/day04.txt")
  defer: data.close()

  var pairsAmount = 0
  while not data.atEnd():
    let line = data.readLine()

    var firstRangeStart, firstRangeEnd, secondRangeStart, secondRangeEnd: int

    if scanf(line, "$i-$i,$i-$i", firstRangeStart, firstRangeEnd,
        secondRangeStart, secondRangeEnd):
      if firstRangeStart <= secondRangeStart and firstRangeEnd >= secondRangeEnd:
        pairsAmount += 1
        continue

      if firstRangeStart >= secondRangeStart and firstRangeEnd <= secondRangeEnd:
        pairsAmount += 1
        continue

  echo "4.1 Answer: ", pairsAmount


if isMainModule:
  solve()
