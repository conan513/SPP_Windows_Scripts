@echo off
SET NAME=SPP-OneLife repack builder
TITLE %NAME%
set mainfolder=%CD%
set repackfolder=!Repack

mkdir "%mainfolder%\%repackfolder%\OneLife_game"
mkdir "%mainfolder%\%repackfolder%\OneLife_server"
mkdir "%mainfolder%\%repackfolder%\OneLife_server\categories"
mkdir "%mainfolder%\%repackfolder%\OneLife_server\objects"
mkdir "%mainfolder%\%repackfolder%\OneLife_server\transitions"
mkdir "%mainfolder%\%repackfolder%\OneLife_server\tutorialMaps"
xcopy /E /Y "%mainfolder%\OneLife\build\windows\OneLife_SPP" "%mainfolder%\%repackfolder%\OneLife_game"
xcopy /E /Y "%mainfolder%\OneLife\server" "%mainfolder%\%repackfolder%\OneLife_server"

copy /Y "%mainfolder%\OneLife\build\windows\OneLife_SPP\dataVersionNumber.txt" "%mainfolder%\%repackfolder%\OneLife_server"
xcopy /E /Y "%mainfolder%\OneLife\build\windows\OneLife_SPP\categories" "%mainfolder%\%repackfolder%\OneLife_server\categories"
xcopy /E /Y "%mainfolder%\OneLife\build\windows\OneLife_SPP\objects" "%mainfolder%\%repackfolder%\OneLife_server\objects"
xcopy /E /Y "%mainfolder%\OneLife\build\windows\OneLife_SPP\transitions" "%mainfolder%\%repackfolder%\OneLife_server\transitions"
copy /Y "%mainfolder%\OneLifeData7\tutorialMaps\tutorial1.txt" "%mainfolder%\%repackfolder%\OneLife_server\tutorialMaps"

echo 1 > "%mainfolder%\%repackfolder%\OneLife_game\settings\useCustomServer.ini"
echo 1 > "%mainfolder%\%repackfolder%\OneLife_game\settings\borderless.ini"
echo 0 > "%mainfolder%\%repackfolder%\OneLife_game\settings\useLifeTokenServer.ini"
echo 0 > "%mainfolder%\%repackfolder%\OneLife_server\settings\useLifeTokenServer.ini"
echo 0 > "%mainfolder%\%repackfolder%\OneLife_server\settings\requireTicketServerCheck.ini"
