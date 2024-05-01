@echo off
set "fullPath=%~dp0"
set "pathOnly=%fullPath:~0,-1%"
echo %pathOnly%
cd %pathonly%
NSudoLG.exe -U:T -P:E ISOMaker.bat
exit