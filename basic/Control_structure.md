# Basic Control Stuctures
#### 1. Comparison Operator
+ Some basic operators:
	+ `==`: equality.
	+ `.eql?`: OO operator style
	+ `>`, `<`, `>=`, `<=`

+ Others, Ruby also provide a combined comparison operator ( `<=>` )
	+ `a <=> b` returns:
		+ `0` if `a==b`
		+ `1` if `a > b`
		+ `-1` if `a < b`

```ruby
>> a = [1,2,3]
=> [1, 2, 3]
>> b = [1,0,4]
=> [1, 0, 4]
>> a <=> b
=> 1
```

#### 2. Conditionals
+ Ruby provides different conditionals with a lot of power and flexibility.
	+	`if` / `unless` statement (and all its variant)
	+	`unless` statement
	+	`case` statement
	+	Ternary operator

##### If
+ The most common conditional statement is if.

```ruby
root@jaeng-[~/Desktop/study_ruby/basic]# pygmentize if1.rb                                                                                                                               1 ⚙
#!/usr/bin/ruby

x = 10
if x > 5 then
  puts %!\n#{x} is greater than 5.\n!
end

# `then` can be removed with multi line if
if x < 11
  puts %!\n#{x} is less than 10.\n!
end
  
root@jaeng-[~/Desktop/study_ruby/basic]# ./if1.rb                                                                                                                                        1 ⚙

10 is greater than 5.

10 is less than 10.

```

+ Ruby also provides `elsif`  and `else` statements too.

```ruby
root@jaeng-[~/Desktop/study_ruby/basic]# pygmentize if2.rb                                                                                                                               1 ⚙
#!/usr/bin/ruby

x = 10
if x < 5 then
  puts %!\n#{x} is less than 5.\n!
elsif x > 2
  puts %!\n#{x} is greater than 2!
  if x > 9
    puts %[\n#{x} is also greater than 9]
  end
end
  
root@jaeng-[~/Desktop/study_ruby/basic]# ./if2.rb                                                                                                                                        1 ⚙

10 is greater than 2

10 is also greater than 9

```

+ If as s statement modifier avoids the use of the end keyword. It is very useful for single line conditionals.

```ruby
root@jaeng-[~/Desktop/study_ruby/basic]# pygmentize if3.rb                                                                                                                               1 ⚙
#!/usr/bin/ruby

x = 15

puts %!#{x} is greater than 10! if x > 10
puts %!#{x} is an integer! if x.is_a? Integer

str = "TEST"

puts %!#{str} is a string! if str.is_a? String
puts %!#{str} is a string! if str.is_a? Integer
  
root@jaeng-[~/Desktop/study_ruby/basic]# ./if3.rb                                                                                                                                        1 ⚙
15 is greater than 10
15 is an integer
TEST is a string

```


***IMPORTANT***:
+ In Ruby, everything is an expression (even if we call them statements). So every expression has a return value.
+ Expressions like `print` and `puts` have a return value too. (`nil` in this case).

##### Unless
+ Unless is opposite of `if`. It executes the associated code only if the conditional expression return `false` or `nil`

```ruby
root@jaeng-[~/Desktop/study_ruby/basic]# pygmentize unless.rb             1 ⚙
#!/usr/bin/ruby

x = 10
unless x == 11 then
  print %[There is no way #{x} is equal to 11!]
end
  
root@jaeng-[~/Desktop/study_ruby/basic]# ./unless.rb                                                                                                                                     1 ⚙
There is no way 10 is equal to 11!                                                                                                                                                           
```

##### Case
+ The `case` statement will find a condition until it returns true, otherwise the final else is executed.

```ruby
>> x = 5
=> 5
>> case x
 | when x = 1 then print %!one!  
 | when x = 2 then print %!two!  
 | when x = 5 then print %!five!  
 | end  
five=> nil
```

+ Note that `case` is an expression so its return value can be used in the scripts. In the following examples, we assign the return value to a variable.

```ruby
>> id = 1000
=> 1000
>> user =  case id
 | when 1001 then %!smar!  
 | when 0 then %!root!  
 | when 1000 then %!aye!  
 | end  
=> "aye"
```

```ruby
>> id = 1000
=> 1000
>> name = case
 | when id == 1001 then %!bob!  
 | when id != 1001 then %!not bob!  
 | end  
=> "not bob"
```

+ The *equality operator* `===` is useful to work with **Ranges**.

```ruby
>> (1..10) === 4
=> true
>> (1..10) == 4
=> false
>> ("hello".."hellz")  === ("hellp")
=> true
```

+ Note that the parenthesis () are required.

```ruby
>> x = 10
=> 10
>> case x
 | when Integer then "int"  
 | else "Unknown"  
 | end  
=> "int"
```

