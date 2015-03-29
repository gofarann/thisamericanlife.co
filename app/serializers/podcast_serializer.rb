class PodcastSerializer < ActiveModel::Serializer
  attributes :number, :title, :description, :date, :image_url, :podcast_url

  def image_url
    "http://#{ENV['S3_BUCKET_NAME']}/images/#{"%03d" % number}.jpg"
  end

  def podcast_url
    "http://#{ENV['S3_BUCKET_NAME']}/podcasts/#{"%03d" % number}.mp3"
  end

end
