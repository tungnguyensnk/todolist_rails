class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.text :description
      t.string :invite_code
      t.integer :creator_id

      t.timestamps
    end
  end
end
