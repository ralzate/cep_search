class SearchesController < ApplicationController
  def create
    @search = Search.new(search_params)
    if @search.save
      render 'success'
    else
      render 'error'
    end
  end

  private

  def search_params
    params.require(:search).permit(:user_id, :cep)
  end
end
