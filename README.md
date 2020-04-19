# Apple ][ Programming

Re-learning 6502 assembler using FREE modern tools on Windows.

## Installation
  * NodeJS (for the build task)
  * Visual Studio Code (VSCode)
  * Merlin 32 (cross compiler)
  * AppleWin (Apple ][ emulator for Windows)
  * Create and manage disk images using AppleCommander (requires Java)

### VSCode Setup
  * Install the "Beeb VSC" extension for syntax highlighting
  * See the README file in the "VSCode Extensions" folder for futher instructions
  * Use .vscode/tasks.json to setup your VSCode tasks to build and deploy using NodeJS
    * add your own source files to the "pickString" options
    * make one of them the "default"
  * Ctrl+Shift+P to open Command Palette
  * Select Tasks: Configure Default Build Task and choose "Merlin32 compile"

## Development
  * Make sure that disk-images/MYDISK.do has write permissions.
  * Ctrl+Shift+B to invoke the Default Build Task (above) and select "hello" from the list to:
    * Compile, create a "hello" BIN file and a "hello_Output.txt file with compilation details.
    * Delete existing BIN file from the "MYDISK" disk image.
    * Copy compiled BIN file to the "MYDISK" disk image.
    * Delete the compiled BIN file from your source folder.
    * Run the AppleWin emulator with the "MYDISK" disk image in Drive 1.
  * **IMPORTANT:** Disk image must be ejected from AppleWin first or you will get a file access error.

### Testing
In AppleWin:
  * Type CATALOG to see your files on the "MYDISK" disk.
  * Type "BRUN HELLO" to run.

## Create an autorun disk
  1) Run AppleWin and load the "MYDISK" disk image into Drive 1
  2) Reboot
  3) Type the following (without the comments) which will create an AppleSoft Basic program that runs when the disk is booted:
  ```
  NEW
  10 HOME
  20 PRINT CHR$(4)"BRUN HELLO" (the BIN file)
  30 END
  INIT HELLO (to create an autorun BAS file)
  ```
  4) Eject the disk image from Drive 1.
  5) Build and deploy using the steps in the Development section.

  To make changes to the "MYDISK" disk boot script:
  ```
  LOAD HELLO
  LIST
  20 PRINT "HI DAVE"
  SAVE
  ```

## References
  * https://nodejs.org
  * https://code.visualstudio.com
  * https://github.com/AppleWin/AppleWin
  * http://web.mit.edu/nelhage/Public/otrail/applewin/Intro_To_New_Debugger.htm
  * https://www.codeproject.com/Articles/1200285/Cross-Assembly-for-the-Apple-II-using-MacOS
  * http://applecommander.sourceforge.net/
  * https://www.brutaldeluxe.fr/products/crossdevtools/merlin
  * Syntax Highlighting: https://marketplace.visualstudio.com/items?itemName=simondotm.beeb-vsc
  * https://code.visualstudio.com/docs/editor/variables-reference#_input-variables
  
### Books and Docs
  * https://archive.org/details/Hi-ResGraphicsAndAnimationUsingAssemblyLanguage/mode/2up
  * https://www.apple.asimov.net/documentation/programming/6502assembly

### Apple ][ Disk Images
  * https://www.apple.asimov.net/images/programming/assembler/merlin/MerlinPro%202.43.zip

### Apple ][ Software Manuals
  * https://archive.org/details/MerlinProFullScreenEditor/mode/2up
