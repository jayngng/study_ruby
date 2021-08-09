#!/usr/bin/ruby

class A
  
  CONST = 100

  def getConst; CONST; end
  
end

class B < A
  CONST = 200
end
