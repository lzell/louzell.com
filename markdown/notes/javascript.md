# Javascript cheat sheet  
  
## Javscript gotcha, this context with arrow functions  
  
Careful, this does not work as expected:  
  
    const o = new Object();  
    o.fn = (x) => {  
      this.fnCalledWith = x  
    }  
    o.fn("y")  
    o.fnCalledWith // undefined!!!  
  
Use this instead:  
  
    const o = new Object();  
    o.fn = function(x) {  
      this.fnCalledWith = x  
    }  
    o.fn("y")  
    o.fnCalledWith // y  
  
  
## Javascript multiple assignment, destructuring  
  
    const [a, b] = [1, 2]  
    a // => 1  
    b // => 2  
  
  
## Javascript gotcha, buffers do not have value semantics  
       
Buffers are reference types with reference semantics.  
Strings are reference types with value semantics.  
  
So while this works as expected:  
  
    "x" == "x" // => true  
  
this is a surprise:  
  
    Buffer.from('x') == Buffer.from('x') // => false  
  
Use this instead:  
  
    Buffer.from('x').equals(Buffer.from('x')) // => true  
  
Or:  
  
    Buffer.compare(Buffer.from('x'), Buffer.from('x')) // => 0  
  
  
## Javascript gotcha, hash has reference semantics  
  
  const a = {a: 1};  
  function f(x) {  
      x['b'] = 2;  
  }  
  f(a);  
  a; // => {a: 1, b: 2}  
  
Use this as protection:  
  
  const a = {a: 1};  
  function f(x) {  
      x = {...x};  
      x['b'] = 2;  
  }  
  f(a);  
  a; // => {a: 1}  
  
  
  
## Javascript gotcha, create a hash with a variable as key name  
This does not do what I expect:  
  
    const keyName = "hello";  
    let hash = {  
        keyName: "world"  
    }  
  
I want:  
  
    const keyName = "hello";  
    let hash = {  
        [keyName]: "world"  
    }  
  
## Javascript gotcha, catching errors from callbacks  
  
Try to use async/await where possible instead of callback code.  
With async/await, I can have assurances that my try/catch statements will  
work without much thought. By contrast, if a callback slips in (which is easy), suddenly I need to think hard about catching errors or the process can crash out.   
  
    try {  
      setImmediate(() => {  
        throw new Error();  
      });  
    } catch (e) {  
      // catch error.. doesn't work  
    }  
Example sourced from https://bytearcher.com/articles/why-asynchronous-exceptions-are-uncatchable  
  
## Javascript gotcha, boolean object is truthy  
  
    if (new Boolean(false)) {  
      console.log("yes, you see me")  
    }  
  
## Javascript gotcha, use semi-colons  
  
Better to use semi-colons. This throws an exception:  
  
    console.log("a")  
    (async () => {})()  
  
But this doesn't  
  
    console.log("a");  
    (async () => {})()  
  
Because the syntax is ambiguous without the semicolon. It could be interpretted  
as `console.log('a')(async() => {})`, e.g. treating the return of `console.log()`  
as a function  
  
## Javascript gotcha, catching async raises  
  
    // Throw in an async func. Does the outer try/catch catch the error? No!  
    try {  
      (async () => {  
        throw Error("You won't catch me");  
      })();  
    }  
    catch {  
      console.log("Never seen");  
    }  
  
## Javascript's equivalent of ` __name__ == '__main__'`  
  
Specifically for node. CommonJS only. This does not work with mjs:  
  
    if (require.main === module) {  
        // run me  
    }  
  
For mjs, I use a workaround like:  
  
    if (process.env.TESTRUN == "1") {  
        // run me  
    }  
  
And run with `TESTRUN=1 node myfile.mjs`  
  
  
## Get all methods and properties of a variable  
In a repl:  
  
    Object.getOwnPropertyNames(myVar)  
    Object.keys(myVar)  
  
## Gotcha, time since epoch  
  
`Date.now()` returns **milliseconds** since unix epoch in the target system's clock, excluding leap seconds  
  
## How to sleep  
  
Sleep for 100 ms:  
  
    await new Promise(r => setTimeout(r, 100))  
  
## Sugary lambda syntax  
  
These two are the same:  
  
    await new Promise(r => setTimeout(r, 100))  
    await new Promise((r) => { setTimeout(r, 100) })  
  
  
