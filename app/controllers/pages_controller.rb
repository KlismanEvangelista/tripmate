require 'json'

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    file_path = Rails.root.join('app', 'assets', 'data', 'locations.json')
    @locations = JSON.parse(File.read(file_path))

    if current_user
      @plans = Plan.where.not(user_id: current_user.id).limit(4)
    else
      @plans = Plan.all.take(4)
    end
  end
end
