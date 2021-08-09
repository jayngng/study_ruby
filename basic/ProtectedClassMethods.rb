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
