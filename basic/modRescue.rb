#!/usr/bin/ruby

def divide(n)
  unless n.is_a? Integer
    raise TypeError
  end
  10 / n
end

begin
  print "10 / #{ARGV[0]} = ", divide(ARGV[0].to_i), "\n"
rescue TypeError => te
  print te.message 
rescue ZeroDivisionError
  puts "Cannot divide by 0"
end
