class HomeController < ApplicationController
  def index
    users = User.all
    periods = Period.all

    summary = {}

    summary[:user_count] = users.count
    summary[:period_count] = periods.count
    summary[:env] = Rails.env

    render json: { summary: summary }
  end
end
