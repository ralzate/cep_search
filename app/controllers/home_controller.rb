class HomeController < ApplicationController
  def index
    @search = current_user.searches.build if current_user
  end

  private

  def current_user
    User.where(id: session[:user_id]).first
  end
end
