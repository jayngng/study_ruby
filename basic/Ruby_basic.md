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

#### 4. Strings
+ String is another built-in class of Ruby.
+ We can create a String value using bothe double and single quote.

```ruby
>> "Hello World"
=> "Hello World"
>> 'Hello World'
=> "Hello World"
>> String.new("Hello World")
=> "Hello World"
>> String("Hello World")
=> "Hello World"
```

##### Alternative Ruby Quotes
+ Instead of using single quotes or double quotes, we can use the `%` character.
+ Just add a custom string delimiter after the first `%` character to instruct Ruby where the quoted string begins
+ Can also use the `%` with brackets, parenthesis, braces or `<>` signs.
```ruby
>> %!Using delimiter is "exclamation mark"!
=> "Using delimiter is \"exclamation mark\""
>> %[Using "brackets"]
=> "Using \"brackets\""
>> %(Using parenthesis)
=> "Using parenthesis"
```

+ With `%q` and `%Q` you can start respectively strings that works as delimited single `''` and `""` quotes
+ Each of the them works in the same way of `''` and `""` about escaping their content
+ Both `%q` and `%Q` need a custom delimiter too and can also use the follwing special delimiters: `{}`,`[]`,`()`,`<>`.

```ruby
>> print %q!Hey we can also do it this way!
Hey we can do it this way=> nil
>> print %Q!Hey we can also do it this way!
Hey we can also do it this way=> nil
```

+ Same as numbers, strings also have different cool methods.
+ Examples:

```ruby
>> str = "Ruby is amazing!"
=> "Ruby is amazing!"
>> str.empty?
=> false
>> str.length
=> 16
>> str.size
=> 16
>> str.start_with?
=> false
>> str.end_with?
=> false
>> str.start_with? "Ruby"
=> true
>> str.end_with? "!"
=> true
>> str.clear
=> ""
```

+ String is an object, we can use many other methods for string. Type `<string>.[tab][tab]` to list all methods. 

```ruby
?> str.
str.__id__
str.__send__
str.ascii_only?
str.b
str.between?
...
```

+ Ruby offers an interesting way to make a string: `Heredoc`
+ `Heredoc` provides a mechanism for creating free format strings preserving special characters such as new lines and tabs.
+ This is EXETREMELY useful when we want to use multi-line strings with many special characters.
+ `Heredoc` examples:

```ruby
┌──(root💀jayng)-[~/Desktop/study_ruby]
└─# pygmentize heredoc_ex.rb                                                                                                                                                                           1 ⚙
#!/usr/bin/ruby

str = <<END
This is super long strings
with multiple lines 
and different special characters.
END

print str
        
┌──(root💀jayng)-[~/Desktop/study_ruby]
└─# ruby heredoc_ex.rb                                                                                                                                                                                 1 ⚙
This is super long strings
with multiple lines 
and different special characters.

```

##### String arithmetic
+ Ruby provides different ways to **concatinate** strings:
	+ `+` notation
	+ String juxtaposition
	+ `<<` notation
	+ `OO`with `concat` method.

```ruby
>> str = %!"This is "! + '+' + "notation"
=> "\"This is \"+notation"
>> print str
"This is "+notation=> nil
>> str = %[This is ] "juxtaposition"
=> "This is juxtaposition"
>> str = %{This is }.concat("OO notation")
=> "This is OO notation"
>> str = "This is " << "<< notation"
=> "This is << notation"
```

+ With Ruby, can use **repeat** the str multiple times and even **freeze** it so that it won't change.

```ruby
>> str = "Hello "
=> "Hello "
>> str * 5
=> "Hello Hello Hello Hello Hello "
>> str.freeze
=> "Hello "
>> str << "new string"
FrozenError (can't modify frozen String: "Hello ")
```

Note: freeze operates on an object, not on a variable that holds the pointer to the object. It is legal assign a new variable that refers an frozen object.

```ruby
>> str = "Hello New string" # This will work since we assign new variable.
```

+ We can also check if  an object is frozen with `.frozen?` method.
+ With the `[index]=` method, we can easily change sections of the strings.

```ruby
>> str = "We are using Python!"
=> "We are using Python!"
>> str["Python"]= "Ruby"
=> "Ruby"
>> print str
We are using Ruby!=> nil
```

+ We can also use `sub` and `gsub` to modify the string.

```ruby
>> str = "I love Python because Python is amazing!!!"
=> "I love Python because Python is amazing!!!"
>> str.sub("Python","Ruby")
=> "I love Ruby because Python is amazing!!!" # -> sub is single substitution
>> str.gsub("Python","Ruby")
=> "I love Ruby because Ruby is amazing!!!" # -> gsub is global substitution
```

