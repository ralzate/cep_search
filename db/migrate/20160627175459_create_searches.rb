class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :cep
      t.string :street
      t.string :city_state
      t.integer :status
      t.string :error

      t.timestamps null: false
    end
  end
end
