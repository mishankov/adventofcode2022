import streams, strscans

type
  MoveKind = enum Rock, Paper, Scissors
  Result = enum WinRight, WinLeft, Draw

proc getMoveFromLiteral(literal: string): MoveKind =
  if literal == "A" or literal == "X": return Rock
  if literal == "B" or literal == "Y": return Paper
  if literal == "C" or literal == "Z": return Scissors

proc `>`(moveLeft: MoveKind, moveRight: MoveKind): Result =
  if moveLeft == moveRight: return Draw
  if moveLeft == Rock and moveRight == Scissors: return WinLeft
  if moveLeft == Paper and moveRight == Rock: return WinLeft
  if moveLeft == Scissors and moveRight == Paper: return WinLeft

  return WinRight

proc calculateGameScore(moveLeft: MoveKind, moveRight: MoveKind): int =
  result = 0
  case moveRight:
    of Rock: result += 1
    of Paper: result += 2
    of Scissors: result += 3
  
  case moveLeft > moveRight:
    of WinRight: result += 6
    of Draw: result += 3
    of WinLeft: discard

proc solve*() =
  let data = newFileStream("data/day02.txt")
  defer: data.close()

  var overallSum: int = 0
  while not data.atEnd():
    let line = data.readLine()
    var leftLiteral, righLiteral: string
    if scanf(line, "$w $w", leftLiteral, righLiteral):
      overallSum += calculateGameScore(leftLiteral.getMoveFromLiteral(), righLiteral.getMoveFromLiteral())

  echo "2.1 Answer: ", overallSum
if isMainModule:
  solve()
