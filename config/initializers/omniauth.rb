Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env == 'production'
    provider :facebook, '261241227574661', 'ae9b2f8f808eb28f7eeb34f6c59966af',
             :scope => 'email,user_birthday'
  else
    provider :facebook, '318902575107492', '7e81af7baa483d6544e8bd86acd509f3',
             :scope => 'email,user_birthday'
  end
end