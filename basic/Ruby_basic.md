### There are three basic types of executing Ruby
#### 1. From files
```bash
root@kali-[~/Desktop/ruby]# cat hello_word.rb  
#!/usr/bin/ruby
puts 'Hello World!!!'

root@kali-[~/Desktop/ruby]# ruby hello_word.rb
Hello World!!!
```

#### 2. From CMD line
```bash
# ruby -e "puts 'Hello World'"
Hello World
```

#### 3. From interactive Ruby
```bash
# irb --simple-prompt
>> puts "Hello World"
Hello World
=> nil
```


<hr>

### Math in Ruby
```ruby
# irb --simple-prompt
>> 2 + 10 #plus
=> 12
>> 2 * 10 # product 
=> 20
>> 7 ** 2 # square
=> 49
>> 2 ** 3 # cube
=> 8
>> 5 / 2 # integer division
=> 2
>> 5 / 2.0 # float division
=> 2.5
>> 5 % 2 # module
=> 1
>> Math.sqrt(25) # square root
=> 5.0
>> Math.log10(10**4) # base10 log
=> 4.0
>> Math.log2(8) # base2 log
=> 3.0
>> Math.log(49,7) # base7 log
=> 2.0
>> Math.exp(1) #e**1
=> 2.718281828459045
>> Math.exp(3) # e**3
=> 20.085536923187668
>> Math::E**3  # e**3
=> 20.085536923187664
>> Math.cos(0) # cosine of 0 
=> 1.0
```

<hr>

### Ruby One Liners
+ We can display contents of a file (like cat or type command) with the following:

```md
root@kali-[~/Desktop/ruby]# ruby -pe 0 "hello_word.rb" 
#!/usr/bin/ruby
puts 'Hello World!!!'

-e executes one line of ruby command.
-p iterates into a loop that reads each line and prints them to stdout (it cannot be used alone)
-pe 0 'file' : print line to line, for each line, it executes 0 command, which is a unique way to write the file to stdout.
```

+ The following example can be used to count the number of the lines of a file:

```md
root@kali-[~/Desktop/ruby]# ruby -ne 'END {print "Lines: ",$.,"\n"}' "hello_word.rb"
Lines: 2

-n: puts the code into loop
-e: execute one line of Ruby code between ''
print: prints the following string to stdout without adding a new line at the end
END: executes next block of instructions
$.: is a global variable that holds the last line number read by ruby interpreter
.: is used to concatinate strings
```

+ The following command replaces all the occurences of "Hello" with "HELLO". Note that it will also create a backup of the original file:

```bash
root@kali-[~/Desktop/ruby]# ruby -i.bak -pe 'gsub "Hello","HELLO"' hello_word.rb 

-i: specifies in-place edit mode (edit each line read by -p instead of write it to stdout). If exetension is provided (.bak), ruby will make a backup of the original.
gsub: stands for global substitution (replace the first argument with the second)

root@kali-[~/Desktop/ruby]# ls -al     
total 16
drwxr-xr-x 2 root root 4096 Jul 26 23:58 .
drwxr-xr-x 3 root root 4096 Jul 26 22:14 ..
-rwxr-xr-x 1 root root   38 Jul 26 23:58 hello_word.rb
-rwxr-xr-x 1 root root   38 Jul 26 23:36 hello_word.rb.bak   
root@kali-[~/Desktop/ruby]# cat hello_word.rb
#!/usr/bin/ruby
puts 'HELLO World!!!'
```

<hr> 

### Libraries / RubyGems
+ Ruby relies on a wide range of third-party libraries. There are different sources of libraries; the most famous is RubyGems (https://rubygems.org/). Other sources are RubyForge, Github, and the RubyToolbox (a project that makes it easy to explore open source Ruby projects).
+ Some `gem` commands for a simply use:

```md
gem help
gem search [string]
gem search -r http # -r means remote
gem search -h
```

+ Once we know which gem we want to install, we can run the following command:

```md
gem install [gem_name]
```

+ For example, if we want to install `openssl` we will run:

```md
gem install openssl-extensions
```

+ Help options is available with install too:

```md
gem install -h
```

+ For a list of your locally installed gems:

```md
gem list
```

+ A useful gem is `pry`: it provides an interactive environment (like `irb`) with many interesting features such as syntax highlighting.

```md
gem install pry
```

```ruby
root@jaeng-[~]# pry --simple-prompt
>> 2 + 3
=> 5
>> 2 - 10
=> -8
>> "Hello" + "World!!!"
=> "HelloWorld!!!"
```

<hr>

### Data Types
+ Like many other languages, Ruby has several data types.

#### 1. Numbers
+ **Every value** in Ruby is an object. So, even simple operations about numbers like `+`, `-`,  `/` and `%` are operations between objects.
+ An integer is an **OBJECT** of the Ruby **class Integer**. In the OO paradigm, every object value can use the public method of its object class. So the usual operations are method invocation too.
+ In Ruby, to call an object method, use the point notation.
+ Example:

```ruby
root@jaeng-[~]# pry --simple-prompt
>> 2 + 3
=> 5
>> 2.+(3)
=> 5
>> 2**2
=> 4
>> 2.**(2)
=> 4
```

+ Notice that `2.+` means that we are calling the method `+` of the `2` object.
+ An integer value also has a lot of other methods:

```ruby
root@jaeng-[~]# pry --simple-prompt                                                                                                                                                      1 ⚙
>> 4.odd?
=> false
>> 4.even?
=> true
>> 10.next
=> 11
>> 10.pred
=> 9
>> 2.lcm(7)
=> 14
>> 25.to_s
=> "25"
>> 65.chr
=> "A"
>> -5.abs
=> 5
>> 15.integer?
=> true
>> 28.gcd(49)
=> 7
```

+ In general, if a method ends with the question mark, it means that the returning value is a Boolean. It is a code style convention of Ruby.

#### 2. Anticipation
+ We can use `upto` method in Ruby to write one line of code in order to print a range of IP address.

```md
root@jaeng-[~/Desktop/ruby]# ruby ip_upto.rb 192.168.0 10 20
192.168.0.10
192.168.0.11
192.168.0.12
192.168.0.13
[...]
192.168.0.19
192.168.0.20  
root@jaeng-[~/Desktop/ruby]# pygmentize ip_upto.rb


# ARGV[1].upto(ARGV[2]) {|i| print ARGV[0],".",i,"\n"}

```

#### 3. Comments
+ `#` in Ruby is the delimiter for the one-line Ruby comment.
+ Comments are not instructions or data types. They serve to add annotations to the code, especically when it rich and complex.
+ Ruby also allows to define **multi line notation** (or comment block) with the following syntax:
```ruby
=begin
Multi line
→ comments here
=end
```

+ Example:

```ruby
root@jaeng-[~/Desktop/ruby]# cat comments.rb                            
#!/usr/bin/ruby

# This is one a comment

print "Hello "

=begin
a lot of comments
here
=end

print "World!!!"
```