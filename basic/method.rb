#!/usr/bin/ruby

def double()
  puts %!Enter a number: !
  number = gets.chomp
  return %!→ Result: !, number.to_i * 2
end

puts double()
