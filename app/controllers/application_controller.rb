class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def this_week
    Nokogiri::HTML(open("http://www.thisamericanlife.org")).css("div#content").css("div.block-content").css("div.this-week").css("h3").css("a").attribute("href").text.split("/")[3].to_i
  end

  def new_podcast_exists?
    response = HTTParty.get("http://podcast.thisamericanlife.org/podcast/#{episode}.mp3")
    response.code == 200
  end

  def new_episode?
    last = Podcast.last.number
    return false unless this_week > last
    return false unless new_podcast_exists?
    return true
  end

  helper_method :new_episode?, :this_week

end
