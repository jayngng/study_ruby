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
