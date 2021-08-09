#!/usr/bin/ruby

def fact(n)
  return 1 if n==0
  return 1 if n==1
  n * fact(n - 1)
end

begin
  a = fact(ARGV[0].to_i)
  p a
rescue => error
  p error.message
end
