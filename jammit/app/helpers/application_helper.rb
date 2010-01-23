# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def flash_notices
    [:notice, :error, :warning].collect do |type|
      content_tag('div', flash[type], :class=>"message #{type}", :id => "flash_messages") if flash[type]
    end
  end

  # print stylesheet for each item in array of files in head section
  def stylesheets(*files)
    content_for(:stylesheets) { stylesheet_link_tag(*files) }
  end  
    
  # print javascript for each item in array of files in head section
  def javascripts(*files)
    content_for(:javascripts) { javascript_include_tag(*files) }
  end
end
