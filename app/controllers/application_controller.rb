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

  def clone_with_errors(object)
    clone = object.clone
    object.errors.each{|field,msg| clone.errors.add_to_base(msg)}
    return clone
  end
  
  def getDayOfWeek(w_day)
    tmp_w_day = w_day.split("-")
    year = tmp_w_day[0]
    month = tmp_w_day[1]
    day = tmp_w_day[2]
    
    year1_int = year.to_s.slice(0..1).to_i;
    year2_int = year.to_s.slice(2..3).to_i;

    
    if month.to_i <= 2 then
         refined_mm = month.to_i+12;
         refined_dd = day+1;
    else
        refined_mm = month.to_i;
         refined_dd = day
    end
      
    result = ((21*year1_int.to_i/4) + (5*year2_int.to_i/4) + (26*(refined_mm.to_i+1)/10)+ refined_dd.to_i-1)%7
    
    return result; 
  end
  
 end
