#!/usr/bin/ruby

def divide
  print "Enter a number: "
  n = gets.chomp.to_i
  unless n.is_a? Integer
    raise TypeError
  end
  puts "10 / #{n} = #{10/n}"
end

begin
  divide
rescue
  puts "Error\n"
  retry
end
