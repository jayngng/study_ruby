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
