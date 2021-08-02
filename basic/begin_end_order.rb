#!/usr/bin/ruby

BEGIN { puts 1}
BEGIN { puts 2}
BEGIN { puts 3}
END {puts 4}
END {puts 5}
END {puts 6}

