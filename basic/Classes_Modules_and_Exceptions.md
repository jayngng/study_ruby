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

<hr>

# Method Visibility
#### Private Methods
+ You can define both private instance methods and private class methods.
+ Private instance methods can only be called by the other instance methods of the class (and subclass). You cannot call them from outside an object.
+ A famous Ruby method is `initialize`, you cannot call it from outside:
	+ `obj.initialize # → This is not possible`

+ Note: `initialize` is an exception because in Ruby all methods are public by default.
+ **Private instance methods** are defined using the `private` keyword.

```ruby
#!/usr/bin/ruby

class AClass
  # Public methods
  def getName
    privateName
  end

  # Private methods
  private

    def privateName
      "I'm a class"
    end

end
```

```ruby
>> load './PrivateInstanceMethod.rb'
=> true
>> 
>> obj = AClass.new()
=> #<AClass:0x000055666d0e1568>
>> 
>> obj.getName
=> "I'm a class"
>> 
>> obj.privateName
Traceback (most recent call last):
        4: from /usr/bin/irb:23:in `<main>'
        3: from /usr/bin/irb:23:in `load'
        2: from /usr/lib/ruby/gems/2.7.0/gems/irb-1.2.6/exe/irb:11:in `<top (required)>'
        1: from (irb):8
