## 2023  
<!-- 2023-06-04 -->  
### (liquidjs, liquid, templating, write file)  
  
Creat new project:  
  
    mkdir <my-project>  
    cd <my-project>  
    npm install --save liquidjs  
  
Edit `ui.txt.liquid` to contain  
  
    Hello {{ name }}  
  
Edit `buildui.mjs` to contain:  
  
    import { Liquid } from 'liquidjs'  
    import fs from 'fs'  
      
    const engine = new Liquid();  
    engine  
      .renderFile("ui.txt.liquid", {name: "world"})  
      .then((res) => {  
        fs.writeFileSync('ui.txt', res);  
      });  
  
    console.log('Wrote ui.txt');  
  
Render `ui.txt` with:  
  
    node buildui.mjs  
  
View `ui.txt` contents:  
  
    cat ui.txt  
    # => Outputs "Hello world"  
