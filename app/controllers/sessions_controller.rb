class SessionsController < ApplicationController
  def new
    redirect_to '/auth/facebook'
  end

  def create
    auth = request.env["omniauth.auth"]
    if auth.blank?
      redirect_to root_url, :error => "Houve um erro. Por favor tente novamente."
    else
      user = User.create_or_update_by_oauth(auth)
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Logado!"
    end
  end

  def destroy
    reset_session
    redirect_to root_url, :notice => 'Deslogado'
  end
end
