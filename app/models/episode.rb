require 'elasticsearch/model'
class Episode < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  validates :number, :title, :description, :date, presence: true
  validates :number, uniqueness: true

  def to_param
    [number, title.parameterize].join("-")
  end
end
