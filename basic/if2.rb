#!/usr/bin/ruby

x = 10
if x < 5 then
  puts %!\n#{x} is less than 5.\n!
elsif x > 2
  puts %!\n#{x} is greater than 2!
  if x > 9
    puts %[\n#{x} is also greater than 9]
  end
end

