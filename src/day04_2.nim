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
      if firstRangeStart <= secondRangeEnd and firstRangeEnd >= secondRangeEnd:
        pairsAmount += 1
        continue

      if secondRangeStart <= firstRangeEnd and secondRangeEnd >= firstRangeEnd:
        pairsAmount += 1

  echo "4.2 Answer: ", pairsAmount


if isMainModule:
  solve()
