@echo off
rem disk image must be ejected from AppleWin first
echo Delete existing BIN file
java -jar ../AppleCommander-1.3.5.jar -d ../GRAPHICS.do KBD
echo Copy BIN file to GRAPHICS.do
java -jar ../AppleCommander-1.3.5.jar -p ../GRAPHICS.do KBD B 0x6000 < kbd
echo Launch AppleWin with disk image in Drive A
..\\AppleWin\\Applewin -d1 ..\\GRAPHICS.do
