class HomeController < ApplicationController
  def index
    redirect_to '/groups' if @restpack.is_authenticated?
  end
end