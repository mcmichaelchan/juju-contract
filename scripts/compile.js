const fs = require('fs-extra');
const path = require('path');
const solc = require('solc');

// clean-up
const COMPILED_DIR = path.resolve(__dirname, '../compiled'); //导出路径
fs.removeSync(COMPILED_DIR);
fs.ensureDirSync(COMPILED_DIR);

// compile
const contractPath = path.resolve(__dirname, '../contracts', 'Car.sol');
const contractSource = fs.readFileSync(contractPath, 'utf8');

const result = solc.compile(contractSource, 1);
console.log(result);

// error handle
if (Array.isArray(result.errors) && result.errors.length) {
    throw new Error(result.errors[0]);
}

Object.keys(result.contracts).forEach(name => {
    const contractName = name.replace(/^:/, '');
    const filePath = path.resolve(COMPILED_DIR, `${contractName}.json`);
    fs.outputJsonSync(filePath, result.contracts[name]);
    console.log(`save compiled contract ${contractName} to ${filePath}`);
});
    
