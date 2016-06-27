class Search < ActiveRecord::Base
  belongs_to :user

  validates :cep, presence: true, length: { is: 8 }

  before_save :api_search, on: :create

  def api_search
    self.assign_attributes(CEPSearchService.search(self.cep)) if self.valid?
  end
end
