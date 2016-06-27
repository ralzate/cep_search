class User < ActiveRecord::Base
  validates :provider, :uid, presence: true

  def self.create_or_update_by_oauth(auth)
    user = User.find_or_initialize_by(:provider => auth['provider'], :uid => auth['uid'])
    if auth['info']
      user.name = auth['info']['name'] || ""
      user.email = auth['info']['email'] || ""
      user.image = auth['info']['image'] || ""
    end
    user.save
    user
  end
end
