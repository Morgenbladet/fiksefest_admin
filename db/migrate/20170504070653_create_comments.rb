class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.references :thing, foreign_key: true
      t.text :text
      t.string :name
      t.string :email
      t.boolean :published, default: true

      t.timestamps
    end
  end
end
