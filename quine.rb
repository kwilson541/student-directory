File.open($0, "r") { |file| 
file.readlines.each do |line|
puts line
end
}