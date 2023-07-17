class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :name
      t.string :author
      t.string :description
      t.integer :category
      t.integer :issued_to
      t.datetime :issued_date_start
      t.datetime :issued_data_end
      t.references :library

      t.timestamps
    end
  end
end