+ Another way to define if statements is by using the "**ternary operator**", which allows us to define a complete `if-then-else` statement in one line. The syntax to use is the following:

```ruby
>> test_expr ? true_expr : false_expr
```

+ Examples:

```ruby
>> user = %!jae!
=> "jae"
>> user == %!jae! ? %!Hi jae! : %!Unknown user!
=> "Hi jae"

>> user = "bob"
=> "bob"
>> user == %!jae! ? %!Hi jae! : %!Unknown user!
=> "Unknown user"
```

##### Loops
+ `while` loop: repeats a block of code until the test expression is evaluated to *false*

```ruby
>> i = 0
=> 0
>> while i < 5 do
 |   print %!#{i}\n!  
 |   i += 1  
 | end  
0
1
2
3
4
=> nil
```

```ruby
>> array = ["a", "b", "c"]
=> ["a", "b", "c"]
>> print array.pop, "\s" while !array.empty?
c b a => nil
```

+ `until` loop: repeats a block of Ruby code until the test expression is evaluated to *true*

```ruby
>> i = 5 
=> 5
>> until i == 0 do
 |   print i -= 1, "\s"
 | end  
4 3 2 1 0 => nil
```

```ruby
>> i = 5
=> 5
>> print i -= 1, "\s" until i == 0
4 3 2 1 0 => nil
```

+ `for` loop: iterates through the elements of an enumerable object.

```ruby
>> for i in (10..20) do
 |   print i, "\s"  
 | end  
10 11 12 13 14 15 16 17 18 19 20 => 10..20
```

+ It is important to know that a **Collection** is every object that has the "each" iterator method. Many Ruby objects such as arrays, hashes and ranges define each method and they can used to iterate into a for loop.

+ This means that if you have a hash object, `for` allows you to iterate through each ket and value of the hash.
 
```ruby
>> hash = {"name"=>"Jay","age"=>"10","sex"=>"male"}
=> {"name"=>"Jay", "age"=>"10", "sex"=>"male"}

>> for key,value in hash
 |   print key, ": ", value, "\n"  
 | end  
name: Jay
age: 10
sex: male
=> {"name"=>"Jay", "age"=>"10", "sex"=>"male"}
```

##### Iterators & Enumerators
+ An iterator is a **method** that allows us to loop through the members of a collection
+ It interacts with the block of code that follows it.
+ The most common collection iterator is `each`. It is simplicity called by the `for` statement.

```ruby
>> (1..5).each { |i| print i*2, "\s" }
2 4 6 8 10 => 1..5

# The block between the braces {} is executed for each value of the range.
# |i| notation means that each passes to the block each value of the range as a parameter, which is accessible in the block using the i identifier.
```

```ruby
?> ("a".."z").each do |c|
?>   print c, "\s"
>> end
a b c d e f g h i j k l m n o p q r s t u v w x y z => "a".."z"
```

+ Objects that are not collections can use `each` method too.
+ Statements such as `times`, `upto`, `downto` are very popular Integer iterator methods in Ruby.

```ruby
>> 4.upto(10).each { |i| print i, "\s" }
4 5 6 7 8 9 10 => 4
>> 5.downto(1).each { |i| print i, "\s"}
5 4 3 2 1 => 5
>> 3.times.each { print "Hello"}
HelloHelloHello=> 3
>> 3.times { |i| print i, "\s"}
0 1 2 => 3
```


##### Enumerable objects

+ Statement like `collect`/`map`, `select`, `reject`, `inject` are iterators too.
+ Each of them can be used either to domify the original collection or to create a new collection starting from the original.

+ `collect/map`
```ruby
>> array = [1,2,3,4]
=> [1, 2, 3, 4]

>> array.map {|i| i**2}
=> [1, 4, 9, 16]
>> array.map! {|i| i**2}
=> [1, 4, 9, 16]
```

+ `select`
```ruby
>> array
=> [1, 4, 9, 16]
>> array.select { |x| x%3 == 0 }
=> [9]
>> array.select {true}
=> [1, 4, 9, 16]
>> array.select {false}
>> []
```

+ `reject`

```ruby
>> array
=> [1, 4, 9, 16]
>> array.reject { |x| x%3 === 0 }
=> [1, 4, 16]
>> array.reject {true }
=> []
>> array.reject {false}
=> [1, 4, 9, 16]
```

+ `inject`
+ The block associated to inject has two arguments:
	+ The first is an accumulator from the previous iteration
	+ The second is the next element of the enumerable object.

```ruby
>> array
=> [1, 4, 9, 16]
>> array.inject {|mul,x| mul * x}
=> 576
>> array.inject {|mul,x| mul + x}
=> 30
```

##### Enumerator
+ An enumerator is an object whose purpose is to enumerate another enumerable object. This means that enumerators are enumerable too.

