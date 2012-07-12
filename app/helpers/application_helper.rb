module ApplicationHelper
   def title(page_title, show_title = true)
    content_for(:title) { h(page_title.to_s) }
    @show_title = show_title
  end

  def show_title?
    @show_title
  end

  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args) }
  end

  def javascript(*args)
    content_for(:head) { javascript_include_tag(*args) }
  end

   def flash_helper
       message = ''
       [:notice, :warning, :message, :error].each do |name|
         if flash[name]
           message = message + flash[name]
           message = content_tag(:div, content_tag(:span, message) + content_tag(:a, 'x', :class => 'close'),  :class => "alert-box #{name}" )

         end
         flash[name] = nil;
     end
        return message
   end

  def profiles_path(*args)
      users_profile_path(*args)
  end

end
