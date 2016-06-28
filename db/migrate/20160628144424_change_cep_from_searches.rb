class ChangeCepFromSearches < ActiveRecord::Migration
  def change
    change_column :searches, :cep, :string
  end
end
