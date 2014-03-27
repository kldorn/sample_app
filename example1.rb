10.times do
	puts "this is a test"
end

x = 2
print "this application is running okay if 2 + 2 = #{x + x}"
puts ""

a = [42, 8, 17]
puts a

a = [1, 2, 3, 4, 5]
b = a.shuffle
puts "b= #{b}" 

a = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z]
puts a

#Note: Make sure you use the corret version of the  ' character
x = "abcdefghijklmnopqrstuvwxyz"
y = x.scan(/\w/).join(',')
puts x
puts y[1..3]

x = ('A'..'Z').to_a
puts x[1..3]

# prints every other index
(1..5).each { |i| puts 2 * i }

puts "generate random subdomains"
#('a'..'z').to_a.shuffle[0..7].join
puts "first create the array"
b = ('a'..'z').to_a 
puts b
puts "shuffle it"
c = ('a'..'z').to_a.shuffle  
puts c  
puts "Pull out the first eight elements"
d = ('a'..'z').to_a.shuffle[0..7]  
puts d
puts "Join them together to make one string."
e = ('a'..'z').to_a.shuffle[0..7].join  
puts e