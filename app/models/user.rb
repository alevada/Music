
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :role
  #has_many :roles, through: :invitations
  validates :username, presence: true
  validates :email, presence: true, uniqueness: true
  after_initialize :set_default_role, :if => :new_record?

  has_many :videos

  def set_default_role
    self.role ||= Role.find_by_name 'Trial User'
  end

  def destroy
    update_attributes(deactivated: true) unless deactivated
  end

  def inactive_message
    !deactivated ? super : :is_locked
  end

  #search-ul asta nu mai este folosit...in controller-ul de user
  def self.search(search)
    if search
      self.where('username LIKE ?', "%#{search}%")
    else
      self.all
    end
  end

end
