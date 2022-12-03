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
    let line = data.readLine()

    let firstHalf = line[0 ..< int(line.len / 2)]
    let secondHalf = line[int(line.len/2) .. ^1]
    var countedItems: seq[char] = @[]

    for item in firstHalf:
      if item in secondHalf and not (item in countedItems):
        countedItems.add(item)
        sumPriority += itemPriority(item)

  echo "3.1 Answer: ", sumPriority


if isMainModule:
  solve()
