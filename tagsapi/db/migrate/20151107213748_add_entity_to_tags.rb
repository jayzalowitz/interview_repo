class AddEntityToTags < ActiveRecord::Migration
  def change
  	drop_table :tags
  	create_table :tags do |t|
      t.string :name
      t.belongs_to :entity, index: true
      t.timestamps null: false
    end	
  end
end
