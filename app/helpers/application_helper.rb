# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def format_beu(content)
    formatted = ""
    formatted = content.gsub(/((\#|\@)[^\s]+)/) { |tag|
      if tag =~ /\#/
	tag = link_to tag, { :controller => "beu", :action => "search", :id => tag.gsub(/\#/,"") }, :class => "tag"
      elsif tag =~ /\@/
	name = tag.gsub(/\@/,"");
	tag = '@' + link_to(name, { :controller => "user", :action => "beus", :id => name }, :class => "user")
      else
	# que?
      end
    }

    formatted.gsub!(/https?\:\/\/[^\s]+/) { |link|
      # now is this beautiful ruby code or what?
      link = link_to link, link
    }

    return formatted
  end
end
