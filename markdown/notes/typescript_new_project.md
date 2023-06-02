## 2023-06-02  
### (typescript setup, typescript new project, jest, esbuild, repl)  
  Install deps:  
  
      npm install -g typescript  
      mkdir <my-project>  
      cd <my-project>  
      npm install --save-dev ts-node  
      npm install --save-dev jest  
      npm install --save-dev ts-jest  
      npm install --save-dev @types/jest  
      npm install --save-dev --save-exact esbuild  
      npm install --save-dev tsconfig-paths  
  
  Setup `tsconfig.json`. See current tsconfig [here](https://github.com/lzell/dscompiler/blob/main/figma_plugin/tsconfig.json)  
  
      {  
        "compilerOptions": {  
          "allowImportingTsExtensions": true,  
          "baseUrl": ".",  
          "esModuleInterop": true,  
          "isolatedModules": true,  
          "lib": ["es6"],  
          "noEmit": true,  
          "noImplicitAny": true,  
          "noUnusedLocals": true, // Turn this off when using repl  
          "strict": true,  
          "target": "es6",  
          "typeRoots": [  
            "./node_modules/@types",  
          ],  
        }  
      }  
  
  Create jest.config.js with the following contents:  
  
      module.exports = {  
          "roots": [  
            "./test",  
            // I add './src' here so that `npm run watch_test` reruns tests whenever  
            // changes are made to files under the `src` tree.  
            // There are no tests in the `src` tree.  
            "./src",  
          ],  
          "testMatch": [  
            "**/?(*.)+(spec|test).+(ts|tsx|js)"  
          ],  
          "transform": {  
            "^.+\\.(ts|tsx)$": "ts-jest"  
          },  
      }  
  
  Add the following to package.json:  
  
      ...  
      "scripts": {  
        "bundle": "./node_modules/.bin/esbuild main.ts --bundle --outfile=main.js",  
        "repl": "npx ts-node -r tsconfig-paths/register",  
        "test": "jest",  
        "typecheck": "tsc --project tsconfig.json",  
        "watch_bundle": "npm run bundle -- --watch=forever",  
        "watch_test": "npm run test -- --watch",  
        "watch_typecheck": "npm run typecheck -- --watch --preserveWatchOutput"  
      }  
   
  
  Create project dirs:  
  
      mkdir <project-dir>/src  
      mkdir <project-dir>/test  
  
  Write `main.ts`:  
  
      // Contents of <my-project>/main.ts  
      import { myFunction } from 'src/dependency.ts'  
      console.log(myFunction())  
  
  
  Write a source file that `main` depends on:  
  
      // Contents of <my-project>/src/dependency.ts  
      export function myFunction(): string {  
          return "hello world"  
      }  
  
  
  Write a test:  
  
      // Contents of <my-project>/test/dependency.test.ts  
      import { myFunction } from '../src/dependency.ts'  
  
      test("myFunction says hello world", () => {  
         expect(myFunction()).toBe("hello world")  
      })  
  
  Run test with:  
  
      npm run test  
  
  typecheck with:  
  
      npm run typecheck  
  
  bundle with:  
  
      npm run bundle  
      node main.js  
      :: prints 'hello world'  
  
  Start repl with:  
  
      npm run repl  
      > import {myFunction} from 'src/dependency.ts'  
      > myFunction()  
      :: prints 'hello world'  
