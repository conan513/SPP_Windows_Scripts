@echo off
SET NAME=SPP-OneLife repack builder
TITLE %NAME%
set mainfolder=%CD%
set source_drive=d
set source_game=d:\Source\spp-onelife-game
set source_modules=d:\Source\spp-onelife-modules
set source_server=d:\Source\spp-onelife-server
set repackfolder=!Repack_Github
set version_file=d:\Source\spp-onelife-modules\dataVersionNumber.txt

rmdir "%mainfolder%\%repackfolder%" /S /Q
mkdir "%mainfolder%\%repackfolder%\OneLife_game"
mkdir "%mainfolder%\%repackfolder%\OneLife_server"
mkdir "%mainfolder%\%repackfolder%\OneLife_server\categories"
mkdir "%mainfolder%\%repackfolder%\OneLife_server\objects"
mkdir "%mainfolder%\%repackfolder%\OneLife_server\transitions"
mkdir "%mainfolder%\%repackfolder%\OneLife_server\tutorialMaps"
xcopy /E /Y "%mainfolder%\OneLife\build\windows\OneLife_SPP" "%mainfolder%\%repackfolder%\OneLife_game"
xcopy /E /Y "%mainfolder%\OneLife\server" "%mainfolder%\%repackfolder%\OneLife_server"

echo 1 > "%mainfolder%\%repackfolder%\OneLife_game\settings\useCustomServer.ini"
echo 1 > "%mainfolder%\%repackfolder%\OneLife_game\settings\borderless.ini"
echo 0 > "%mainfolder%\%repackfolder%\OneLife_game\settings\useLifeTokenServer.ini"
echo 0 > "%mainfolder%\%repackfolder%\OneLife_server\settings\useLifeTokenServer.ini"
echo 0 > "%mainfolder%\%repackfolder%\OneLife_server\settings\requireTicketServerCheck.ini"

xcopy /E /Y "%mainfolder%\%repackfolder%\OneLife_game" "%source_game%"
xcopy /E /Y "%mainfolder%\%repackfolder%\OneLife_server\settings" "%source_server%\settings"
xcopy /E /Y "%mainfolder%\%repackfolder%\OneLife_server\tutorialMaps" "%source_server%\tutorialMaps"
xcopy /E /Y "%mainfolder%\%repackfolder%\OneLife_server\webViewer" "%source_server%\webViewer"
copy /Y "%mainfolder%\%repackfolder%\OneLife_server\OneLifeServer.exe" "%source_server%"
copy /Y "%mainfolder%\%repackfolder%\OneLife_server\*.txt" "%source_server%"

rmdir "%source_game%\categories" /S /Q
rmdir "%source_game%\objects" /S /Q
rmdir "%source_game%\transitions" /S /Q

copy /Y "%mainfolder%\OneLife\build\windows\OneLife_SPP\dataVersionNumber.txt" "%source_modules%"
xcopy /E /Y "%mainfolder%\OneLife\build\windows\OneLife_SPP\categories" "%source_modules%\categories"
xcopy /E /Y "%mainfolder%\OneLife\build\windows\OneLife_SPP\objects" "%source_modules%\objects"
xcopy /E /Y "%mainfolder%\OneLife\build\windows\OneLife_SPP\transitions" "%source_modules%\transitions"
copy /Y "%mainfolder%\OneLifeData7\tutorialMaps\tutorial1.txt" "%source_server%\tutorialMaps"

del "%source_game%\dataVersionNumber.txt"
del "%source_server%\dataVersionNumber.txt"

set /p version=<%version_file%
%source_drive%:

cd %source_game%
git add .
git commit -m "Game v%version%"
git push https://USER:PASSWORK@github.com/conan513/spp-onelife-game.git

cd %source_modules%
git add .
git commit -m "Modules v%version%"
git push https://USER:PASSWORK@github.com/conan513/spp-onelife-modules.git

cd %source_server%
git add .
git commit -m "Server v%version%"
git push https://USER:PASSWORK@github.com/conan513/spp-onelife-server.git


pause