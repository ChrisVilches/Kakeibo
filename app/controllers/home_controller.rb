class HomeController < ApplicationController
  def index
    render json: { msg: 'Hello world' }
  end
end
