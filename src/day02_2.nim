import streams, strscans

type
  MoveKind = enum Rock, Paper, Scissors
  Result = enum WinRight, WinLeft, Draw

proc getMoveFromLiteral(literal: string): MoveKind =
  if literal == "A": return Rock
  if literal == "B": return Paper
  if literal == "C": return Scissors

proc getResultFromLiteral(literal: string): Result =
  if literal == "X": return WinLeft
  if literal == "Y": return Draw
  if literal == "Z": return WinRight

proc calculateGameScore(moveLeft: MoveKind, gameResult: Result): int =
  result = 0

  case gameResult:
    of WinRight:
      result += 6
      case moveLeft:
        of Rock: result += 2
        of Paper: result += 3
        of Scissors: result += 1
    of Draw:
      result += 3
      case moveLeft:
        of Rock: result += 1
        of Paper: result += 2
        of Scissors: result += 3
    of WinLeft:
      case moveLeft:
        of Rock: result += 3
        of Paper: result += 1
        of Scissors: result += 2

proc solve*() =
  let data = newFileStream("data/day02.txt")
  defer: data.close()

  var overallSum: int = 0
  while not data.atEnd():
    let line = data.readLine()
    var leftLiteral, righLiteral: string
    if scanf(line, "$w $w", leftLiteral, righLiteral):
      overallSum += calculateGameScore(leftLiteral.getMoveFromLiteral(),
          righLiteral.getResultFromLiteral())

  echo "2.2 Answer: ", overallSum
if isMainModule:
  solve()
