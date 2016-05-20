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

  validates :name, :nickname, presence: true
  validates :email, uniqueness: true

  def admin?
    role.name == 'Admin' if role
  end

  def author?
    role.name == 'Author' if role
  end

  def set_role
    Role.find_by_name('Author') unless role
  end
end
