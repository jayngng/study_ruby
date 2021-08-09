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
