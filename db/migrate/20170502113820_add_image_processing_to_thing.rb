class AddImageProcessingToThing < ActiveRecord::Migration[5.0]
  def change
    add_column :things, :processing, :boolean
  end
end
