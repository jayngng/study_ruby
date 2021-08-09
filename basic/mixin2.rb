#!/usr/bin/ruby

module B
  def hello; "Hello"; end
end

class A
  include B
  def world; "World"; end
end
