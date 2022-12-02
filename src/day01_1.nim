import streams
import strutils

proc solve*() =
  let data = newFileStream("data/day01.txt")
  defer: data.close()

  var currentAmount = 0
  var maxAmount = 0
  while not data.atEnd():
    var line = data.readLine()
    if line == "": 
      if currentAmount > maxAmount:
        maxAmount = currentAmount

      currentAmount = 0
      continue
    
    currentAmount += parseInt(line)

  echo "1.1 Answer: ", maxAmount

if isMainModule:
  solve()
