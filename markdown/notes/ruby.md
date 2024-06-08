### Ruby save file from repl  
Equivalent of ipython's `%save`:  
  
    ./bin/rails c  
    > Pry.start  
    > # prototype  
    > hist --save myfile.rb  
  
### Ruby static method style  
  
I prefer  
  
    class << self  
      def my_method  
      end  
    end  
  
Over  
  
    def self.my_method  
    end  
  
Becuase it makes it easier to ack/grep for definition of `my_method` without guessing the style  
  
  
### Ruby case statement  
    x = 'a'  
    y = case x  
        when 'a'  
          1  
        when 'b'  
          2  
        else  
          3  
        end  
  
Or  
  
    x = 'a'  
    y = case x  
        when 'a' then 1  
        when 'b' then 2  
        else 3  
        end  
          
### Ruby threads  
Get current number of threads with `Thread.list`.  
  
Threads are torn down when they run to completion. E.g.  
  
    Thread.list #=> [main]  
    Thread.new { puts "hello world"; sleep(1) }  
    Thread.list #=> [main, new-thread]  
    :: wait one second  
    Thread.list #=> [main]  
  
Threads can be killed:  
  
    t = Thread.new { sleep(1000) }  
    t.kill  
  
  
### Ruby get the source location of a method  
A couple ways to find where a ruby method or class is defined:  
  
1. Use `instance_method` in the repl. For example:  
  
    irb  
    require 'mail'  
    Mail::Sendmail.instance_method(:deliver!) # =>   
    # => #<UnboundMethod: Mail::Sendmail#deliver!(mail) /Users/lzell/.rvm/gems/ruby-3.2.2/gems/mail-2.8.1/lib/mail/network/delivery_methods/sendmail.rb:64>   
  
2. Use the `source_location` helper:  
  
    Redis.new.method(:publish).source_location  
  
### Ruby gotcha  
  
Time#utc mutates self:  
  
    now = Time.now  
    now.utc  
    now  
  
### Ruby gotcha  
Closures behave differently depending on if they are defined using `proc` or `lambda`  
  
    def a  
      x = proc { return }  
      x.call()  
      puts "You never see me"  
    end  
  
    a() // Doesn't print anything  
  
    def b  
      x = lambda { return }  
      x.call()  
      puts "But you do see me"  
    end  
  
    b() // Prints "But you do see me"  
  
    def c  
      x = -> { return }  
      x.call()  
      puts "And you see me too"  
    end  
  
    c() // Prints "And you see me too"  
  
  
### How to map from a range  
Subtle syntax difference results in major functional change:  
  
    [0..10].map { 1 }  
    # => [1]  
  
    (0..10).map { 1 }  
    [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]  
  
### Replace characters with tr  
  
    "1337".tr("137", "let")  
    # => "leet"  
  
### Reminder that if/else are expressions in ruby:  
  
    a = if true  
      "hello"  
    else  
      "world"  
    end  
  
  
<!-- 2023-08-28 -->  
### (ruby, install, 3.2.2, rvm, openssl)  
I was having problems installing ruby on a friend's machine.  
Had to use:  
  
    rvm install ruby-3.2.2 --with-openssl-dir=$(brew --prefix openssl)  
  
<!-- 2023-05-13 -->  
### (ruby repl, irb, insert line in existing function)  
Up arrow to previously executed code in irb  
Use Opt+Enter to add a new line without executing  
  
<!-- 2023-05-10 -->  
###  (ruby, system, exception, raise if error from shell, default does not raise)  
None of these raise by default:  
  
    system "exit 1"  
    `exit 1`  
    %x(exit 1)  
  
Instead, use:  
  
    system "exit 1", exception: true  
  
### (ruby, map, symbol syntax, symbol to proc)  
The symbol to proc functionality assumes that the symbol is a member of the  
calling instance. To call a pure function, use `my_array.map(&method(:my_fn))`.  
For example:  
  
    def add_one(n)  
      return n + 1  
    end  
  
    [1,2,3].map &method(:add_one)  
  
