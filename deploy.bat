@echo off
rem IMPORTANT: Disk image must be ejected from AppleWin first or you will get a file access error.
rem Set file and disk image names
set source=shape2
set target=SHAPE2
set dskname=GRAPHICS.do
echo Deploying %target% BIN file to %dskname%
echo Delete existing BIN file
java -jar ../AppleCommander-1.3.5.jar -d ../%dskname% %target%
echo Copy BIN file to disk image
java -jar ../AppleCommander-1.3.5.jar -p ../%dskname% %target% B 0x6000 < %source%
echo Launch AppleWin with disk image in Drive A
..\\AppleWin\\Applewin -d1 ..\\%dskname%
