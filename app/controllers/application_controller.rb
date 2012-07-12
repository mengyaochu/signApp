class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale

  def set_locale
    I18n.locale = I18n.default_locale
  end

  def permission_denied
      respond_to do |format|
      flash[:error] = 'Sorry, you are not allowed to view the requested page.'
      format.html { redirect_to(:back) rescue redirect_to('/') }
      format.xml { head :unauthorized }
      format.js { head :unauthorized }
      end
  end


 end
