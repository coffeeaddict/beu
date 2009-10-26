# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def format_beu(content)
    formatted = ""
    formatted = content.gsub(/((\#|\@)[^\s]+)/) { |tag|
      if tag =~ /\#/
	tag = link_to tag, :controller => "beu", :action => "search", :id => tag.gsub(/\#/,"")
      elsif tag =~ /\@/
	tag = link_to tag, :controller => "user", :action => "bues", :id => tag.gsub(/\@/,"")
      else
	# que?
      end
    }


    return formatted
  end
end
