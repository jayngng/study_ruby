# Classes Principles
+ Define a class:

```ruby
class <Name>
	...<class body>...
end
```

+ Name **MUST** begin with a capital letter.

```ruby
?> class NewClass
?>   def printHello
?>     puts %!Hello World!
?>   end
>> end
=> :printHello
```

+ In order to instantiate an object, we can use the `new` construct provided by all classes.

```ruby
?> class NewClass
?>   def printHello
?>     puts %!Hello World!
?>   end
>> end
=> :printHello
>> 
>> myObj = NewClass.new
=> #<NewClass:0x000055f16dee27f8>
```

+ To invoke an object method, we simply call it.

```ruby
?> class NewClass
?>   def printHello
?>     puts %!Hello World!
?>   end
>> end
=> :printHello
>> 
>> myObj = NewClass.new
=> #<NewClass:0x000055f16dee27f8>
>> 
>> myObj.printHello
Hello World
```

<hr>

# Instance Variables
+ Instance variables are variables available only to each instance of the class, meaning that they change from object to object.
+ Since instance variables are encapsulated in any object of the class, they are not visible outside of it.
+ Note they are defined within class definition using the special character `@`. 
+ Instance variables are only accessible via the instance's public methods. So you have to define **accessors** methods to read them and **setters** methods to set them.
+ To initialize them, the default constructor method in Ruby is **initialize**.

```ruby
#!/usr/bin/ruby

class MyClass
  # Constructor method
  def initialize(a)
    @a = a
  end

  # Setter method
  def a=(value)
    @a = value
  end

  # Getter method
  def a
    @a
  end
end
```

+ The example shows how to load a ruby file and how to use the previous defined constructor, **getter** and **setter** of MyClass.

```ruby
>> load './MyClass.rb'
=> true
>> 
>> obj1 = MyClass.new(10)
=> #<MyClass:0x000055b9f616bda8 @a=10>
>> obj2 = MyClass.new(20)
=> #<MyClass:0x000055b9f61c7360 @a=20>
>> 
>> print obj1.a, "\s", obj2.a
10 20=> nil
>> 
>> obj2.a = 200
=> 200
>> obj1.a = 100
=> 100
>> 
>> print obj1.a, "\s", obj2.a
100 200=> nil
```

+ Aa we can see, `obj1` and `obj2` are separate from each other, the instance variable `@a` that is visible within the method of the object.

*Note:* with OO methodology, it's not best practice to provide a getter/setter for each instance variable. Use them only if they are **neccessary**.

+ A **wrong** example of define instance variables.

```ruby
#!/usr/bin/ruby

class WrongClass
  @a = 100
  
  # Getter method
  def a; @a; end

  # Setter method
  def a=(val); @a=val;end

end
```

+ Keep in mind that instance variables can only accessed by the instance methods of the object of that class. In other words, instance variable `a` can only be accessed by the method `getter` and `setter`.

```ruby
>> load './WrongClass.rb'
=> true
>> obj = WrongClass.new
=> #<WrongClass:0x000055b9f61a2f38>

>> print obj.a
=> nil
>> 

>> obj.a = 2000
=> 2000
>> print obj.a
2000=> nil
```

+ Therefore, the instruction `@a=4000` in the above example won't work as expected.

+ More explanations:
	+ The first `@a` is an instance variable that **belongs to the CLASS OBJECT**  (`WrongClass`) while the others are instance variables that **belong to INSTANCES of WrongClass**.
	+ It's a substantial differece, instances variables are resolved in the context of **self**. When invoke a method, **self** refers to an instance of a Class. Otherwise, inside a class but outside of method, **self** is the object that represents that Class.
	
+ So where is the `@a` of the class definition? It belongs to the class object WrongClass.

```ruby
>> load './WrongClass.rb'
=> true
>> WrongClass.instance_variables
=> [:@a]
>> WrongClass.instance_variable_get :@a
=> 100
>> WrongClass.instance_variable_set :@a, 500
=> 500
>> WrongClass.instance_variable_get :@a
=> 500
```



