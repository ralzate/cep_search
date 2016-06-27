class Search < ActiveRecord::Base
  belongs_to :user

  validates :cep, presence: true, length: { is: 8 }
end
