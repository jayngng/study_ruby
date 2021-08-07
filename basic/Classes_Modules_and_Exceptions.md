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

# Getter/Setter through Metaprogramming
+ A powerful feature of Ruby is the ability to define getter/setter using Metaprogramming. Metaprogramming allows us to write, manipulate or generate programs at runtime.

```ruby
>> 
?> class SetterGetter
?>   attr_accessor :x,:y
>> end
=> nil
>> 
>> obj = SetterGetter.new
=> #<SetterGetter:0x0000564cce01baf0>
>> 
>> obj.x, obj.y = 100, 300
=> [100, 300]
>> 
>> print "\s", obj.x, "\s", obj.y
 100 300=> nil
```

+ With the `attr_accessor` keyword, Ruby silently defines **a getter and a setter** for us.
+ It requites a symbol notation but it defines a real instance variables `@x`, `@y`
+ With the `attr_reader` keyword, Ruby silently defines a getter for us.

```ruby
?> class QuickG
?>   attr_reader :x, :y
?>   
?>   def initialize(x,y)
?>     @x,@y = x, y
?>   end
>> end
=> :initialize
>> 
>> obj = QuickG.new(100,200)
=> #<QuickG:0x0000564ccdfcd940 @x=100, @y=200>
>> 
>> print "\s", obj.x, "\s", obj.y
 100 200=> nil
>> 
>> obj.x = 10
Traceback (most recent call last):
        4: from /usr/bin/irb:23:in `<main>'
        3: from /usr/bin/irb:23:in `load'
        2: from /usr/lib/ruby/gems/2.7.0/gems/irb-1.2.6/exe/irb:11:in `<top (required)>'
        1: from (irb):26
