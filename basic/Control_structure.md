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
root@jaeng-[~/Desktop/study_ruby/basic]# pygmentize unless.rb                                                                                                                            1 ⚙
#!/usr/bin/ruby


x = 10
unless x == 11 then
  print %[There is no way #{x} is equal to 11!]
end
  
root@jaeng-[~/Desktop/study_ruby/basic]# ./unless.rb                                                                                                                                     1 ⚙
There is no way 10 is equal to 11!                                                                                                                                                           
```

##### Case