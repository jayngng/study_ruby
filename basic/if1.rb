#!/usr/bin/ruby

x = 10
if x > 5 then
  puts %!\n#{x} is greater than 5.\n!
end

# `then` can be removed with multi line if
if x < 11
  puts %!\n#{x} is less than 10.\n!
end