### (ruby debug, ruby 3)  
Either use:  
  
    require "debug"  
    :: Add breakpoint in source with `debugger`  
  
Or add `binding.irb` in source, no require necessary.  
I prefer the former, because stepping (`n`) and continuing (`c`) through the source works.  
  
### (ruby 3 irb autocomplete, navigate autocomplete popup)  
Move down: Tab  
Move up: Shift-Tab  
  
### (ruby disable irb autocomplete)  
Start irb with `irb --noautocomplete`  
or add `IRB.conf[:USE_AUTOCOMPLETE] = false` to `~/.irbrc`  
  
### (ruby, erb, howto)  
- In the template, `myfile.txt.erb`, use placeholders like `<%= my_variable %>`  
- In the doc generator, `generator.rb`:  
```  
    require "erb"  
    my_variable = "hello world"  
    result = ERB.new(File.read("myfile.txt.erb")).result(binding)  
    File.write("myfile.txt", result)  
```  
- Call the generator with `ruby generator.rb`, and observe `myfile.txt` on disk.  
  
  
<!-- 2019-06-11 -->  
### (rvm upgrade, rvm update ruby version)  
`rvm get stable`  
  
### (rvm set default ruby version)  
`rvm --default use X.Y.Z`  
  
### (rvm, ruby, remove rvm)  
rvm implode  
  
<!-- 2018-08-18 -->  
### (rvm, name a version of ruby for local use)  
  
    rvm alias create myruby ruby-2.4.1  
    rvm use myruby  
  
### (ruby, global vars, cheat sheet)  
https://gist.github.com/dvliman/10402435  
  
### (ruby gem install dir)  
See where bundler finds a specific gem:  
  
    bundle show <gemname>  
  
<!-- 2015-04-03 -->  
### (ruby koans, assert, testing, education)  
https://www.rubykoans.com/  
  
<!-- 2015-02-17 -->  
### (ruby ruby, sexp, lexer, parser, tokenize)  
http://ruby-doc.org/stdlib-2.2.0/libdoc/ripper/rdoc/Ripper.html  
  
<!-- 2014-08-04 -->  
### (ruby, find methods defined lower in class tree)  
List methods on an instance that are defined outside of `Object`:  
  
    class Object  
        def local_methods  
          (methods - Object.instance_methods).sort  
        end  
    end  
  
Can also try:  
  
     ActiveSupport::MessageEncryptor.methods - Object.methods  
  
<!-- 2013-11-26 -->  
### (ruby, irb, faulty ~/.irbrc, debugging)  
To see why ~/.irbrc is not working properly:  
  
    ruby ~/.irbrc  
  
### (irb, default configuration)  
  
`/private/etc/irbrc` holds the default irb config, can be overwritten by creating a `~/.irbrc` file.  
  
<!-- 2013-05-28 -->  
### (ruby, rackup, reload on file system changes)  
See the rerun gem  
  
    $ rerun --background --no-growl rackup service.ru  
  
### (ruby, pry, irb, autocomplete, source exploration, discovery)  
Pry is really sweet.  
  
    $ pry  
    > cd FileUtils  
    > ls  
    > show-method mkdir  
  
<!-- 2013-02-06 -->  
### (ruby, time, active support, time helpers, number of seconds)  
`require 'active_support/time'`  
  
I added this here:  
https://stackoverflow.com/a/14725405/143447  
  
<!-- 2013-01-03 -->  
### (irb, source exploration, discovery)  
  
  Given a starting value, see what method will give the desired result with `what_methods`.  
  E.g.  
  
    require 'what_methods'  
    10.what? "10" #=> 10.to_s, 10.inspect  
  
## 2012  
<!-- 2012-12-15 -->  
### (ruby, colorize irb prompt, colorize rails console prompt):  
  
    require "wirble"  
    IRB.CurrentContext.prompt_i = Wirble::Colorize.colorize_string(IRB.CurrentContext.prompt_i, :red)  
  