## How to use object property shorthand  
  
    const x = "hello"  
    const y = "world"  
    {x, y}  
    # => { x: 'hello', y: 'world' }  
  
  
## How to use object method shorthand  
  
    const a = {  
        b(c) {  
            return `hello ${c}`  
        }  
    }  
    a.b("world")  
    # => "hello world"  
  
  
## How to import siblings using ESM  
  
Option A:  
  
    // a.js  
    const xyz = "a"  
    export default xyz  
  
    // Use site:  
    import a from './a.js'  
  
  
Option B:  
  
    // b.js  
    export const b = "b"  
  
    // Use site:  
    import { b } from './b.js'  
  
  
  
## How to use ESM modules in the browser  
  
Contents of index.html  
  
    ```  
    <html>  
      <body>  
        <script type="module">  
          import { greet } from './my-module.js';  
          greet('world');  
        </script>  
      </body>  
    </html>  
    ```  
  
Contents of my-module.js  
  
    export function greet(name) {  
      alert(`Hello, ${name}!`);  
    }  
  
Serve `index.html` with `python -m http.server 8000` and then browse to `localhost:8000`  
  
  
## How to export  
  
    // In mjs  
    export const handler = () => {}  
  
    // In cjs  
    const handler = () => {  
    }  
    module.exports.handler = handler  
  
  
  
## How to time how long a function takes  
  
This is a quick ballpark. Use a benchmark with large sample if true cost is desired:  
  
    import { performance } from 'perf_hooks';  
    const t1 = performance.now()  
    // myFn()  
    const t2 = performance.now()  
    console.log(`Execution time: ${(t2 - t1).toFixed(3)} milliseconds`);  
  
  
## Gotcha: careful with `x in y`  
It does not do what I intuitively think it does. For example:  
  
    1 in [1,2,3] # => true, but this is misleading  
    'a' in ['a', 'b', 'c'] # => false  
  
What I actually want is:  
  
    ['a', 'b', 'c'].includes('a')  
  
  
## Gotcha: careful with `for x in y`, `for in`  
  
Be careful with `for x in y` construct, `x` will be the index!  
Use `for x of y` instead.  
  
  
## Gotcha: careful with reference types  
  
    var x = Array(2).fill([0])  
    x[0][0] += 1  
    x  
    # => [ [ 1 ], [ 1 ] ]  
  
  
## How to get all keys of a dictionary  
  
    Object.keys(mydict)  
  
## Get the type of an instance  
  
    typeof(myVar)  
  
## Print the constructor of an instance  
  
    console.log(myVar.constructor)  
    console.log(myVar.constructor.name)  
  
(gotchas, javascript, empty arrays are different references)  
    [] == []  // false  
    [] === [] // false  
Use `[].length` instead.  
  
## How to interpolate strings  
  
    const x = 'hello'  
    console.log(`${x} world`)  
  
## How to define functions  
  
    function x(y) {  
      console.log(y)  
    }  
  
    fn = (y) => {  
      console.log(y)  
    }  
  
  
## How to store properties and methods in a vanilla object  
  
    var myObj = {  
      someProperty: "hello",  
      someFunction: function() {  
        return this.someProperty + " world"  
      }  
    }  
  
  
## How to define and iterate a `Map`  
  
Gotcha: note the parameter order in the ForEach closure.  
  
    const propMap = new Map()  
    propMap.set('a', 'foo')  
    propMap.set('b', 'bar')  
    propMap.forEach((value, key) => {  
      console.log(`${key} -> ${value}`)  
    })  
  
    // Prints  
    // a -> foo  
    // b -> bar  
  
  
## How to define a didSet handler  
  
I was looking for something like swift's `didSet`:  
  
    var myObj = {  
      set aProperty(newValue) {  
        console.log("changing from " + this._aProperty + " to " + newValue)  
        _aProperty = newValue  
      },  
      _aProperty: "foo"  
    }  
  
    myObj.aProperty = "bar"  // Prints "changing from foo to bar"  
  
  
## How to run `jsc` on MacOS  
  
As of Sonoma 14.2, `jsc` is at  
  
    /System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Helpers/jsc  
  
I symlink it with:  
  
    ln -sv /System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Helpers/jsc /usr/local/bin/jsc  
