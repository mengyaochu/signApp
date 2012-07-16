class Admin::HomeController < ApplicationController

  before_filter :authenticate_user!
  filter_access_to :all

  def index
    
  end
end