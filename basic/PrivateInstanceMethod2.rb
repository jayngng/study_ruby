#!/usr/bin/ruby

class AClass
  # Public methods
  def self.getName
    privateName
  end

  def self.privateName
      "I'm a class"
  end

  # Specify private methods
  private_class_method :privateName

end
