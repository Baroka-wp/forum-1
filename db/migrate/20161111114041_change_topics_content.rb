class ChangeTopicsContent < ActiveRecord::Migration[5.0]
  def change
  	rename_column :topics , :content , :t_content

  end
end
