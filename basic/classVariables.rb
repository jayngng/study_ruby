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
