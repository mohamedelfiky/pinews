class User < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :database_authenticatable, :timeoutable and :omniauthable
  devise :registerable, :recoverable, :rememberable, :trackable, :validatable

  belongs_to :role
  before_create :set_role

  def admin?
    self.role.name == 'Admin' if self.role
  end

  def author?
    self.role.name == 'Author' if self.role
  end

  def set_role
    self.role = Role.find_by_name('Author') unless self.role
  end
end