Note: `sub` and `gsub` is temporary, to change the original string, we use `sub!` and `gsub!`.

```ruby
>> str.gsub("Python","Ruby")
=> "I love Ruby because Ruby is amazing!!!"
>> str
=> "I love Python because Python is amazing!!!"

>> str.gsub!("Python","Ruby")
=> "I love Ruby because Ruby is amazing!!!"
>> str
=> "I love Ruby because Ruby is amazing!!!"
```

Note: if we use `sub!` or `gsub!` on a frozen object, an error will raise.

+ We can also insert some text into a specify position of a string specifying the correct index.

```ruby
>> str = "Hello friends!"
=> "Hello friends!"

>> str.insert(str.size, " Nice to see you!")
=> "Hello friends! Nice to see you!"
```

#### 5. Interpolation
+ Interpolation allows to write Ruby into a string, which means we place any code we want to use in the `#{code}`.

```ruby
>> str = %!There are #{6*4} hours per day!
=> "There are 24 hours per day"
>> str = %!Say #{"Hello " * 3} my friends!
=> "Say Hello Hello Hello  my friends"
# Or we can even do this
>> name = "Jay"
=> "Jay"
>> print %!Hi my name is #{name}!
Hi my name is Jay=> nil
```

#### 6. Other useful methods
```ruby
>> str = "Hey Ruby, I'm learning you!"
=> "Hey Ruby, I'm learning you!"
>> str.upcase
=> "HEY RUBY, I'M LEARNING YOU!"
>> str.downcase
=> "hey ruby, i'm learning you!"
>> str.reverse
=> "!uoy gninrael m'I ,ybuR yeH"
>> str.chop
=> "Hey Ruby, I'm learning you"
```

#### 7. Array
+ Ruby array is an object that contains other objects which can be accessed using integer indexes. An array can include all types of objects.
+ We can create and edit an array using different styles: from Object Oriented notations to inline notations.

```ruby
>> my_array = Array.new(2)
=> [nil, nil]
>> my_array[0]=1
=> 1
>> my_array[1]=2
=> 2
>> my_array
=> [1, 2] 

>> my_array = Array.new(3,"Hello")
=> ["Hello", "Hello", "Hello"]
>> my_array[1] = "Hi"
=> "Hi"
>> my_array
=> ["Hello", "Hi", "Hello"]

>> my_array = ["Hello", "Hi"]
=> ["Hello", "Hi"]
>> my_array
=> ["Hello", "Hi"]

>> my_array = []
=> []
>> my_array<<1<<2<<3<<4<<5<<6
=> [1, 2, 3, 4, 5, 6]
>> my_array
=> [1, 2, 3, 4, 5, 6]
```

##### Accessing Array Elements
+ Elements of an array can be accessed by referencing the index of the element or using Array object methods.

```ruby
>> dow = ["Mon","Tues","Wed","Thurs","Fri","Sat","Sun"]
=> ["Mon", "Tues", "Wed", "Thurs", "Fri", "Sat", "Sun"]
>> dow[2]
=> "Wed"
>> dow[0]
=> "Mon"
>> dow[-1]
=> "Sun"
>> dow[-2]
=> "Sat"
>> dow.at(0)
=> "Mon"
>> dow.first
=> "Mon"
>> dow.last
=> "Sun"
>> dow[1..3]
=> ["Tues", "Wed", "Thurs"]
```

##### Multi-typed Array
+ An array can contains different types of objects.
```ruby
>> array = ["Hello", 1, 2, "Three"]
=> ["Hello", 1, 2, "Three"]
>> array[0].class
=> String
>> array[1].class
=> Integer
>> array << 2.5
=> ["Hello", 1, 2, "Three", 2.5]
>> array.last.class
=> Float
```

##### Multi-dimentional Array
+ An array can also contain another array.

```ruby
>> array = ["Hello", 1, ["small","big"]]
=> ["Hello", 1, ["small", "big"]]
>> array << 2.5
=> ["Hello", 1, ["small", "big"], 2.5]
>> array = [array]
=> [["Hello", 1, ["small", "big"], 2.5]]
```

##### Variables and Array
+ By changing the value of a variable, the value of a **variable object** will be affected as well.

