# Methods
+ A method is a block of code with a name. The block of code is parameterized (arguments) so it can use parametric values at each invocation.
+ Therefore, in a method invocation, you must specify the name of the methods and some values for its parameters (arguments.)

#### 1. Simple method definitions

+ The general syntax of Ruby method is:

```ruby
def <code_name>(<args>)
	...<code_block>...
end
```

→ `args`: can be empty
→ `code_block`: block of instructions that have to be executed. It may also have a returned value.

+ Examples:
```ruby
#!/usr/bin/ruby

def double()
  puts %!Enter a number: !
  number = gets.chomp
  return %!→ Result: !, number.to_i * 2
end

puts double()
---------
# ./method.rb
Enter a number: 
10
→ Result: 
20
```

#### 2. Alias
+ Note that Ruby allows one to define aliases for methods.
+ This is helpful if you want to have a method with a more natural and expressive name.
```ruby
?> def im_a_long_method_name
?>   puts %!Hello World <3!
>> end

>> im_a_long_method_name()
Hello World <3

>> alias short im_a_long_method_name
=> nil

>> short()
Hello World <3
=> nil
```

+ Alias are commonly used as a backup in order to extend the ability or functionality of a method.

```ruby
?> def a_method
?>   puts "This is just a backup method"
>> end
=> :a_method
>> 
>> alias backup a_method
=> nil
>> 
?> def a_method
?>   puts %!Some texts here!
?>   backup()
?>   puts %!Some texts after!
>> end
=> :a_method
>> 
>> a_method()
Some texts here
This is just a backup method
Some texts after
=> nil
```


#### 3. Parameters default values

+ You can also specify a default values for parameters of your methods.

```ruby
?> def print_age(age="Unknown age")
?>     print "Your age is:\s" + age + "\s"
>> end
=> :print_age
>> 
>> print_age("10")
Your age is: 10 => nil
>> print_age()
Your age is: Unknown age => nil
```

#### 4. Variable length arguments
+ In Ruby, you can create a method that is able to handle variable length arguments as parameters.
+ You have to add an `*` before one (and only one) of the parameters of your method.
+ Then you can call the method with whatever arguments you want. The parameter with `*` captures them as an array.

For examples, in the following code, the first argument is captured by *first*. But all the other are captured by the *others* parameter which is actually an array of arguments.

```ruby
?> def ctparam(first, *others)
?>   puts %!First argument: ! + first.to_s
?>   puts %!Others argument: ! + others.to_s
>> end
 
>> ctparam(1,2)
First argument: 1
Others argument: [2]

>> ctparam(1,2,4,5,6,7)
First argument: 1
Others argument: [2, 4, 5, 6, 7]
```

+ You can also use the special character `*` in method invocation too.
+ It expands an array so that each element becomes the parameter of the method. 

```ruby
?> def sum(a,b)
?>   print a + b
>> end
=> :sum
>> 
>> sum(1,2)
3=> nil
>> sum *[1,2]
3=> nil
```

#### 5. Hashes as arguments
+ With hashes, you can invoke a method specifying explicitly (at calling time) the name of arguments.

```ruby
?> def printPerson(person)
?>   puts %!Name: ! + person['Name']
?>   puts %!Age: ! + person['Age']
>> end
=> :printPerson
>> 
>> printPerson({"Name"=>"Jay", "Age"=>"25"})
Name: Jay
Age: 25
=> nil
```

+ Or we can even do it in a shorter way.

```ruby
?> def printPerson(person)
?>   name = person[:name] || "Unknown name"
?>   age = person[:age] || "Unknown age"
?>   gender = person[:gender] || "Unknown gender"
?>   print %!Name: #{name}\nAge: #{age}\nGender: #{gender}!
>> end
=> :printPerson
>> 
>> printPerson name:"Jay",age:"25",gender:"Male"
Name: Jay
Age: 25
Gender: Male=> nil
```

#### 6. Block arguments
+ In Ruby, any method invocation can be followed by a block of Ruby code.
+ Inside a method, we can invoke the code in the block with the `yield` statement.

```ruby
?> def med
?>   puts %!This is a method!
?>   yield
?>   puts %!This is another method!
?>   yield
>> end
=> :med
>> med { puts %!This is another block of code inside the method med!} # We invoke a block of code inside a method. We can call this block of code using `yield
This is a method
This is another block of code inside the method med
This is another method
This is another block of code inside the method med
=> nil
```

```ruby
?> def double(x)
?>   yield x*2
>> end
=> :double
>> 
>> double(2) {|i| print i}
4=> nil
>> double(2)
Traceback (most recent call last):
        5: from /usr/bin/irb:23:in `<main>'
        4: from /usr/bin/irb:23:in `load'
        3: from /usr/lib/ruby/gems/2.7.0/gems/irb-1.2.6/exe/irb:11:in `<top (required)>'
        2: from (irb):126
        1: from (irb):122:in `double'
LocalJumpError (no block given (yield))

# If we call a yield method without giving it a block of code, the error is raised
```

+ Yield is  often used with iteration. Here, we'll see an interesting example:

```ruby
?> def divide_3(x)
?>    for i in 1..x
?>        yield i if i%3==0
?>    end
>> end
=> :divide_3
>> 
>> divide_3(15) {|x| print x.to_s, "\s"}
3 6 9 12 15 => 1..15
```

+ Instead of using `yield`, Ruby allows you to pass a block as an argument. With this strategy, the block becomes an instance of the *Proc*  class, and you have to use `call` instead of `yield` to transfer the control of it.
+ To specify that an argument will be a *Proc* object that encapsulates a block, you must use the ampersand (`&`) in method definition.

```ruby
?> def square(x, &c)
?>   for i in 1..x
?>       c.call(i**2)
?>   end
>> end
=> :square

>> square(5) { |x| puts x }
1
4
9
16
25
=> 1..5

>> square(5) { |x| print x, "\s" }
1 4 9 16 25 => 1..5
```

+ It is useful where you have a method that uses `yield` and you want to specify a block as a parameter instead of defining it inline.

```ruby
>> square(5) { |x| print x, "\s" }
1 4 9 16 25 => 1..5
```

```ruby
>> sums = Proc.new { |sum,x| sum+x**2 }
=> #<Proc:0x0000560fce547d68 (irb):165>
>> (1..3).inject(0,&sums)
=> 14
```

```ruby
>> square = Proc.new { |x| print x**2, "\s" }
=> #<Proc:0x0000560fce0f2268 (irb):167>
>> 
?> def double(x,proc)
?>   for i in 1..x
?>       proc.call(i)
?>   end
>> end
=> :double
>> 
>> double(10, square)
1 4 9 16 25 36 49 64 81 100 => 1..10
```