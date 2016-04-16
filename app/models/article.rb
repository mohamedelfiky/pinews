class Article < ActiveRecord::Base
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :photos
  validates :title, :description, :author_id, presence: true

end
