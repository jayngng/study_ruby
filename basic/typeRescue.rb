#!/usr/bin/ruby

def sum(a,b)
  if !(a.is_a?Integer) || !(b.is_a?Integer)
    raise TypeError
  end
  a + b
end

begin
  print "2 + 3 = ", sum(2,3), "\n"
  print sum(2) if ARGV[0] == "argument"
  print sum("A",2) if ARGV[0] == "type"
rescue TypeError => te
  print "Type Error rescue: "
  print te.message, "\n"
rescue ArgumentError => ae
  print "Argument Error rescue: "
  print ae.message
end
