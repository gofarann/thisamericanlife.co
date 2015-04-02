class Podcast < ActiveRecord::Base
  def to_param
    [number, title.parameterize].join("-")
  end
end
