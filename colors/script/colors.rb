
require File.expand_path('../../config/environment', __FILE__)

def get_colors
	@hexcolors = {}
	@query   = {}
	@headers = { "Auth-Token"=> "b3c2ef1c-81fb-403e-8e4f-9d7c02bd68da",}

	@response = HTTParty.post("http://challenge.teespring.com/inks", :query => query, :headers => headers )
	"0A".hex
end
get_colors