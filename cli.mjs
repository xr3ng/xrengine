#!/usr/bin/env node
import { exec } from'child_process'
import path from 'path'
import clc from 'cli-color'
import fs from 'fs-extra'

const currentDir = path.resolve(process.cwd());
// Are we in a module or are we running xrengine from source?
const isSubModule = fs.existsSync(currentDir + '/node_modules/xrengine/')
let cwd = currentDir
if (isSubModule) cwd = currentDir + '/node_modules/xrengine/'

const [, , ...args] = process.argv

console.log(cwd)

function showOptions(){
  console.log(clc.bold('Available Commands:'))
  console.log(clc.cyan('init').concat(clc.white(' - set your project up for development')))
  console.log(clc.yellow('help').concat(clc.white(' - more info about xrengine')))
  console.log(clc.green('dev').concat(clc.white(' - use this for local development')))
  console.log(clc.green('dev-db').concat(clc.white(' - start a local dev database') + clc.red(' (requires Docker)')))
  console.log(clc.green('server').concat(clc.white(' - use this for CI/deployments')))
  console.log(clc.green('test').concat(clc.white(' - use this to run xrengine tests\n')))
}

function showHelp(){
  console.log('Having issues? Submit a Github issue at: ' + clc.cyan('http://github.com/xr3ngine/xrengine'))
  console.log('Want to read the documentation? You can find that at ' + clc.cyan('http://xrengine.school'))
  console.log("You can also find us on Discord: " + clc.cyan('https://discord.gg/cbQAmdV\n'))
  console.log(clc.blue("Made with <3 by people all over the world."))
  console.log(clc.green("If you are interested in contributing, we'd absolutely love to have you be involved. Let's build something beautiful together!"))
}

function initialize(){
if(!isSubModule){
  console.log(clc.red('Initialization is only necessary if xrengine is running as a submodule'))
  process.exit() 
}

// Install eslint, typescript, ts-node-env, stylelint, babel, babel-present-env, .tsconfig, etc.

// Copy the folder structure setup
  fs.copy(cwd + 'userFolders/*', currentDir +' /' , function (err) {
    if (err) return console.error(clc.red(err))
    console.log(clc.green('Copied files from ' + cwd + 'userFolders/ to ' + currentDir))
  });

// Copy the config
fs.copy(cwd + 'config/default.json', currentDir + '/xrengine.config.json' , function (err) {
  if (err) return console.error(clc.red(err))
  console.log(clc.green('Copied config from ' + cwd + 'config/default.json to' + currentDir + '/xrengine.config.json'))
});

// eslint
fs.copy(cwd + '.eslintrc', currentDir + '.eslintrc' , function (err) {
  if (err) return console.error(clc.red(err))
  console.log(clc.green('Copied config from ' + cwd + 'config/default.json to' + currentDir + '/xrengine.config.json'))
});

// stylint
fs.copy(cwd + '.stylint', currentDir + '.stylint' , function (err) {
  if (err) return console.error(clc.red(err))
  console.log(clc.green('Copied config from ' + cwd + 'config/default.json to' + currentDir + '/xrengine.config.json'))
});

// babelrc
fs.copy(cwd + '.babelrc', currentDir + '.babelrc' , function (err) {
  if (err) return console.error(clc.red(err))
  console.log(clc.green('Copied config from ' + cwd + 'config/default.json to' + currentDir + '/xrengine.config.json'))
});

// tsconfig
fs.copy(cwd + 'tsconfig.json', currentDir + 'tsconfig.json' , function (err) {
  if (err) return console.error(clc.red(err))
  console.log(clc.green('Copied config from ' + cwd + 'config/default.json to' + currentDir + '/xrengine.config.json'))
});

console.log(clc.green("XREngine has been initialized!"))
console.log(clc.cyan("Documentation and Quickstart are availale at http://xrengine.school"))
console.log(clc.blue("Good luck, may the beautiful worlds in your dreams exist for all of us to share :)"))
process.exit() 
}

if (args.length > 1 || args.length < 1){
  console.log(clc.red('\nError: xrengine takes one argument\n'))
  showOptions()
  process.exit() 
}

let npmCommand

switch(args[0]){
  case 'init':
    console.log(clc.green("Initializing xrengine..."))
    initialize()
    break
    case 'help':
      showHelp()
      process.exit()
      break
  case 'dev':
    console.log(clc.green("Starting xrengine in development mode..."))
    npmCommand = 'dev'
    break
  case 'dev-db':
    console.log(clc.green("Starting development database... leave this running in the background!"))
    npmCommand = 'dev-db'
    break
  case 'server':
    npmCommand = 'start'
    break
  case 'test':
    console.log(clc.green("Running tests..."))
    npmCommand = 'test'
    break
  default:
    console.log(clc.red('\nError: invalid argument\n'))
    showOptions()
    process.exit()
}

npmCommand = "npm run " + npmCommand
const cmd = exec(npmCommand, { cwd },
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