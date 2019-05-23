
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

  def set_default_role
    self.role ||= Role.find_by_name 'Trial User'
  end

  def destroy
    update_attributes(deactivated: true) unless deactivated
  end

  def inactive_message
    !deactivated ? super : :is_locked
  end

  def self.search(search)
    if search
      self.where('username LIKE ?', "%#{search}%")
      #find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      self.all
    end
  end

end

# #<button type="button" class="btn btn-outline-primary btn-sm"><%= link_to "Search", :username => nil %></button>
#
# =begin
#   <%= form_tag users_path, :method => 'get' do %>
#                     <%= text_field_tag :search, params[:search] %>
#                   <% end %>
#                   <input class="form-control mr-sm-2" type="text" placeholder="users">
#                   <button type="button" class="btn btn-outline-primary btn-sm"><%= link_to "Search", :username => nil %></button>=end
