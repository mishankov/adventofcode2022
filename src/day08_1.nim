import streams, strutils

type
  Forest = object
    trees: seq[seq[int]]

proc treeIsVisible(forest: Forest, row: int, column: int): int =
  # Edges
  if row == 0 or column == 0: return 1
  if row == forest.trees.len() - 1 or column == forest.trees[0].len() - 1: return 1

  # Up
  for i in countdown(row - 1, 0):
    if forest.trees[row][column] <= forest.trees[i][column]: break
    elif i == 0: return 1

  # Down
  for i in countup(row + 1, forest.trees.len() - 1):
    if forest.trees[row][column] <= forest.trees[i][column]: break
    elif i == forest.trees.len() - 1: return 1

  # Left
  for j in countdown(column - 1, 0):
    if forest.trees[row][column] <= forest.trees[row][j]: break
    elif j == 0: return 1

  # Right
  for j in countup(column + 1, forest.trees[0].len() - 1):
    if forest.trees[row][column] <= forest.trees[row][j]: break
    elif j == forest.trees[0].len() - 1: return 1

  return 0


proc solve*() =
  let data = newFileStream("data/day08.txt")
  defer: data.close()

  var forest = Forest(trees: @[])
  var visibleTreesAmount = 0
  while not data.atEnd():
    let line = data.readLine()

    forest.trees.add(@[])
    for height in line:
      forest.trees[^1].add(parseInt($height))

  for row in countup(0, forest.trees.len() - 1):
    # echo ""
    for column in countup(0, forest.trees[0].len() - 1):
      # write(stdout, $forest.treeIsVisible(row, column) & " ")
      visibleTreesAmount += forest.treeIsVisible(row, column)

  echo "8.1 Answer: ", visibleTreesAmount

if isMainModule:
  solve()