NoMethodError (undefined method `x=' for #<QuickG:0x0000564ccdfcd940 @x=100, @y=200>)
Did you mean?  x
```

+ Note that bc the setter has not been defined, so if we try to set x, we get `undefined method` error
+ `attr` is another useful keyword.
+ If used alone, it defines a getter while with `true` it defines a setter too

```ruby
>> 
?> class GS
?>   attr :x,true
?>   attr :y
?>   
?>   def initialize(x,y)
?>     @x, @y = x, y
?>   end
>> end
=> :initialize
>> 
>> obj = GS.new(100,200)
=> #<GS:0x0000564ccdf7a5d8 @x=100, @y=200>
>> 
>> obj.x
=> 100
>> 
>> obj.x = 50
=> 50
>> 
>> obj.x
=> 50
>> 
>> obj.y = 40
Traceback (most recent call last):
        4: from /usr/bin/irb:23:in `<main>'
        3: from /usr/bin/irb:23:in `load'
        2: from /usr/lib/ruby/gems/2.7.0/gems/irb-1.2.6/exe/irb:11:in `<top (required)>'
        1: from (irb):47
NoMethodError (undefined method `y=' for #<GS:0x0000564ccdf7a5d8 @x=50, @y=200>)
Did you mean?  y
```

<hr>

# Class methods
+ Ruby allows to define methods that are called on the class object instead of an instance object.
+ We have already said that `self` keyword always refers the current object.
+ So we can define methods that belong to the class object using it.

```ruby
>> 
?> class C1
?>   def self.hello
?>     print %!Hello there!
?>   end
>> end
=> :hello
>> 
>> C1.hello
Hello there=> nil
>> 
>> obj = C1.new
=> #<C1:0x0000557cea32f098>
>> 
>> obj.hello
Traceback (most recent call last):
        4: from /usr/bin/irb:23:in `<main>'
        3: from /usr/bin/irb:23:in `load'
        2: from /usr/lib/ruby/gems/2.7.0/gems/irb-1.2.6/exe/irb:11:in `<top (required)>'
        1: from (irb):11
NoMethodError (undefined method `hello' for #<C1:0x0000557cea32f098>)
```

+ As we can see, instance object of a C1 class doesn't have such a method. Therefore, it return `NoMethodError` exception,

+ We can define Class object instance variables with getter and setter too.

```ruby
#!/usr/bin/ruby

class ClassObject
  
  # class object @a constructor
  @a = 100

  # instance object getter for @a
  attr_reader :a
  
  # Class object getter/setter for @a
  def self.a=(val); @a = val; end # → Setter `a` of class object
  def self.a; @a; end # → Getter `a` of class object

  # instance object @a constructor
  def initialize(a); @a = a; end
end
```

```ruby
>> 
>> load 'ClassObject.rb'
=> true
>> 
>> obj = ClassObject.new(1234)
=> #<ClassObject:0x000055865dae7778 @a=1234>
>> 
>> obj.a
=> 1234
>> 
>> ClassObject.a
=> 100
>> 
>> ClassObject.a = 9001
=> 9001
>> 
>> obj.a
=> 1234
>> 
>> obj.a = 1413
Traceback (most recent call last):
        4: from /usr/bin/irb:23:in `<main>'
        3: from /usr/bin/irb:23:in `load'
        2: from /usr/lib/ruby/gems/2.7.0/gems/irb-1.2.6/exe/irb:11:in `<top (required)>'
        1: from (irb):13
NoMethodError (undefined method `a=' for #<ClassObject:0x000055865dae7778 @a=1234>)
Did you mean?  a
```

+ Because instance object `obj` in the above code are able to access read-only (`attr_reader`) instance variable `@a`, so when we try to set `a` (`obj.a=1413`), it returns error.

+ Class methods can be defined in a few other ways:
	+ Using the `self` keyword.
	+ Using the `<<` notation.

```ruby
#!/usr/bin/ruby

class Operation
  
  def Operation.add(a,b) # or def self.add
    a + b
  end

  class << Operation # or class << self

    def mul(a, b)
      a * b
    end

    # Other class methods

  end

end
```

```ruby
>> 
>> load 'classMethods.rb'
=> true
>> 
>> Operation.add(10,20)
=> 30
>> 
>> Operation.mul(10,20)
=> 200
```

+ The `<<` notation is useful when you work with classes that have been already defined.

```ruby
?> class << Operation
?>   def sub(a,b)
?>     a - b
?>   end
>> end
>> Operation.sub(200,100)
=> 100
>> 
```

<hr>

# Class variables
+ In the previous examples, the **class object instance variable @a** is not shared among the class instances (objects create with new)
+ A class variables must start with special characters `@@` and it is shared among all class instances.
+ It is accessible from **instance methods**, **class methods** and by the **class definition** itself.
+ They are encapsulated in the object that represent the class, the user of a class cannot access them from outside without getter/setter.
+ For example:

**MyClass** defines an instance variable @a accessible through a getter/setter created thanks to `attr` and a class variable `@@a` accessible through a `class_a` getter/setter.

```ruby
#!/usr/bin/ruby

class MyClass
  # Instance variable
  attr :a, true

  # class variable
  @@a = 200

  def class_a
    @@a
  end

  def class_a=(value)
    @@a = value
  end
  
end
```

```ruby
>> 
>> load './classVariables.rb'
=> true
>> 
>> obj1 = MyClass.new
=> #<MyClass:0x0000559942238e40>
>> obj2 = MyClass.new
=> #<MyClass:0x000055994216dcb8>
>> 
>> obj1.a, obj2.a = 200, 100
=> [200, 100]
>> 
>> obj2.class_a
=> 200
>> 
>> obj2.class_a = 10
=> 10
>> 
>> obj1.class_a
=> 10
>> 
>> obj1.class_a = 12313
=> 12313
>> 
>> obj2.class_a
=> 12313
>> 
>> print "\s", obj1.a, "\s", obj2.a
 200 100=> nil
```

<hr>

# Class Constants
+ To access a constant of a class, we can use `::` notation.
```ruby
?> class Constant
?>   C1 = "Hello World!!!"
?>   C2 = 1231321
>> end
=> 1231321
>> 
>> Constant::C1
=> "Hello World!!!"
>>
>> Constant::C2
=> 1231321
```

+ A constant can also be defined outside of a class definition.
+ In the example, we will create a new constant `C3` to demonstrate this concept.

```ruby
>> 
>> Constant.constants
=> [:C1, :C2]
>> 
>> Constant::C3 = "Password"
=> "Password"
>> 
>> MyClass.constants
=> []
>> Constant.constants
=> [:C3, :C1, :C2]
>> 
>> Constant::C3
=> "Password"
```

<hr>

# More about Classes
+ Classes are very flexible in Ruby. The following are some concepts that a good Ruby programmer need to know:
	+ Open Classes
	+ Operator Methods
	+ Mutable / Immutable Objects and Methods

#### Open Classes
+ Generally in conventional OO languages, when you close a class, you cannot add anything else in it, unless you use advanced technique and tools like reflection (https://en.wikipedia.org/wiki/Reflective_programming).
+ Instead, Ruby allows you to open a defined class in order to add other methods, constants and so on.
+ The following example will how to add a method to obtain the double if its size in the String class.

```ruby
>> 
?> class String
?>   def dsize
?>     self.size * 2
?>   end
>> end
=> :dsize
>> 
>> "Hello".size
=> 5
>> 
>> "Hello".dsize
=> 10
```

+ As we can see, it's very easy. The syntax is the same as defining a class. Since the String class already exists, the method `dsize` is added to it.

#### Operator Methods
+ Classes are often used to define new user data types.
+ When you define new data types, your want to define operations and operators for the type too, and you mat want to pre-defined and easy syntax operator like `+`, `-`, `*`, etc.
+ *Point* class represents a simple point in Euclidean geometry. 
+ For example: `p1(1,2) - p2(10,20)`
	+ We want an operation that sums two points. The standard operator for sum is `+`. We want that if:
		+ `p1(1,2)` and `p2(10,20)`
		+ then `p1 + p2 → (1 + 10), (2 + 20) → p3(11,20)` 
	+	The sum of two points returns a new point contains the sum of coordinates x and y

```ruby
#!/usr/bin/ruby

class Point
  
  attr :x,:y
  
  def initialize(x,y)
    @x = x
    @y = y
  end

  def +(other)
    Point.new(@x + other.x, @y + other.y)
  end

end
```

```ruby
>> 
>> load './point.rb'
=> true
>> 
>> p1 = Point.new(10,20)
=> #<Point:0x0000559219f2cc80 @x=10, @y=20>
>> 
>> p2 = Point.new(30,40)
=> #<Point:0x000055921a4ef7a8 @x=30, @y=40>
>> 
>> p3 = p1 + p2
=> #<Point:0x000055921a4c21e0 @x=40, @y=60>
>> 
>> p3.x
=> 40
>> 
>> p3.y
=> 60
```

#### Mutable / Immutable values
+ This new *Point* class creates mutable object value. Each coordinate has its own setter.
+ This time, the *plus* operator changes the first object and returns it as a result. A *Point* value can change its coordinate values using both the setters and plus operation. 

```ruby
#!/usr/bin/ruby

class Point
  
  attr :x, :y

  def initialize(x,y)
    @x, @y = x, y
  end

  def +(other)
    @x += other.x; 
    @y += other.y;
    self;
  end

end
```

+ This time, the *plus* operator changes the first object (`p1`) and returns it results.

```ruby
>> 
>> load './MutablePoint.rb'
=> true
>> 
>> p1 = Point.new(10, 20)
=> #<Point:0x0000556da1d580b8 @x=10, @y=20>
>> p2 = Point.new(20,30)
=> #<Point:0x0000556da1df1100 @x=20, @y=30>
>> 
>> p3 = p1 + p2
=> #<Point:0x0000556da1d580b8 @x=30, @y=50>
>> 
>> p3
=> #<Point:0x0000556da1d580b8 @x=30, @y=50>
>> 
>> p1
=> #<Point:0x0000556da1d580b8 @x=30, @y=50>
>> 
>> p2
=> #<Point:0x0000556da1df1100 @x=20, @y=30>
>> 
>> p1.object_id == p3.object_id
=> true
```

+ If we remember the `bang` methods (method that ends with exclamation mark `!`), it is the mutable method.