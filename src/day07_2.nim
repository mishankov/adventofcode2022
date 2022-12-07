import streams, strutils, strscans

type
  File = object
    name: string
    size: int

  Folder = object
    name: string
    folders: seq[Folder]
    files: seq[File]
    size: int

  LineType = enum CommandCd, CommandLs, OutputFile, OutputFolder


proc addFile(folder: var Folder, file: File, directory: seq[string]) =
  if directory.len() == 1:
    folder.files.add(file)
    return

  for i in countup(0, folder.folders.len() - 1):
    if folder.folders[i].name == directory[1]:
      folder.folders[i].addFile(file, directory[1..^1])
      return

  folder.folders.add(Folder(name: directory[1]))
  folder.folders[^1].addFile(file, directory[1..^1])

proc calculateSize(rootFolder: Folder): int =
  for file in rootFolder.files:
    result += file.size

  for folder in rootFolder.folders:
    result += folder.calculateSize()

proc folderSizes(rootFolder: Folder, list: var seq[Folder]) =
  list.add(Folder(name: rootFolder.name, size: rootFolder.calculateSize()))
  for folder in rootFolder.folders: folder.folderSizes(list)


proc getLineType(line: string): LineType =
  if line.startsWith("$ cd"): return CommandCd
  if line.startsWith("$ ls"): return CommandLs
  if line.startsWith("dir"): return OutputFolder
  return OutputFile

proc solve*() =
  let data = newFileStream("data/day07.txt")
  defer: data.close()

  var pwd = @["/"]
  var fileSystem = Folder(name: "/")
  while not data.atEnd():
    let line = data.readLine()

    case line.getLineType():
      of CommandCd:
        let destination = line[5..^1]
        if destination == "/": pwd = @["/"]
        elif destination == "..": pwd = pwd[0..^2]
        else: pwd.add(destination)

      of OutputFile:
        var fileName: string
        var fileSize: int
        if scanf(line, "$i $w", fileSize, fileName):
          fileSystem.addFile(File(name: fileName, size: fileSize), pwd)

      of CommandLs: discard
      of OutputFolder: discard

  var foldersList: seq[Folder]
  fileSystem.folderSizes(foldersList)

  const totalSpace = 70_000_000
  const requiredFreeSpace = 30_000_000
  let spaceToFree = fileSystem.calculateSize() - (totalSpace - requiredFreeSpace)

  var currentMinimumSize = foldersList[0].size
  for folder in foldersList:
    if folder.size >= spaceToFree and folder.size <
        currentMinimumSize: currentMinimumSize = folder.size

  echo "7.2 Answer: ", currentMinimumSize

if isMainModule:
  solve()
