#!/usr/bin/ruby

x = 15

puts %!#{x} is greater than 10! if x > 10
puts %!#{x} is an integer! if x.is_a? Integer

str = "TEST"

puts %!#{str} is a string! if str.is_a? String
puts %!#{str} is a string! if str.is_a? Integer

