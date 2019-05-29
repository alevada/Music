
class Video < ApplicationRecord

  validates :name, :presence => true
  validates :artist, :presence => true
  validates :link_video, :presence => true

  has_many :videos

  def self.search(search)
    if search
      self.where('artist LIKE ?', "%#{search}%")
    else
      self.all
    end
  end

end