NoMethodError (private method `privateName' called for #<AClass:0x000055666d0e1568>)
Did you mean?  private_methods
```

+ Sometimes, it may be useful to specify a class method as private.
+ For example, if you want to use particular design patters that must use this feature.
+ To do this, you can use `private_class_method` keyword.

```ruby
#!/usr/bin/ruby

class AClass
  # Public methods
  def self.getName
    privateName
  end

  def self.privateName
      "I'm a class"
  end

  # Specify private methods
  private_class_method :privateName

end
```

```ruby
>> load './PrivateInstanceMethod2.rb'
=> true
>> 
>> AClass.getName
=> "I'm a class"
>> 
>> AClass.privateName
Traceback (most recent call last):
        4: from /usr/bin/irb:23:in `<main>'
        3: from /usr/bin/irb:23:in `load'
        2: from /usr/lib/ruby/gems/2.7.0/gems/irb-1.2.6/exe/irb:11:in `<top (required)>'
        1: from (irb):14
NoMethodError (private method `privateName' called for AClass:Class)
Did you mean?  private_methods
```

#### Protected Methods
+ Protected methods work as private methods but protected methods may be called by any isntance of the defining class or its subclass.

```ruby
#!/usr/bin/ruby

class MyClass
  
  def useProtected
    obj = MyClass.new
    obj.getProtected
  end

  protected

  def getProtected
    "I'm a protected method"
  end

end
```

```ruby
>> load "./ProtectedClassMethods.rb"
=> true
>> 
>> obj = MyClass.new()
=> #<MyClass:0x000055666cb71218>
>> 
>> obj.useProtected
=> "I'm a protected method"
>> 
>> obj.getProtected
Traceback (most recent call last):
        4: from /usr/bin/irb:23:in `<main>'
        3: from /usr/bin/irb:23:in `load'
        2: from /usr/lib/ruby/gems/2.7.0/gems/irb-1.2.6/exe/irb:11:in `<top (required)>'
        1: from (irb):21
NoMethodError (protected method `getProtected' called for #<MyClass:0x000055666cb71218>)
Did you mean?  getProtected
```

#### A full view
+ When you define a complex class with private/protected methods, it should look something like this:

```ruby
#!/usr/bin/ruby


class ComplexClass

  # Public instance methods
  

  protected
  # Protected instance methods


  private
  # Private instance methods


  class << self

    # Public class methods
    

    protected
    # Protected class methods

    
    private
    # Private class methods
    
  end
  
end
```

+ Visibility keyword does not apply to constants, instance, or class variables. Constants are public while instance/class variables are private.

<hr>

# Subclassing & Inheritance
+ Ruby provide a mechanism to extend a class in order to modify its behavior or add new functionalities.
+ This is called subclassing.

#### Simple extensions
+ Extending a class is very simple, we just use the `<` operator. A class inherits all superclass methods.

```ruby
#!/usr/bin/ruby

class A

  attr :name

  def getName
    @name
  end

  def initialize(name)
    @name = name
  end

end

class B < A
end
```

```ruby
>> load 'Subclassing.rb'
=> true
>> 
>> objb = B.new("Jay")
=> #<B:0x000055666d1b4ff8 @name="Jay">
>> 
>> objb.getName
=> "Jay"
>> 
```

+ As we can see, class `B` has inherited all `A` class's methods and the `initialize` constructor too.

#### Methods overriding
+ We can specify a class in Ruby in order to define new methods or override existing methods.
+ You can override all methods: public, protected and private (initialize constructor too).

**PAY ATTENTION:** subclassing is strongly discoraged if you do not properly know the superclass that you want to extend. You might override some private methods that are fundamental for the class to work properly.

```ruby
#!/usr/bin/ruby

class Person

  attr :name

  def initialize(name)
    @name = name
  end

  def to_s
    "I'm #{@name}."
  end

end

class Vn < Person
  
  def to_s
    "Vn #{@name}"
  end

end
```

```ruby
>> load 'Person.rb'
=> true
>> 
>> persona = Person.new("John")
=> #<Person:0x000055666d227238 @name="John">
>> 
>> persona.to_s
=> "I'm John."
>> 
>> personb = Vn.new("Jay")
=> #<Vn:0x000055666cdecce0 @name="Jay">
>> 
>> personb.to_s
=> "Vn Jay"
>> 
```

#### Specialize a method
+ Often when you extend  a class, you want to specialize the behaviors of some methods.
+ The `super` keyword helps us to avoid the complete redefinition of method behavior.
+ With `super`, you can call the method of the superclass.
```ruby
#!/usr/bin/ruby

class Vehicle

  def initialize(type)
    @type = type
  end

  def to_s
    "I'm a #{@type} vehicle"
  end

end

# ---------------------------------------

class Car < Vehicle
  
  def initialize
    super("land")
  end

  def to_s
    super + ". I'm a car."
  end

end
```

+ You can use `super` with or without arguments according to the supperclass method called.

```ruby
>> 
>> load './Vehicle.rb'
=> true
>> 
>> sea_t = Vehicle.new("sea")
=> #<Vehicle:0x00005593b010a2b8 @type="sea">
>> 
>> sea_t.to_s
=> "I'm a sea vehicle"
>> 
>> car_t = Car.new
=> #<Car:0x00005593afe6fda0 @type="land">
>> 
>> car_t.to_s
=> "I'm a land vehicle. I'm a car."
```

+ Both `initialize` and `to_s` of Car class use the super version of those methods.

#### Instance and Class Variables
+ Inheritance does not affect instance variables.
+ This holds because an instance variable by definition is created by the methods that first initialize it.
+ In Ruby, a class does not define the set of fields for its object instances like Java or other OO languages.
+ Considering the following code:

```ruby
#!/usr/bin/ruby

class Vehicle

  def initialize(type)
    @type = type
  end

  def to_s
    "I'm a #{@type} vehicle"
  end

end

# ---------------------------------------

class Car < Vehicle
  
  def initialize
    super("land")
  end

  def to_s
    super + ". I'm a car."
  end

end
```

+ The above code is perfectly legal. Car initialization defines instance variable `@type`. Therefore, `@type` is not inherited.
+ Always remembner that **inheritance does not affect instance variables**.
+ Therefore, if you use an instance variable defined in a superclass, you must pay attention because other superclass methods can use the same variables and you might introduce bugs or change the superclass method behavior.
+ Remember that class variables are shared and visible from **instance methods**, **class methods** and by the **class definition** itself.
+  These rules apply to both classes and its subclasses.

Therefore, if a class `A` defines a global variable `@@a` and `B` is an subclass of `A`, `B` and its instances can use the same `@@a` variable:
	+ `@@a` is shared among `A` and `B` (classes and instances). Any `@@a` changes affect all the objects that may use it.
	
```ruby
#!/usr/bin/ruby

class A
  @@a = 100

  def class_a; @@a; end
  def class_a=(v); @@a = v; end

  class << self
    def class_a; @@a; end
    def class_a=(v); @@a = v; end
  end

end
# ---------------------------------

class B < A
end
```
```ruby
>> load './ClassVInheritance.rb'
=> true
>> 
>> A.class_a
=> 100
>> 
>> B.class_a
=> 100
>> 
>> a = A.new
=> #<A:0x00005593b00e1e08>
>> 
>> b = B.new
=> #<B:0x00005593b0132128>
>> 
>> b.class_a = 500
=> 500
>> 
>> A.class_a
=> 500
>> 
>> B.class_a
=> 500
>> 
>> a.class_a
=> 500
```

#### Constants
+ Constants have a particular behavior when used with inheritance. They are inherited and they can be overriden.
+ When we try to override an inherited constant, Ruby will create a new one with the same name but available only for the subclass.
```ruby
>> 
?> class A
?>   CONST = 100
>> end
=> 100
>> 
?> class B < A
?>   CONST = 200
>> end
=> 200
>> 
>> A::CONST
=> 100
>> B::CONST
=> 200
```

*Note*: There is a strange behavior when we use inherited constants
+	Ruby first looks up a class constant in its lexical scope rather than in the inherited chain. An **inherited method** (not overriden) **always** uses the **superclass constant** even if it is overriden in the subclass.

```ruby
#!/usr/bin/ruby

class A
  
  CONST = 100

  def getConst; CONST; end
  
end

class B < A
  CONST = 200
end
```

```ruby
>> 
>> load './ConstantInheritance.rb'
=> true
>> 
>> A.getConst
>> 
>> a = A.new
=> #<A:0x00005591820824d8>
>> 
>> a.getConst
=> 100
>> 
>> b = B.new
=> #<B:0x00005591826b2dd0>
>> b.getConst
=> 100
```

#### Private Methods
+ If we remember the `private` keyword, it is used to hide a method from the outside world.
+ A private method can be used inside inherited classes.
```ruby
#!/usr/bin/ruby

class A
  
  private
  
  def getPrivate
    "This is a private method!"
  end

end

class B < A
  def printPrivate
    getPrivate
  end

end
```

```ruby
>> 
>> load 'PrivateInheritance.rb'
=> true
>> 
>> b = B.new
=> #<B:0x0000561392cc2828>
>> 
>> b.printPrivate
=> "This is a private method!"
>> 
```

#### Protected Methods
+ In Ruby, **protected** methods work like private methods. They are inherited and can be used the same way as private methods.
+  The only difference is that you have to use them in a explicit way (`object.method` notation) when used **inside** (and not outside) a class or subclass.

```ruby
#!/usr/bin/ruby

class A
  
  protected
  
  def getProtected
    "This is a protected method!"
  end
  
end

class B < A
  def printProtected
    obj = A.new
    obj.getProtected
  end
end
```

```ruby
>> 
>> load 'ProtectedInheritance.rb'
=> true
>> 
>> b = B.new
=> #<B:0x00005613926e5680>
>> 
>> b.printProtected
=> "This is a protected method!"
>> 
```

<hr>

# Modules
+ A module is used in Ruby to define namespaces and mixins.
+ A module is essentially a collection of methods, constants and class variables with a name.
+ The main differences between classes and modules are:
	+ Modules cannot be instantiated.
	+ They cannot be subclassed, therefore there is not a module hierarchy.

+ A module object is an instance of the **Module** class.
+ **Class** is a subclass of **Module**, therefore all classes are modules too but not vice versa.

#### Namespace
+ Module can be used to define a new custom namespace for methods and constants.
+ A **namespace** is a way to collect and bind related methods and constants, giving them a name that helps you to use them.
+ `Math` is the example of modules used as namespace
	+ It is a collection of mathematical constants (PI and E) and methods, especially for basic trigonometric and transcendental functions.

```ruby
#!/usr/bin/ruby

module MyMath
  
  PI = 3.14
  E = 2.72
  
  def MyMath.exp(x)
    E**x
  end
  
end
```

```ruby
>> 
>> load 'namespace.rb'
=> true
>> 
>> MyMath::PI
=> 3.14
>>
>> MyMath::E
=> 2.72
>> 
>> MyMath.exp(4)
=> 54.73632256000002
```

+ Module and namespaces allow you to define custom Libraries: collection of constants, methods, classes, other modules and so on.
+ Note that modules and classes are handled by Ruby by looking at their name. These names are constant so you can define classes and modules inside a module and create a hierachies of libraries.
+ This stratefy is often used by third-party libraries.
+ You use them by including the third party custom module and they provide you a hierarchies of methods, constants. classes and more/
+ This avoids collisions between their function and yours.

#### Mixin
+ **Mixin** is powerful feature implemented in Ruby.
+ Mixin means that if a module defines instance methods (instead of class methods), those instance methods can be mixed into another class, the implementation of the class and the module are joined.
+ In order words, any instance of the destination class includes module methods as their instance methods.
+ To mix a module into a class, simply use the `include` keyword.
+ Example:

```ruby
#!/usr/bin/ruby


module A
  def self.printHello
    "Hello World"
  end

end

class B
  include A
  
  def callHello
    A.printHello
  end

end
```

+ Module A is mixed with B class. The method `printHello` is available inside instances A class as a simply instance method.

```ruby
>> 
>> load 'mixin.rb'
=> true
>> 
>> b = B.new
=> #<B:0x000055eb308418b0>
>> 
>> b.callHello
=> "Hello World"
>> 
```

+ Another example:
```ruby
#!/usr/bin/ruby

module B
  def hello; "Hello"; end
end

class A
  include B
  def world; "World"; end
end
```

```ruby
>> 
>> load 'mixin2.rb'
=> true
>> 
>> obj = A.new
=> #<A:0x0000562b6a34d618>
>> 
>> print obj.hello, "\s", obj.world
Hello World=> nil
>> 
```

 + Two useful Ruby modules designed for mixin are **Comparable** and **Enumerable**.
 + If your class defines the operator `<=>`, you can include *Comparable* to get for free operation like `<`, `<=`, `==`, `>`, `>=` and `between?`.

+ Same thing with *Enumerable*. If it is mixed with your class, it gives you `sort`, `find`, `min`, `max`, etc... without the need to implement them.
+ The Ruby platform provides other usable classes as well. Each one requires that your target class implements some methods in order to work correctly. For example, *Enumerable* requires the method `each` and `<=>` for some operations.

<hr>

# Exception
+ Another important class you need to know is `Exception`.
+ Sometimes, something can go wrong in a program. Imagine a division by 0, it will generate an error.

#### Raise
+ Exceptions are objects but they are usually created with the method **raise** (instead of new). Nothing prevents you from creating them with new but good programming styles suggests avoiding it.

+ `raise` alone creates a *RuntimeError*

```ruby
>> raise
Traceback (most recent call last):
        4: from /usr/bin/irb:23:in `<main>'
        3: from /usr/bin/irb:23:in `load'
        2: from /usr/lib/ruby/gems/2.7.0/gems/irb-1.2.6/exe/irb:11:in `<top (required)>'
        1: from (irb):7
RuntimeError ()
```

#### RuntimeError
+ *RuntimeError* objects can be created using raise. Note that you can specify a string argument to associtate them.

```ruby
>> raise
RuntimeError: 
from (pry):1:in `__pry__'
>> 
>> raise "A runtime error"
RuntimeError: A runtime error
from (pry):2:in `__pry__'
```

#### Other Errors
+ With `raise`, you can specify the Error type too.
```ruby
>> 
>> raise ArgumentError 
ArgumentError: ArgumentError
from (pry):3:in `__pry__'
>> 
>> raise ArgumentError, "Invalid Argument"
ArgumentError: Invalid Argument
from (pry):4:in `__pry__'
```

+ Example:

```ruby
>> 
>> def sum(a,b)
 |   raise(ArgumentError, "a is not an integer!") if !a.is_a?Integer
 |   raise(ArgumentError, "b is not an integer!") if !b.is_a?Integer
 |   a + b
 | end  
=> :sum
>> 
>> sum(10,20)
=> 30
>> 
>> sum("A",5)
ArgumentError: a is not an integer!
from (pry):6:in `sum'
>> 
>> sum(5,"b")
ArgumentError: b is not an integer!
from (pry):7:in `sum'
```

#### Custom Error
+ *ArgumentError*, *RuntimeError*, *ZeroDivisionError* are subclasses of *StandardError*.
+ If you want to create a new custom error yourself, you can do that by inheriting from *StandardError*.
+ Lets see how we can create a custom *NoIntError* error.
```ruby
>> 
>> class NoIntError < StandardError; end
=> nil
>> 
>> def sum(a,b)
 |   raise(NoIntError, "a is not an integer!") if !a.is_a?Integer  
 |   raise(NoIntError, "b is not an integer!") if !b.is_a?Integer  
 |   a + b
 | end  
=> :sum
>> 
>> sum 10,"s"
NoIntError: b is not an integer!
from (pry):17:in `sum'
>>
>> sum "s",10
NoIntError: a is not an integer!
from (pry):16:in `sum'
>> 
```

#### Rescue
+ If you want to handle an exception and execute some arbitrary code when it happens, you can also use `rescue`.
+ Example:

```ruby
#!/usr/bin/ruby

def fact(n)
  return 1 if n==0
  return 1 if n==1
  n * fact(n - 1)
end

begin
  a = fact(ARGV[0].to_i)
  p a
rescue
  p $!.message
end
```

+ Attaching `rescue` to `begin` gives us the easiest way to explain how rescue works. In Ruby, `$!` refers the last Exception object.
+ If you call the `fact` method with an integer less than 0, it is executed infinitely because the return statements are always false. Therefore, at some point, the script spends all its memory.

```ruby
┌──(root💀jaeng)-[~/Desktop/study_ruby/basic]
└─# ./rescue.rb 5   
120
     
┌──(root💀jaeng)-[~/Desktop/study_ruby/basic]
└─# ./rescue.rb -1
Traceback (most recent call last):
        10080: from ./rescue.rb:10:in `<main>'
        10079: from ./rescue.rb:6:in `fact'
        10078: from ./rescue.rb:6:in `fact'
        10077: from ./rescue.rb:6:in `fact'
        10076: from ./rescue.rb:6:in `fact'
        10075: from ./rescue.rb:6:in `fact'
        10074: from ./rescue.rb:6:in `fact'
        10073: from ./rescue.rb:6:in `fact'
         ... 10068 levels...
            4: from ./rescue.rb:6:in `fact'
            3: from ./rescue.rb:6:in `fact'
            2: from ./rescue.rb:6:in `fact'
            1: from ./rescue.rb:6:in `fact'
./rescue.rb:6:in `fact': stack level too deep (SystemStackError)
```

+ You have seen that `$!` refers to the last Exception object. You can also use a personal variable with rescue.

```ruby
#!/usr/bin/ruby

def fact(n)
  return 1 if n==0
  return 1 if n==1
  n * fact(n - 1)
end

begin
  a = fact(ARGV[0].to_i)
  p a
rescue => error
  p error.message
end
```

##### Type based exception handling
+ You can use different rescue clauses and handle exceptions by their type.
+ In this example, the `ARGV[0]` is used to call `sum` method with wrong arguments

```ruby
#!/usr/bin/ruby

def sum(a,b)
  if !(a.is_a?Integer) || !(b.is_a?Integer)
    raise TypeError
  end
  a + b
end

begin
  print "2 + 3 = ", sum(2,3), "\n"
  print sum(2) if ARGV[0] == "argument"
  print sum("A",2) if ARGV[0] == "type"
rescue TypeError => te
  print "Type Error rescue: "
  print te.message, "\n"
rescue ArgumentError => ae
  print "Argument Error rescue: "
  print ae.message
end
```

```ruby
┌──(root💀jaeng)-[~/Desktop/study_ruby/basic]
└─# ./typeRescue.rb         
2 + 3 = 5
┌──(root💀jaeng)-[~/Desktop/study_ruby/basic]
└─# ./typeRescue.rb argument
2 + 3 = 5
Argument Error rescue: wrong number of arguments (given 1, expected 2) 
┌──(root💀jaeng)-[~/Desktop/study_ruby/basic]
└─# ./typeRescue.rb type    
2 + 3 = 5
Type Error rescue: TypeError
```

##### Rescue as a statement modifier
+ Rescue can follow any statement. If an exception occurs, the body of rescue if executed. In the example, the last `sum` causes an exception.
```ruby
#!/usr/bin/ruby

def divide(n)
  unless n.is_a? Integer
    raise TypeError
  end
  10 / n
end

begin
  print "10 / #{ARGV[0]} = ", divide(ARGV[0].to_i), "\n"
rescue TypeError => te
  print te.message 
rescue ZeroDivisionError
  puts "Cannot divide by 0"
end

# --------------------

┌──(root💀jaeng)-[~/Desktop/study_ruby/basic]
└─# ./modRescue.rb 0
Cannot divide by 0
```

#### Other clause
+ `raise` and `rescue` are not the only exception clauses available in Ruby:
	+ `retry`
	+ `else`
	+ `ensure`

##### Retry
+ `retry` is a clause that can be used inside `rescue` clause to re-execute the block of code that has caused the exception.
+ It is a very useful feature. Imagine you want to update a database and an exception occurs (a network error, a DB error, etc.). You may simply try it again. With `retry`, you can do that.

```ruby
#!/usr/bin/ruby

def divide
  print "Enter a number: "
  n = gets.chomp.to_i
  unless n.is_a? Integer
    raise TypeError
  end
  puts "10 / #{n} = #{10/n}"
end

begin
  divide
rescue
  puts "Error\n"
  retry
end

# ----------------------------

┌──(root💀jaeng)-[~/Desktop/study_ruby/basic]
└─# ./retry.rb
Enter a number: 2
10 / 2 = 5
 
┌──(root💀jaeng)-[~/Desktop/study_ruby/basic]
└─# ./retry.rb 
Enter a number: 0
Error
Enter a number: 2
10 / 2 = 5
```

+ In the above code, the `retry` clause will re-execute the `begin` block of code.

##### Else
+ Else is another clause provided by Ruby. It is used to execute some arbitrary code when `rescue` does not catch any exception.
+ Using `else` is similar to putting `else` block at the end of the `begin` clause.
+ *Note*: any exception raised in the `else` block will not be handled by the `rescue` clause!
+ Structured as follows:

```ruby
begin
	# code
rescue
	# code
else
	# code
end
```

##### Ensure
+ `ensure` is another clause that is used to specify some code that is always executed at the end of the begin flow.
+ The code is **always** executed even if an exception occurs inside the main control flow.

```ruby
begin
	# normal flow
rescue
	# exception handling
else
	# no exception occurs
ensure
	# always execute
end
```

##### Methods, Classes and Modules
+ The general structure of the code with exception handling is as follow:

```ruby
def method(a,b,c)
	# normal flow
rescue
	# exception handling
else
	# no exception occurs
ensure
	# always execute
end
```

```ruby
#!/usr/bin/ruby

def divide
  10 / 0
rescue
  puts "[!] Cannot divide by 0"
ensure
  puts "[!] Please try again"
end

divide

# ---------------

┌──(root💀jaeng)-[~/Desktop/study_ruby/basic]
└─# ./all.rb
[!] Cannot divide by 0
[!] Please try again
```