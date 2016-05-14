class User < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User
  # Include default devise modules. Others available are:
  devise :registerable, :recoverable, :rememberable, :trackable, :validatable
  before_create :skip_confirmation!
  after_create :create_new_auth_token

  belongs_to :role
  has_many :articles, foreign_key: :author_id, dependent: :destroy
  has_many :pins, dependent: :destroy
  before_create :set_role
  self.per_page = 5



  validates_presence_of :name, :nickname
  validates_uniqueness_of :email


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
