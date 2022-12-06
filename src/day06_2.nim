import streams

proc allCharsAreUnique(s: string): bool =
  for i in countup(0, s.len() - 1):
    if i == 0 and s[0] in s[1..^1]: return false
    elif i == s.len() - 1 and s[s.len() - 1] in s[0..^2]: return false
    elif s[i] in s[0..i - 1] or s[i] in s[i + 1..^1]: return false

  return true

proc solve*() =
  let data = newFileStream("data/day06.txt")
  defer: data.close()

  const windowLength = 13
  var line = data.readLine()

  for left in countup(0, line.len() - 1 - windowLength):
    let right = left + windowLength
    if line[left..right].allCharsAreUnique():
      echo "6.2 Answer: ", right + 1
      break

if isMainModule:
  solve()
