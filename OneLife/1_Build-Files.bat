@echo off
SET NAME=SPP-OneLife Builder
TITLE %NAME%
set mainfolder=%CD%

if not exist "%mainfolder%\Tools" goto extract
goto start

:extract
"%mainfolder%\7za.exe" e -spf Tools.7z.001
goto start

:start
echo mainfolder=%mainfolder% > "%mainfolder%\Tools\MinGW\msys\1.0\mainfolder.txt"
"%mainfolder%\Tools\fart.exe" -- "%mainfolder%\Tools\MinGW\msys\1.0\mainfolder.txt" \ /

:install_OneLife
if exist "%mainfolder%\OneLife\configure" goto install_minorGems
cls
echo Downloading OneLife source files...
echo.
"%mainfolder%\Tools\Git\cmd\git.exe" clone --depth=1 https://github.com/jasonrohrer/OneLife.git
goto install_minorGems

:install_minorGems
if exist "%mainfolder%\minorGems\common.h" goto install_OneLifeData7
cls
echo Downloading OneLife source files...
echo.
"%mainfolder%\Tools\Git\cmd\git.exe" clone --depth=1 https://github.com/jasonrohrer/minorGems.git
goto install_OneLifeData7

:install_OneLifeData7
if exist "%mainfolder%\OneLifeData7\dataVersionNumber.txt" goto update_process
cls
echo Downloading OneLife source files...
echo.
"%mainfolder%\Tools\Git\cmd\git.exe" clone --depth=1 https://github.com/jasonrohrer/OneLifeData7.git
goto update_process

:update_process
cls
echo Downloading latest updates...
echo.
cd "%mainfolder%\OneLife"
"%mainfolder%\Tools\Git\cmd\git.exe" reset --hard
"%mainfolder%\Tools\Git\cmd\git.exe" pull https://github.com/jasonrohrer/OneLife.git
echo.
cd "%mainfolder%\minorGems"
"%mainfolder%\Tools\Git\cmd\git.exe" reset --hard
"%mainfolder%\Tools\Git\cmd\git.exe" pull https://github.com/jasonrohrer/minorGems.git
echo.
cd "%mainfolder%\OneLifeData7"
"%mainfolder%\Tools\Git\cmd\git.exe" reset --hard
"%mainfolder%\Tools\Git\cmd\git.exe" pull https://github.com/jasonrohrer/OneLifeData7.git
echo.
echo G++.exe path changing...
"%mainfolder%\Tools\fart.exe" -- "%mainfolder%\OneLife\build\makeDistributionWindows" g++ $gplusplus_path/g++
"%mainfolder%\Tools\fart.exe" -- "%mainfolder%\OneLife\gameSource\makeRegenerateCachesWindows" g++ $gplusplus_path/g++
echo. 
echo Update done!

(
echo #######################################################
echo # Single Player Project - One Hour One Life installer #
echo # Patreon: https://www.patreon.com/conan513           #
echo # Discord: https://discord.gg/TpxqWWT                 #
echo #                                                     #
echo # This project based on the open source files of      #
echo # One Hour One Life.                                  #
echo #                                                     #
echo # Copyright to Jason Rohrer                           #
echo # https://github.com/jasonrohrer                      #
echo #######################################################
echo.
echo Copy the build command line with "" into the new MINGW32 window to start the build process:
echo.
echo Build command:
echo "%mainfolder%\Tools\build.sh"
echo.
echo Run the 2_Build-Repack.bat file when the build process finished 
echo to create your own repack and can share with your friends.
echo.
) > "%mainfolder%\Tools\command.txt"
start notepad "%mainfolder%\Tools\command.txt"
cd "%mainfolder%\Tools\MinGW\msys\1.0
msys.bat
exit