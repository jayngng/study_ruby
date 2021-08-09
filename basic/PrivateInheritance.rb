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
