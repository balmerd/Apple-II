@echo off
rem usage: "compile test"
echo Compile %1.s with Merlin 32
..\\Merlin32\\Merlin32.exe -V ..\\Merlin32\\Library %1.s