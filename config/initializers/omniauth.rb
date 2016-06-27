Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '318902575107492', '7e81af7baa483d6544e8bd86acd509f3',
           :scope => 'email,user_birthday'
end