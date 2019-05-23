
class Video < ApplicationRecord

  validates :name, :presence => true
  validates :artist, :presence => true
  validates :link_video, :presence => true

end
