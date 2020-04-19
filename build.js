/**
 * Build and Deploy a Merlin32 assembler program.
 * 
 * Compiles an assembler source file eg: "test.s" to a BIN file "test", 
 * renames the BIN file as "TEST" because the Apple ][ requires uppercase file names, 
 * and deploys the BIN file to a disk image using AppleCommander.
 * 
 * Called by VSCode default build task (.vscode/tasks.json).
 * 
 * IMPORTANT: Disk image must be ejected from AppleWin first or you will get a file access error.
 */
const fs = require('fs')
const util = require('util')
const unlink = util.promisify(fs.unlink)
const rename = util.promisify(fs.rename)
const { exec } = require("child_process")

const build = async () => {
  try {
    const args = process.argv.slice(2)
    const fileName = args[0]
    let diskImageName = 'MYDISK'
    let diskImageFileName = `disk-images\\${diskImageName}.do`
    
    const sourceFileName = `${fileName}.s`
    const binFileName = fileName.toUpperCase()
    const compileCmd = `..\\Merlin32\\Merlin32.exe -V ..\\Merlin32\\Library ${sourceFileName}`
    const deleteBinFileCmd = `java -jar ..\\AppleCommander-1.3.5.jar -d ${diskImageFileName} ${binFileName}`
    const copyBinFileCmd = `java -jar ..\\AppleCommander-1.3.5.jar -p ${diskImageFileName} ${binFileName} B 0x6000 < ${fileName}`
    const runEmulatorCmd = `..\\AppleWin\\Applewin -d1 ${diskImageFileName}`

    console.log(`Compile ${sourceFileName} and Deploy to ${diskImageName} disk image using NodeJS`)
    
    console.log(`Compile ${sourceFileName}`)
    // console.log(compileCmd)
    await execShellCommand(compileCmd)
    
    try {
      console.log(`Delete existing BIN file from ${diskImageName} disk image`)
      // console.log(deleteBinFileCmd)
      await execShellCommand(deleteBinFileCmd)
    } catch (err) {
      if (typeof err === 'string') {
        if (err.includes('No match.')) {
          // ignore not found errors
        } else {
          throw err
        }
      } else {
        throw err
      }
    }
    
    console.log(`Copy compiled BIN file to ${diskImageName} disk image`)
    // console.log(copyBinFileCmd)
    await execShellCommand(copyBinFileCmd)
    
    console.log(`DELETE compiled BIN file and build artifacts from your source folder`)
    fs.unlinkSync(fileName)
    fs.unlinkSync("_FileInformation.txt")

    console.log(`Run emulator with ${diskImageName} disk image in Drive 1`)
    console.log(runEmulatorCmd)
    await execShellCommand(runEmulatorCmd)
  } catch (err) {
    console.error('caught', err)
  }
}

const execShellCommand = (cmd) => {
  return new Promise((resolve, reject) => {
    exec(cmd, (error, stdout, stderr) => {
      if (error) {
        // console.error('error', error)
        reject(error)
      }
      if (stderr) {
        // console.error('stderr', stderr)
        reject(stderr)
      }
      resolve();
    });
  });
}

build()