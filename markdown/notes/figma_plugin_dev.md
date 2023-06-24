## 2023  
<!-- 2023-06-19 -->  
### (spread operator, esbuild, figma, runtime error)  
The usage of spreads leads to runtime errors when Figma plugins run.  
The fix is to pass `--target=es6` to the bundler, even if it is already set in `tsconfig.json`.  
I bundle with:  
  
    esbuild src/main.ts --bundle --target=es6 --outfile=dist/main.js  
  
<!-- 2023-06-15 -->  
### (figma, plugin API, exploration)  
Get the color of the current selection:  
  
    figma.currentPage.selection[0].fills[0]  
  
Print readable 2d array in console, use `console.table`:  
  
    console.table(figma.currentPage.selection[0].fills[0].gradientTransform)  
  
<!-- 2023-05-17 -->  
### (figma plugin, getting started)  
  
- Open the Figma desktop app  
- Go to Plugins > Development > New Plugin > Figma Design > Run Once  
  This creates a plugin with starter source code to drop five orange rectangles on the canvas  
- Setup the plugin:  
  
    ```  
    cd <project-dir>  
    npm install -g typescript  
    npm install --save-dev @figma/plugin-typings  
    ```  
  
- Browse type definitions at `<project-dir>/node_modules/@figma/plugin-typings/plugin-api.d.ts`  
  
- Build the plugin once with `npm run build`.  
  Or watch the filestystem and rebuild on source changes with `npm run watch`.  
  
- Run the plugin in Figma at `Plugins > Development > <project-name>`  
  
- Once the plugin is run once, run again with `cmd+opt+p`  
  
### (figma plugin, bundle multiple source files, esbuild, plugin setup)  
- Install esbuild:  
  
    ```  
    npm install --save-dev --save-exact esbuild  
    ```  
  
- Add the following compiler options to `tsconfig.json`:  
  
    ```  
    "compilerOptions": {  
      ...  
      "allowImportingTsExtensions": true,  
      "isolatedModules": true,  
      "noEmit": true,  
    }  
    ```  
  
- Split the template project into a couple source files to ensure that imports work as expected.  
    - Add `lib.ts` with contents:  
  
        ```  
        export function getNumberOfRectangles(): number {  
          return 3;  
        }  
        ```  
  
    - Modify `code.ts` to contain:  
  
        ```  
        import { getNumberOfRectangles } from './lib.ts'  
        ...  
        for (let i = 0; i < getNumberOfRectangles(); i++) {  
         ...  
        }  
        ```  
  
    - Ensure the type checker is happy:  
  
        ```  
        tsc -p tsconfig.json  
        ```  
  
    - Ensure the bundler is happy:  
  
        ```  
        ./node_modules/.bin/esbuild code.ts --bundle --outfile=code.js  
        ```  
  
- Run the plugin in Figma and verify that three orange rectangles appear (instead of five).  
  
- Make `npm run watch` run the bundler and the typechecker on every file system change, and multiplex the output:  
    - Install the unix `parallel` program with `brew install parallel`  
    - Modify `package.json` to contain:  
  
        ```  
        "scripts": {  
          "typecheck": "tsc --project tsconfig.json",  
          "bundle": "./node_modules/.bin/esbuild code.ts --bundle --outfile=code.js",  
          "watch_typecheck": "npm run typecheck -- --watch --preserveWatchOutput",  
          "watch_bundle": "npm run bundle -- --watch=forever",  
          "watch": "parallel --ungroup 'npm run' ::: watch_typecheck watch_bundle"  
        },  
        ```  
  
    - Run `npm run watch` and make a source change. Verify both the typechecker and bundler emit output.  
