@echo off
rem IMPORTANT: Disk image must be ejected from AppleWin first or you will get a file access error.
rem Set disk image name
set dskname=BLANK.do
echo Create %dskname% disk image
java -jar ../AppleCommander-1.3.5.jar -dos140 ../%dskname%
