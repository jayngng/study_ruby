#!/usr/bin/ruby

class AClass
  # Public methods
  def getName
    privateName
  end

  # Private methods
  private

    def privateName
      "I'm a class"
    end

end
