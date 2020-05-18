#!/usr/bin/env node

import { exec } from'child_process'
import path from 'path'
const currentDir = path.resolve(process.cwd());

console.log(process.cwd())

const [, , ...args] = process.argv

console.log(args)

if (args.length > 1 || args.length < 1){
  console.log('xrengine takes one argument: start dev test lint build')
}
else {
console.log('xrengine is starting')
console.log(currentDir + '/node_modules/xrengine/')
const cmd = exec('npm run dev', { cwd: currentDir + '/node_modules/xrengine/' },
(error, stdout, stderr) => {
    if (error) {
      console.error(`exec error: ${error}`);
      return;
    }
    console.log(`stdout: ${stdout}`);
    console.error(`stderr: ${stderr}`);
  });
  

  cmd.stdout.on('data', (data) => {
    console.log(`stdout: ${data}`);
  });
  
  cmd.stderr.on('data', (data) => {
    console.error(`stderr: ${data}`);
  });
  
  cmd.on('close', (code) => {
    console.log(`child process exited with code ${code}`);
  });
  
}