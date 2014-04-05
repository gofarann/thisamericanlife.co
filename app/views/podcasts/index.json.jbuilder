json.array!(@podcasts) do |podcast|
  json.extract! podcast, :id, :number, :title, :description, :date
  json.url podcast_url(podcast, format: :json)
end
