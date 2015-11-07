class TagController < ApplicationController
	respond_to :json
	skip_before_action :verify_authenticity_token
	def create
		if Entity.where(identifier: params["identifier"]).length > 0
			entity = Entity.where(identifier: params["identifier"]).first
			entity.tags.delete_all
			entity.update(entitytype: params["type"])
		else
			entity = Entity.create(entitytype: params["type"],identifier: params["identifier"])
		#
		end
		ActiveSupport::JSON.decode(params["tag"]).each do |tag|
			Tag.create(:name => tag ,:entity_id => entity.id)
		end
		entity.save
	
		respond_to do |format|
		  format.html # show.html.erb
		  format.xml  { render :xml => entity }
		  format.json { render :json => entity }
		end
	end
	def find
		result = Entity.where(entitytype: params["entity_type"], identifier: params["entity_id"]).first
		
		entity = {}
		if result
			entity["type"] = result.entitytype
			entity["id"] = result.identifier
			entity["tags"] = result.tags.map{|tag| tag.name}#Tag.where(:entity_id => entity).map{|tag| tag.name}
		end
		respond_to do |format|
		  format.html # show.html.erb
		  format.xml  { render :xml => entity }
		  format.json { render :json => entity }
		end
	end
	def delete
		if Entity.where(identifier: params["identifier"]).length > 0
			entity = Entity.where(identifier: params["identifier"]).first
			entity.tags.delete_all
			Entity.where(identifier: params["identifier"]).delete_all
		end
		respond_to do |format|
		  format.html # show.html.erb
		  format.xml  { render :xml => [] }
		  format.json { render :json => [] }
		end
	end
	def stats
		@stats = []
		@tags = Tag.joins(:entity).select('tags.name, COUNT(*) AS count').group('tags.name').order('count DESC')
		@tags.each{|tag| @stats.push({tag: tag.name, count: tag.count})} #could have done with map but selected clarity of code here
		respond_to do |format|
		  format.html # show.html.erb
		  format.xml  { render :xml => @stats }
		  format.json { render :json => @stats }
		end
	end
	def entitystats
		@enititystats = {}
		if Entity.where(entitytype: params["entity_type"], identifier: params["entity_id"]).length > 0
			result = Entity.where(entitytype: params["entity_type"], identifier: params["entity_id"]).first
			@enititystats["type"] = result.entitytype
			@enititystats["id"] = result.identifier
			@stats = []
			@tags = result.tags.select('tags.name, COUNT(*) AS count').group('tags.name').order('count DESC')
			@tags.each{|tag| @stats.push({tag: tag.name, count: tag.count})} #could have done with map but selected clarity of code here			
			@enititystats["tags"] = @stats#Tag.where(:entity_id => entity).map{|tag| tag.name}
		end	
		respond_to do |format|
		  format.html # show.html.erb
		  format.xml  { render :xml => @enititystats }
		  format.json { render :json => @enititystats }
		end
	end
end
