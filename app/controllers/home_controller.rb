class HomeController < ApplicationController
  def index
    users = User.all
    periods = Period.all

    result = {}

    result[:message] = 'Hello world'
    result[:user_count] = users.count
    result[:period_count] = periods.count

    render json: result
  end
end
