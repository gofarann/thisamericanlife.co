class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def newest_episode
    doc = Nokogiri::HTML(open("http://www.thisamericanlife.org/radio-archives")).css("div#content").css("div#archive-episodes")
    newest_number = doc.css("li.first").css("h3").css("a").attribute("href").text.split("/")[3]
    raw_date = doc.css("li.first").css("h3").css("span.date").text.split(".")
    newest_date = Date.parse("#{raw_date[2]}-#{raw_date[0]}-#{raw_date[1]}")

    if newest_date > Date.today
      newest_number.to_i - 1
    else
      newest_number.to_i
    end   
  end
  
  def new_episodes?
    last = Podcast.last.number
    newest_episode > last ? true : false
  end
  
  helper_method :new_episodes?, :newest_episode
  
end
