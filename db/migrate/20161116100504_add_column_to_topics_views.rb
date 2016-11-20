class AddColumnToTopicsViews < ActiveRecord::Migration[5.0]
  def change
  	add_column :topics , :views , :integer
  end
end