<!-- 2012-05-22 -->  
### (ruby, gems, get location on disk)  
`gem env`  
  
  
<!-- 2010-06-03 -->  
### (rvm, which rvm)  
After installing rvm, I was surprised that `which rvm` exited with 1.  
`rvm` is a function that's sourced into my shell.  
Use `command -v rvm` to see if my shell can find it.  
Use `bash --debugger -cl "declare -F rvm"` to find where the function is defined.  
The output will contain the definition file on disk and the source line number.  
  
### (ruby, rubygems, load automatically)  
Do not add `require "rubygems"` to code.  
Start ruby with `ruby -rubygems`, or irb with `irb -rrubygems`, or add this to `~/.bash_profile`:  
  
    export RUBYOPT="rubygems"  
  
source: https://tomayko.com/blog/2009/require-rubygems-antipattern  
  
  
<!-- 2009-05-15 -->  
### (ruby, regex, dot star, does not match new line)  
Here is an interesting difference:  
  
    irb> a = "string with \n new line"  
    irb> a =~ /(.*)/  
    irb> $1  
    => "string with "  
  
    irb> a =~ /([^"]*)/  
    irb> $1  
    => "string with \n new line"  
  
The .* does not match new lines, but negated class does  
  
  
### (ruby, class variables, inheritance works as expected)  
  
    class A  
      @greeting = "hello"  
      class << self  
        attr_reader :greeting  
      end  
    end  
  
    class B < A  
      @greeting = "hola"  
    end  
  
    A.greeting # => "hello"  
    B.greeting # => "hola"  
  
### (ruby, iterate all error classes at runtime)  
  
    ObjectSpace.each_object(Class) do |cls|  
      if cls.ancestors.include? Exception  
        puts cls  
      end  
    end  
  
### (ruby, irb, find class name in irb)  
  
    irb> self.class.constants.select { |c| c =~ /needle/i }  
  
### (ruby, send message, dynamic, dynamic method call)  
`object.message` is the same as `object.send(:message)`  
  
For example, `5.send :to_s`  
  
### (ruby, variable in regex)  
  
    a = "[0-9]+"  
    b = /#{a}/  
  
### (ruby, pad a month string to two digits)  
  
    month = 5  
    month.to_s.gsub(/^(\d)$/, '0\1')  
  
### (ruby, add N months to current month)  
  
    month = ((month - 1 + N ) % 12) + 1  
  
### (ruby, irb, benchmark in irb)  
    require 'benchmark'  
    include Benchmark  
  
    bm(10) do |test|  
        test.report("result 1:") do  
          # test something  
        end  
        test.report("result 2:") do  
          # test something else  
        end  
    end  
  
### (ruby, reference semantics, array, create array of empty arrays)  
Gotcha:  
  
    array = Array.new(2,[])  
    array[0][0] = "x"  
    array  
    # => [["x"], ["x"]]  
    # Both subarrays are filled with "x" (it's really one array)  
  
Use:  
  
    array = Array.new(2) { [] }  
    array[0][0] = "x"  
    array  
    # => [["x"], []]  
  
### (ruby, instance eval, I thought this was once a good idea)  
These accomplish the same thing:  
  
    class Test  
      attr_accessor :one, :two, :three  
      def initialize(one, two, three)  
        @one = one  
        @two = two  
        @three = three  
      end  
    end  
    Test.new(1,2,3)  
  
and  
  
    class Test  
        attr_accessor :one, :two, :three  
        def initialize(&block)  
            instance_eval &block  
        end  
    end  
    Test.new {self.one = 1; self.two = 2; self.three = 3}  
  
### (ruby, color, term, escape code, irb)  
Loop through escape sequences in IRB to pick a color:  
  
    (30..50).each do |x|  
      puts x  
      print "\e[#{x}mTEST\e[0m\n"  
    end  
  
### (ruby, is daylight savings in effect?)  
`Time.now.isdst`  
