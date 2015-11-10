
require File.expand_path('../../config/environment', __FILE__)

def get_colors
	@hexcolors = {}
	@query   = {}
	@headers = { "Auth-Token"=> "b3c2ef1c-81fb-403e-8e4f-9d7c02bd68da",}

	@response = HTTParty.get("http://challenge.teespring.com/inks", :query => @query, :headers => @headers )
	return @response.to_h
end

def get_questions
	@hexcolors = {}
	@query   = {}
	@headers = { "Auth-Token"=> "b3c2ef1c-81fb-403e-8e4f-9d7c02bd68da",}

	@response = HTTParty.get("http://challenge.teespring.com/question/evaluate", :query => @query, :headers => @headers ).to_h
	return @response["scenario_id"],@response["questions"]
end

def euclidean_distance(a, b)
  	#a.zip(b).map { |x| (x[1] - x[0])**2 }.reduce(:+) #turns out this is very wrong
  	sq = a.zip(b).map{|a,b| (a - b) ** 2}
  	Math.sqrt(sq.inject(0) {|s,c| s + c})
end
def distance_from(color, color1)
	color = from_hex(color)
	color1 = from_hex(color1)
    euclidean_distance [color[0], color[1], color[2]], [color1[0], color1[1], color1[2]]
end

def strip_hex(hex)
    hex.delete('#')
end

def from_hex(hex)
  @color = {}
  hex = strip_hex(hex)
  #ap hex
  r, g, b = hex.scan(/../).map(&:hex)
  #ap [r,g,b]
  [r,g,b]
end

#create a hash to store numbers on
@colors_hash = {}
#sort by cost
@price_sorted_colors = get_colors["inks"].sort_by { |hsh| hsh["cost"] }
@price_sorted_colors.each_with_index do |color,index| 
	#set the index in there to optimize for fixing worst color
	color["position"] = index
	@colors_hash[color["color"]] = color 
end

@colors_distance_hash = {}


ap @colors_hash

#Least optimal + correct solution, but needed to get things done, run through price sorted array and find distance.
@scenario_id, @questions = get_questions

#@questions[0] 
ap @questions[0]["layers"]
ap distance_from("#882FB5","#17B0D8")


#TODO more optimal condition of running through entire set and calculating distances, optimizing for full corect choice. As it is only 10k colors we aren't talking that many calculations with good memoization
#Create 10kx10k calculation of the most efficient per point difference run down that list till lowest


#Notes
#https://www.bionicspirit.com/blog/2012/01/16/cosine-similarity-euclidean-distance.html
#http://www.rubydoc.info/github/wvanbergen/chunky_png/ChunkyPNG/Color
