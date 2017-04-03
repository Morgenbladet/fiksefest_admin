class CreateThings < ActiveRecord::Migration[5.0]
  def change
    create_table :things do |t|
      t.attachment :image
      t.text :description
      t.string :owner
      t.string :email

      t.timestamps
    end
  end
end
