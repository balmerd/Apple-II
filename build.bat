@echo off
set source=shape2
echo Compile %source%.s with Merlin 32
..\\Merlin32\\Merlin32.exe -V ..\\Merlin32\\Library %source%.s
