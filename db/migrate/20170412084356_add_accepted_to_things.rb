class AddAcceptedToThings < ActiveRecord::Migration[5.0]
  def change
    add_column :things, :status, :integer, default: 0, index: true
  end
end
