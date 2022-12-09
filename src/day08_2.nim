import streams, strutils

type
  Forest = object
    trees: seq[seq[int]]

proc calculateTreeScore(forest: Forest, row: int, column: int): int =
  result = 1

  # Edges
  if row == 0 or column == 0: return 0
  if row == forest.trees.len() - 1 or column == forest.trees[0].len() - 1: return 0

  # Up
  for i in countdown(row - 1, 0):
    if forest.trees[row][column] <= forest.trees[i][column]:
      result *= row - i
      break
    elif i == 0: result *= row

  # Down
  for i in countup(row + 1, forest.trees.len() - 1):
    if forest.trees[row][column] <= forest.trees[i][column]:
      result *= i - row
      break
    elif i == forest.trees.len() - 1: result *= i - row

  # Left
  for j in countdown(column - 1, 0):
    if forest.trees[row][column] <= forest.trees[row][j]:
      result *= column - j
      break
    elif j == 0: result *= column

  # Right
  for j in countup(column + 1, forest.trees[0].len() - 1):
    if forest.trees[row][column] <= forest.trees[row][j]:
      result *= j - column
      break
    elif j == forest.trees[0].len() - 1: result *= j - column


proc solve*() =
  let data = newFileStream("data/day08.txt")
  defer: data.close()

  var forest = Forest(trees: @[])
  var maxTreeScore = 0
  while not data.atEnd():
    let line = data.readLine()

    forest.trees.add(@[])
    for height in line:
      forest.trees[^1].add(parseInt($height))

  for row in countup(0, forest.trees.len() - 1):
    for column in countup(0, forest.trees[0].len() - 1):
      let treeScore = forest.calculateTreeScore(row, column)
      if treeScore > maxTreeScore: maxTreeScore = treeScore

  echo "8.2 Answer: ", maxTreeScore

if isMainModule:
  solve()