```ruby
>> var = %!a string!
=> "a string"
>> var.object_id
=> 280
>> array = [1, var]
=> [1, "a string"]
>> array[1].object_id
=> 280
>> var.capitalize!
=> "A string"
>> array
=> [1, "A string"]
>> array[1].upcase!
=> "A STRING"
>> var
=> "A STRING"
>> var.object_id == array[1].object_id
=> true
```

##### Insertions
+ We can install one or more elements in an arbitrary position using `insert` method.

```ruby
>> a = [1,3,5,7,9]
=> [1, 3, 5, 7, 9]
>> a.insert(1,2)
=> [1, 2, 3, 5, 7, 9]
>> a.insert(1,2,4)
=> [1, 2, 4, 2, 3, 5, 7, 9]
>> a
=> [1, 2, 4, 2, 3, 5, 7, 9]
```

+ We can also append the elements quickly with `<<` operator.

```ruby
>> a<<10<<11<<12
=> [1, 2, 4, 2, 3, 5, 7, 9, 10, 11, 12]
>> a<<[13,14,15]
=> [1, 2, 4, 2, 3, 5, 7, 9, 10, 11, 12, [13, 14, 15]]
```

+ It is also possible to use ranges to insert and modify elements in array.

```ruby
>> a[0..2]= "one", %!two!, %q{three}
=> ["one", "two", "three"]
>> a
=> ["one", "two", "three", 2, 3, 5, 7, 9, 10, 11, 12, [13, 14, 15]]
```

##### Deletion
+ To delete elements in an array, we can specify array element name (`delete` method).
+ Or use the `delete_at` method by specifying element index.
```ruby
>> a = []
=> []
>> a<<1<<2<<3<<4<<5
=> [1, 2, 3, 4, 5]
>> a<<%!Hello!
=> [1, 2, 3, 4, 5, "Hello"]
>> a.delete(1)
=> 1
>> a.delete_at(-1)
=> "Hello"
>> a
=> [2, 3, 4, 5]
```

##### Operations between arrays
+ We can concatenate different arrays using these methods.

```ruby
>> a = [1,2,3,4,5]
=> [1, 2, 3, 4, 5]
>> b = [6,7,8,9,10]
=> [6, 7, 8, 9, 10]
>> c = [11,12,13,14,15]
=> [11, 12, 13, 14, 15]

>> a + b + c # → "Plus" method
=> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]

>> a.concat(b).concat(c) # → Concat method
=> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
```

+ The power of the Ruby is in the operations between sets. We can treat an array as a set and perform operations like:

	+	Union (`|`): concatenates two arrays (removing duplicates)
	+	Intersection (`&`): only elements that are common to both array return.
	+	Difference (`-`): returns the first array without elements contain in the second array.

```ruby
>> a = [1,2,3,4, "A"]
=> [1, 2, 3, 4, "A"]
>> b = [1,2,5,6,"A", "B"]
=> [1, 2, 5, 6, "A", "B"]
>> a | b
=> [1, 2, 3, 4, "A", 5, 6, "B"]
>> a & b
=> [1, 2, "A"]
>> a - b
=> [3, 4]
```

##### Stack
+ Ruby arrays also  provide `push` and `pop` methods.
+ These two methods work in the same way as the `push` and `pop` used with stacks.
```ruby
>> a = [1,2,3,4,5]
=> [1, 2, 3, 4, 5]
>> a.pop
=> 5
>> a.pop
=> 4
>> a.pop
=> 3
>> a.push(%!Hello!)
=> [1, 2, "Hello"]
>> a
=> [1, 2, "Hello"]
```

##### Some useful methods
+ `sort`, `reverse`, `uniq`, `max`, `min`

```ruby
>> a.sort
=> [-3, -2, -1, 1, 2, 5, 6, 7]
>> a.reverse
=> [7, 6, 5, -3, -2, -1, 2, 1]
>> a.uniq
=> [1, 2, -1, -2, -3, 5, 6, 7]
>> a.max
=> 7
>> a.min
=> -3
```

#### 8. Array and Strings
+ We can **create strings starting from an array** using `join` method.

```ruby
>> a = ["Hello", "World", "!!!"]
=> ["Hello", "World", "!!!"]
>> a.join(" ")
=> "Hello World !!!"
>> a.join("\t")
=> "Hello\tWorld\t!!!"
```

+ We can create an array from strings using `split` method.
```ruby
>> a = %[Hello World !!!]
=> "Hello World !!!"
>> a.split(" ")
=> ["Hello", "World", "!!!"]

>> a = "1::@::#::$::%"
=> "1::@::#::$::%"
>> a.split("::")
=> ["1", "@", "#", "$", "%"]
```