class CreateLibraries < ActiveRecord::Migration[6.1]
  def change
    create_table :libraries do |t|
      t.string :name
      t.text :address
      t.references :user

      t.timestamps
    end
  end
end
