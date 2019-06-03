
class Video < ApplicationRecord

  validates :name, :presence => true
  validates :artist, :presence => true
  validates :link_video, :presence => true

  belongs_to :user
  has_many :imported_videos

  def self.search(search)
    if search
      self.where('artist LIKE ?', "%#{search}%")
    else
      self.all
    end
  end

end
