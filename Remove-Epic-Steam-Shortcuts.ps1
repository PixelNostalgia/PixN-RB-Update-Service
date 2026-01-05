Get-ChildItem ..\..\roms\steam | Where-object {$_.LastWriteTime -like "08/11/2025 *"} | Remove-Item
Get-ChildItem ..\..\roms\epic | Where-object {$_.LastWriteTime -like "08/11/2025 *"} | Remove-Item