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
