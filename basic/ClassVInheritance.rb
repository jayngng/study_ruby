#!/usr/bin/ruby

class A
  @@a = 100

  def class_a; @@a; end
  def class_a=(v); @@a = v; end

  class << self
    def class_a; @@a; end
    def class_a=(v); @@a = v; end
  end

end
# ---------------------------------

class B < A
end
