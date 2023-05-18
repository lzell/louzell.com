## 2023-05-17  
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
