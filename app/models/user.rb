
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :role
  #has_many :roles, through: :invitations
  validates :username, presence: true
  validates :email, presence: true, uniqueness: true

  enum role: [:trial_user, :premium_user, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= Role.find_by_name 'trial_user'
  end

end
