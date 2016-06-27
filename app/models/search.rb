class Search < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :cep, presence: true, length: { is: 8 }

  before_save :api_search, on: :create

  default_scope { order('created_at DESC') }

  def api_search
    self.assign_attributes(CEPSearchService.search(self.cep)) if self.valid?
  end
end
