class Podcast < ActiveRecord::Base
  attr_accessor :image, :podcast

  def image
    "http://#{ENV['S3_BUCKET_NAME']}/images/#{"%03d" % self.number}.jpg"
  end

  def podcast
    "http://#{ENV['S3_BUCKET_NAME']}/podcasts/#{"%03d" % self.number}.mp3"
  end

end
