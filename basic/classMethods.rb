#!/usr/bin/ruby

class Operation
  
  def Operation.add(a,b) # or def self.add
    a + b
  end

  class << Operation # or class << self

    def mul(a, b)
      a * b
    end

    # Other class methods

  end

end
