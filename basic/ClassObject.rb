#!/usr/bin/ruby

class ClassObject
  @a = 100

  attr_reader :a

  def self.a=(val); @a = val; end

  def self.a; @a; end

  def initialize(a); @a = a; end
end
