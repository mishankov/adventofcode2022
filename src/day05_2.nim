import streams, strscans, strutils

const crateStringLength = 4

proc parseCrates(crates: var seq[seq[char]], line: string) =
  var position = 0
  while position + crateStringLength - 1 <= line.len():
    let potentialCrate = line[position .. min(position + crateStringLength - 1,
        line.len() - 1)]

    let stackNumber = int(position / crateStringLength)

    if stackNumber > crates.len() - 1:
      crates.add(@[])

    if potentialCrate[0] == "["[0]:
      var crate: string

      if scanf(potentialCrate.strip(), "[$w]", crate):
        if crate != "_":
          crates[stackNumber].add(crate)

    position += crateStringLength

proc solve* =
  let data = newFileStream("data/day05.txt")
  defer: data.close()

  var topCrates: string
  var crates: seq[seq[char]]
  while not data.atEnd():
    var line = data.readLine()

    if line.startsWith("[") or line.startsWith(" ") and not line.startsWith(" 1"):
      parseCrates(crates, line)
    elif line.startsWith("m"):
      var amount, source, destination: int
      if scanf(line, "move $i from $i to $i", amount, source, destination):
        var cratesToMove = crates[source - 1][0..amount - 1]
        crates[destination - 1] = cratesToMove & crates[destination - 1]
        crates[source - 1] = crates[source - 1][amount..^1]

  for crate in crates:
    topCrates &= crate[0]
  echo "5.1 Answer: ", topCrates


if isMainModule:
  solve()
