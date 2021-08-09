#!/usr/bin/ruby

def divide
  10 / 0
rescue
  puts "[!] Cannot divide by 0"
ensure
  puts "[!] Please try again"
end

divide
