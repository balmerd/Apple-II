# Apple ][ Programming

## Installation
  * Visual Studio Code (VSCode)
  * AppleWin (Apple ][ emulator for Windows)
  * Create and manage disk images using either:
    * CiderPress
    * or AppleCommander (requires Java)
  * Merlin 32 (cross compiler)

### VSCode Setup
  * Install the "Beeb VSC" extension for syntax highlighting
  * See the README file in the "VSCode Extensions" folder for futher instructions
  * Create "build.bat" batch file to run Merlin 32:
  ```
  ..\\Merlin32\\Merlin32.exe -V ..\\Merlin32\\Library main#066000.s
  ```

  * Create build task to run "build.bat":
  ```
    {
    "label": "Merlin32 compile",
    "type": "shell",
    "command": "build.bat",
    "problemMatcher": [],
    "group": {
      "kind": "build",
      "isDefault": true
    }
  }
  ```
  * Ctrl+Shift+P to open Command Palette
  * Select Tasks: Configure Default Build Task and choose "Merlin32 compile"

## Development using AppleCommander

Create a source file with a ".s" suffix eg: "main.s"

### Build

Ctrl+Shift+B to compile and produce a "main" BIN file, and a "main_Output.txt file with compilation details.

### Deploy

Edit "mkdisk.bat" to select a disk image name, then run to create a 140KB DOS 3.3 disk image.

After closing AppleWin, run "deploy.bat" to delete any existing BIN file from the disk image, copy the new BIN file, and launch AppleWin with the disk image in Drive A.

In AppleWin:
  * Type CATALOG to see your BIN file
  * Type "BRUN MAIN" to run

## Development using CiderPress

Create a source file with a ".s" suffix and a file preservation attribute of "066000", where "06" is a BIN file and "6000" is the ORG address eg: "main#066000.s"

NOTE: When using include files, only the main .s file needs to have the file preservation attributes.

Ctrl+Shift+B to compile and produce a "main#066000" BIN file, and a "main#066000_Output.txt file with compilation details.

Use CiderPress to create a new blank 140KB DOS 3.3 disk image
  * Select "use file attribute preservation tags" when adding "main#066000" to the disk image to create a BIN file named "MAIN"

Launch AppleWin and put the disk image in Drive 1
  * Click on the Apple logo to reboot the emulator
  * Type CATALOG to see your BIN file
  * Type "BRUN MAIN" to run

## Create an autorun disk
  NOTE: you cannot have the same disk image open in both AppleWin and AppleCider.

  1) Use AppleCider to create a new 140KB DOS 3.3 disk image eg: "Sample.do"
  2) Run AppleWin and load the disk image into Drive A
  3) Reboot
  4) Type the following which will create a Basic program that runs when the disk is booted:
  ```
  NEW
  10 HOME
  20 PRINT CHR$(4)"BRUN MAIN" (the BIN file)
  30 END
  INIT HELLO (to create an autorun BAS file)
  ```
  5) Eject the disk image from Drive A
  6) Open the disk image with AppleCider
  7) Now you can add the BIN file (as above)
  8) Run AppleWin and load the disk image into Drive A
  9) Reboot

  To make changes to the boot script:
  ```
  LOAD HELLO
  LIST
  20 PRINT "HI DAVE"
  SAVE
  ```

## References
  * https://code.visualstudio.com
  * https://github.com/AppleWin/AppleWin
  * http://web.mit.edu/nelhage/Public/otrail/applewin/Intro_To_New_Debugger.htm
  * https://www.codeproject.com/Articles/1200285/Cross-Assembly-for-the-Apple-II-using-MacOS
  * http://applecommander.sourceforge.net/
  * https://a2ciderpress.com/
  * https://a2ciderpress.com/tutorial/index.htm
  * https://www.brutaldeluxe.fr/products/crossdevtools/merlin
  * Syntax Highlighting: https://marketplace.visualstudio.com/items?itemName=simondotm.beeb-vsc
  * https://skilldrick.github.io/easy6502
  
### Books and Docs
  * https://archive.org/details/Hi-ResGraphicsAndAnimationUsingAssemblyLanguage/mode/2up
  * https://www.apple.asimov.net/documentation/programming/6502assembly
