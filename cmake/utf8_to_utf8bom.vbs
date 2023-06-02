' https://stackoverflow.com/a/65036336/3049315
Dim inFile
Dim outFile

inFile = WScript.Arguments.Item(0)
outFile = WScript.Arguments.Item(1)

Dim file
Dim finalFile
Set file = CreateObject("Scripting.FileSystemObject")
Set finalFile = file.CreateTextFile(outFile)

'Add BOM
finalFile.Write Chr(239)
finalFile.Write Chr(187)
finalFile.Write Chr(191)

'transfer text from inFile to outFile:
Dim tmpFile
Set tmpFile = file.OpenTextFile(inFile, 1)
finalFile.Write tmpFile.ReadAll
finalFile.Close
tmpFile.Close
file.DeleteFile inFile