3.times do
print "Enter a value: "
STDOUT.flush
value = gets.to_i

if value == 1
	puts "One"
elsif value == 2
	puts "two"
else
	puts "many"
end

puts

end