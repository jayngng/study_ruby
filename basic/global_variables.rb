#!/usr/bin/ruby

puts

# Print name of the script: $0
puts %!Name of the script: \t#{$0}!

# Print the command line arguments: $*
puts %!CMD line args: \t#{$*}!

#  Read the lines and print it
print %!Random line: \t!
$stdin.gets
print %!gets: \t#{$_}!