```ruby
>> array.map
=> #<Enumerator: [1, 4, 9, 16]:map>
>> array.each
=> #<Enumerator: [1, 4, 9, 16]:each>
>> array.select
=> #<Enumerator: [1, 4, 9, 16]:select>
```

+ Basically, an enumerator wraps the iteration.
+ They can also be explicitly created using the `to_enum` or `enum_for` method.
+ Its useful in situations where you do not want to use the original enumerable objects.

#### 3. External iterators
+ Enumerator objects allow you to control the iteration by yourself so you can create what is called external iterators.

```ruby
>> enum = array.to_enum
=> #<Enumerator: [1, 4, 9, 16]:each>
>> enum.next
=> 1
>> enum.next
=> 4
>> enum.next
=> 9
>> enum.next
=> 16
>> enum.next
```

#### 4. Altering structured control flow
+ Ruby can alter the behavior of iterators and structured statements such as `while`, `until`, `for`, etc. using some special statements like:

+ `break`

```ruby
?> for i in 1..10
?>     print %!#{i}!,"\s"
?>     break if i == 2
>> end
1 2 => nil
```

```ruby
?> (1..5).each do |i|
?>   print i, "\s"
?>   break if i == 3
>> end
1 2 3 => nil
```

+ `next`

```ruby
?> for i in 1..4
?>     next if i == 3
?>     print i, "\s"
>> end
1 2 4 => 1..4
```

```ruby
?> (1..5).each do |i|
?>   next if i == 3
?>   print i, "\s"
>> end
1 2 4 5 => 1..5
```

3 doesn't print

+ `redo`: restarts the current iteration from the first instruction in the body of the loop or iteration
+ In the example, `for i=1` is executed twice.

```ruby
>> sum = 0
=> 0
?> for i in 1..3
?>     sum += i
?>     redo if sum==1
>> end
=> 1..3
>> sum
=> 7
>> 1 + 2 + 3
=> 6
```

##### Some consideration
+ When execute `break` where is the returned value?

```ruby
?> for i in 1..5
?>     i += 1
?>     break if i == 3
>> end
=> nil # Where is the return value?
```

```ruby
?> (1..8).inject do |sum,x|
?>   break if x == 3
?>   sum + x
>> end
=> nil
```

+ Consider these codes
+ We will break  `i` so that we have a returned value.
```ruby
?> for i in 1..5
?>     i += 1
?>     break i if i == 3
>> end
=> 3
```

```ruby
?> (1..8).inject do |sum,x|
?>   break sum if x == 3
?>   sum + x
>> end
=> 3
```

+ Devided by 0 error

```ruby
>> array = [1000, 100, 0, 2]
=> [1000, 100, 0, 2]
>> array.map {|i| 1000/i }
Traceback (most recent call last):
        7: from /usr/bin/irb:23:in `<main>'
        6: from /usr/bin/irb:23:in `load'
        5: from /usr/lib/ruby/gems/2.7.0/gems/irb-1.2.6/exe/irb:11:in `<top (required)>'
        4: from (irb):126
        3: from (irb):126:in `map'
        2: from (irb):126:in `block in irb_binding'
        1: from (irb):126:in `/'
ZeroDivisionError (divided by 0)
>> 
```

+ Using `next` to solve the problem

```ruby
>> array = [1000, 100, 0, 2]
=> [1000, 100, 0, 2]
?> array.map do |i|
?>   next if i == 0
?>   100000 / i
>> end
=> [100, 1000, nil, 50000]

?> array.map do |i|
?>   next "10000/0 error" if i == 0
?>   100000 / i
>> end
=> [100, 1000, "10000/0 error", 50000]
```

#### 5. Begin / End
+ BEGIN and END are two reserved word in Ruby
	+ BEGIN allows the execution of Ruby code at the beginning of a Ruby program
	+ END allows the execution if Ruby at the end of Ruby program.

Note that Ruby code must be enclosed by braces.
+ Examples:

```ruby
#!/usr/bin/ruby

BEGIN {
  puts "\nBeginning of the code\n"
}

END {
  puts "\nEnding of the code\n"
}

puts "Normal control flow"
```

```ruby
root@jaeng-[~/Desktop/study_ruby/basic]# ./begin_end.rb                                                                                                                                   1 ⚙

Beginning of the code
Normal control flow

Ending of the code
```

Note:
+	If there are more than one BEGIN block, they are executed following the order.
+	END block will execute in a reverse order.

```ruby
#!/usr/bin/ruby

BEGIN { puts 1}
BEGIN { puts 2}
BEGIN { puts 3}
END {puts 4}
END {puts 5}
END {puts 6}
```

```ruby
root@jaeng-[~/Desktop/study_ruby/basic]# ./begin_end_order.rb                                                                                                                             1 ⚙
1
2
3
6
5
4
```