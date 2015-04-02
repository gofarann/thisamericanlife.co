require 'elasticsearch/model'
class Podcast < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  def to_param
    [number, title.parameterize].join("-")
  end
end
