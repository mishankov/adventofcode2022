import streams

proc itemPriority(item: char): int =
  if int(item) in 97..122:
    return int(item) - 96
  if int(item) in 65..90:
    return int(item) - 38

proc solve* =
  let data = newFileStream("data/day03.txt")
  defer: data.close()

  var sumPriority: int = 0
  while not data.atEnd():
    let firstLine = data.readLine()
    let secondLine = data.readLine()
    let thirdLine = data.readLine()

    for item in firstLine:
      if item in secondLine and item in thirdLine:
        sumPriority += itemPriority(item)
        break


  echo "3.2 Answer: ", sumPriority


if isMainModule:
  solve()
