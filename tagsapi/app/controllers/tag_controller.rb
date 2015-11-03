class TagController < ApplicationController
	respond_to :json
	skip_before_action :verify_authenticity_token
	def create
		entity = Entity.find_or_initialize_by(identifier: params["identifier"])
		entity.update(entitytype: params["type"])
		entity.save
		respond_to do |format|
		  format.html # show.html.erb
		  format.xml  { render :xml => entity }
		  format.json { render :json => entity }
		end

		#respond_with entity.to_json
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
		@entities = Entity.tags.count
		respond_with @entities
	end
	def enititystats
		
	end
end
