class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def this_week
    Nokogiri::HTML(open("http://www.thisamericanlife.org")).css("div#content").css("div.block-content").css("div.this-week").css("h3").css("a").attribute("href").text.split("/")[3].to_i
  end

  def new_episode?
    last = Podcast.last.number
    this_week > last ? true : false
  end

  helper_method :new_episode?, :this_week

end
