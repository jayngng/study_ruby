#!/usr/bin/ruby

class Vehicle

  def initialize(type)
    @type = type
  end

  def to_s
    "I'm a #{@type} vehicle"
  end

end

class Car < Vehicle
  
  def initialize
    super("land")
  end

  def to_s
    super + ". I'm a car."
  end

end
