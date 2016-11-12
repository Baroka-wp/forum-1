class ChangeTopicsTable < ActiveRecord::Migration[5.0]
  def change
  	rename_column :topics , :posting_date , :t_time
  end
end
