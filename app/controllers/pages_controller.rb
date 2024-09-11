require 'json'

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    file_path = Rails.root.join('app', 'assets', 'data', 'locations.json')
    @locations = JSON.parse(File.read(file_path))
  end
end
