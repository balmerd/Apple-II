# Apple ][ Programming

## Installation
  * Visual Studio Code (VSCode)
  * Retro Assembler (requires DotNet Core)
  * AppleWin (Apple ][ emulator for Windows)
  * CiderPress to create and manage disk images

### VSCode
  * Install Retro Assembler extension
  * Assign ALT-B as keyboard shortcut for Retro Assembler : Build
  * In Preferences for Retro Assembler:
    * Set "Path" as fully qualified path pointing to retroassembler.exe

## Development

Create a source file with an ".asm" suffix and a file preservation attribute of "066000", where "06" is a BIN file and "6000" is the ORG address eg: "main#066000.asm", with these directives at the top:
  * .ORG  $6000
  * .CPU  "65C02"
  * .SETTING "OutputFileType", "SBIN"

NOTE: When using include files, only the main asm file needs to have the file preservation attributes.

ALT-B to compile the currently open file and produce a "main#066000.sbin" file containing only the bytecodes.

Use CiderPress to create a new blank DOS 3.3 disk image:
  * Add the "main#066000.sbin" to the disk image as a BRUNnable file called MAIN by selecting "use file attribute preservation tags".

Launch AppleWin and “put” the disk image file in Drive 1.
  * Click on the Apple logo to reboot the emulator
  * Type CATALOG to see your BIN file.
  * Type "BRUN MAIN" to run.

## References
  * https://code.visualstudio.com
  * https://dotnet.microsoft.com/download
  * https://enginedesigns.net/retroassembler
  * https://marketplace.visualstudio.com/items?itemName=EngineDesigns.retroassembler
  * https://a2ciderpress.com/
  * https://a2ciderpress.com/tutorial/index.htm
  * https://github.com/AppleWin/AppleWin
### Books
  * https://archive.org/details/Hi-ResGraphicsAndAnimationUsingAssemblyLanguage/mode/2up

### Not used (yet) but interesting
  * https://www.codeproject.com/Articles/1200285/Cross-Assembly-for-the-Apple-II-using-MacOS
  * http://applecommander.sourceforge.net/