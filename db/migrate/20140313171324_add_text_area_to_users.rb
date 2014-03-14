class AddTextAreaToUsers < ActiveRecord::Migration
  def change
    add_column :users, :text_area, :text
  end
end
