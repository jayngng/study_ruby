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
