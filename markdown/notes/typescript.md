## 2023-06-02  
### (typescript, named arguments, hack, destructuring, default values for tests)  
Named arguments aren't part of TS.  
I'm using this pattern to aid in creating factories for testing:  
  
interface X {  
  a: string  
  b: number  
}  
  
interface XPrime {  
  a?: string  
  b?: number  
}  
  
function factory({a, b}: XPrime = {}): X {  
  return {  
    a: a || "hello",  
    b: b || 123  
  }  
}  
  
## 2023-06-01  
### (typescript, default arguments)  
    function x(a: string = "hello") {  
        console.log(a)  
    }  
  
### (typescript, merge objects)  
    const x = {'a': 'foo', 'b': 'bar'}  
    const y = {'b': 'BAZ'}  
    { ...x, ...y}   
    # => {'a': 'foo', 'b': 'BAZ'}  
  
### (typescript, filter nulls and undefined, filter falsy)  
    [1,2,null,undefined,3].filter((x) => x)  
  
  or  
  
    import { compact } from 'lodash'  
    compact([1,2,null,undefined,3])  
  
  or  
  
    [1,2,null].filter(Boolean)  
  
### (typescript, get first element matching condition)  
    [1,2,3].find((x) => x == 2)  
  
### (typescript log levels)  
  Use `console.debug`, `console.warn`, `console.error`.  
  
  Also, log like this: `console.log({myThing})`.  
  
  Other tips here: https://dev.to/ackshaey/level-up-your-javascript-browser-logs-with-these-console-log-tips-55o2  
  
## 2023-05-30  
### (typescript asserts)  
    console.assert(condition, "expected <condition> to be met")  
  
### (typescript, cheatsheet, syntax, bookmark)  
  https://www.typescriptlang.org/cheatsheets  
  
### (typescript, gotcha)  
  tsconfig.json is not read when tsc is passed a specific file. E.g. tsc  
  myfile.ts will _not_ consider tsconfig.json.  
  
### (typescript, get class name at runtime)  
  `myObj.constructor.name`  
  
### (typescript, repl, requires internet)  
  If `npx ts-node` is taking a few seconds to start, and doesn't start at all  
  without internet connection, it's because I forgot `npm install --save-dev ts-node`  
  
## 2022-12-03  
### (typescript, return anonymous function)  
    function addN(n: number) {  
      return function(x: number) {  
        return x + n  
      }  
    }  
    const y = addN(3)  
    y(2) # returns 5  
  
### (typescript, tuple destructuring)  
    function foo(): [string, string] {  
      return ['hi', 'ho']  
    }  
    let [x, y] = foo()  
  
  
## 2022-11-28  
### (typescript, gotcha, nested function, capture variable, careful, this prints 2)  
    function foo() {  
      let x = 1  
      function bar() {  
        return x  
      }  
      x += 1  
      return bar  
    }  
    console.log(foo()())  
  
## 2022-11-21  
### (typescript, javascript, regex):  
    /^[a-z]$/i.test('A')  
  
  source: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/RegExp  
  
  
### (typescript, javascript, checking for null or undefined)  
    if (foo == null) {  
      // `foo` is null or undefined  
    }  
  
  source: https://stackoverflow.com/a/70040699/143447  
  
### (typescript, jest, matcher, throw, match on exception)  
    expect(() => parse(lex('(+ 1 world)').tokens())).toThrow(/ParseError on bad expression/)  
  
## 2022-11-05  
### (typescript, inherit, extend a class, subclass)  
    class ParseError extends Error {}  
  
### (typescript, instantiate)  
    new MyClass()  
  
### (typescript, throw error, raise, exception)  
    throw new ParseError("this is an error")  
  
### (typescript, define constructor, class, constructor)   
    class Foo {  
      x: number  
      constructor(x: number) {  
        this.x = x  
      }  
    }  
  
### (typescript, define instance method, class)  
    class A {  
      b(): string {  
        return "hello world"  
      }  
    }  
  
### (typescript, string interpolation)  
    const x = 'world'  
    `hello ${world}`  
  
### (typescript, string slice, no subscripting on a range)  
    const x = 'hello'  
    x.slice(<start-index>, <end-index>)  
  
### (typescript, map)  
    const x = [1,2,3]  
    x.map(y => y + 1)  
  
### (typescript, min, max, clamp)  
    Math.max(<a>, <b>)  
    Math.min(<a>, <b>)  
  
### (typescript, join array)  
    [1,2,3].join(',')  
  
### (typescript, repeat string)  
    "hello".repeat(2)  
  
### (typescript, multiline string)  
    `hello  
    world`  
