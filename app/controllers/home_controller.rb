class HomeController < ApplicationController
  def index
    render json: { summary: summary }
  end

  private

  def summary
    {
      user_count: User.count,
      period_count: Period.count,
      env: Rails.env
    }
  end
end
