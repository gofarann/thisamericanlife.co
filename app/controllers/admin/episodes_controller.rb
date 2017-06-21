class Admin::EpisodesController < ApplicationController
  http_basic_authenticate_with name: ENV['BASIC_AUTH_USERNAME'], password: ENV['BASIC_AUTH_PASSWORD']

  def index
  end

  def create
    if params[:number].present?
      url = "https://www.thisamericanlife.org/radio-archives/episode/#{params[:number]}"

      begin
        doc = Nokogiri::HTML(open(url))

        if doc.present?
          content = doc.css("div#content")
          number = content.css("h1.node-title").text.split(":").first.to_i
          title = content.css("h1.node-title").text.split(":").last.strip
          description = content.css("div.description").text.strip
          date = Date.parse(content.css("div.date").text).strftime("%F")
        end

        new_episode = Podcast.new(number: number, title: title, description: description, date: date)

        if new_episode.save
          redirect_to admin_episodes_path, notice: "New Episode Imported! :)"
        else
          redirect_to admin_episodes_path, alert: "Oops. Something went wrong. Try again."
        end
      rescue OpenURI::HTTPError => e
        if e.message == '404 Not Found'
          redirect_to admin_episodes_path, alert: "Oops. That's not a real episode, dummy."
        else
          raise e
        end
      end
    else
      redirect_to admin_episodes_path, alert: "You must supply a number, idiot."
    end
  end

  private

  def method_name

  end

end
