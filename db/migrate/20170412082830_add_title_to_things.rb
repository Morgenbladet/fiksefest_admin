class AddTitleToThings < ActiveRecord::Migration[5.0]
  def change
    add_column :things, :title, :string
  end
end
