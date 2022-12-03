import streams
import strutils

proc updateValues(currentAmount: var int, topFirst: var int, topSecond: var int,
    topThird: var int) =
  if currentAmount > topFirst:
    topThird = topSecond
    topSecond = topFirst
    topFirst = currentAmount
  elif currentAmount > topSecond:
    topThird = topSecond
    topSecond = currentAmount
  elif currentAmount > topThird:
    topThird = currentAmount

proc solve*() =
  let data = newFileStream("data/day01.txt")
  defer: data.close()

  var currentAmount, topFirst, topSecond, topThird = 0
  while not data.atEnd():
    var line = data.readLine()
    if line == "":
      updateValues(currentAmount, topFirst, topSecond, topThird)
      currentAmount = 0
      continue

    currentAmount += parseInt(line)

  updateValues(currentAmount, topFirst, topSecond, topThird)

  echo "1.2 Answer: ", topFirst + topSecond + topThird

if isMainModule:
  solve()
