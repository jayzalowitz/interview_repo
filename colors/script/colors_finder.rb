
require File.expand_path('../../config/environment', __FILE__)

def get_colors
	@hexcolors = {}
	@query   = {}
	@headers = { "Auth-Token"=> "b3c2ef1c-81fb-403e-8e4f-9d7c02bd68da",}

	@response = HTTParty.get("http://challenge.teespring.com/inks", :query => @query, :headers => @headers )
	return @response.to_h
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

@colors_hash = {}
@price_sorted_colors = get_colors["inks"].sort_by { |hsh| hsh["cost"] }


#Least optimal solution, but needed to get things done, run through price sorted array and find distance.

ap distance_from("#882FB5","#17B0D8")


#Notes
#https://www.bionicspirit.com/blog/2012/01/16/cosine-similarity-euclidean-distance.html
#http://www.rubydoc.info/github/wvanbergen/chunky_png/ChunkyPNG/Color
