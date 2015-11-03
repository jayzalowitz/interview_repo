require 'json'
require 'ap'

letters = {}

('A'..'Z').each_with_index do |letter, idx|
    letters[letter] = idx + 1
end

puts letters

def read_file(file_name)
  file = File.open(file_name, "r")
  data = file.read
  file.close
  return data
end

comma_formatted_names = read_file("names.txt").gsub(/\"/,"")

array = comma_formatted_names.split(',')

array = array.sort_by{|word| word.upcase}
#ap array

values = 0
array.each_with_index do |name, index|
	value = 0
	name.split("").each do |letter|
		value += letters[letter]
	end
	values += value * (index + 1)
end
puts values