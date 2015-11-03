class TagController < ApplicationController
	respond_to :json
	def create
		
	end
	def update
		
	end
	def show
		
	end
	def find
		
	end
	def delete
		
	end
	def stats
		#raise 'entity'.pluralize
		@entities = Entity.all
		respond_with @entities
	end
	def enititystats
		
	end
end
