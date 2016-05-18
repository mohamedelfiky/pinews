class Article < ActiveRecord::Base
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_one :role, through: :author
  has_many :photos, dependent: :destroy
  has_many :pins, dependent: :destroy
  validates :title, :description, :author_id, presence: true
  self.per_page = 5

  has_attached_file :image,
                    path: "#{ Rails.root }/public/assets/images/articles/:id/:filename_:style.:extension",
                    url: '/assets/images/articles/:id/:filename_:style.:extension',
                    styles: { medium: '400x400>', thumb: '100x100>', mini: '90x90#' },
                    size: { in: 0..6.megabytes },
                    convert_options: {
                      medium: '-set colorspace sRGB -strip',
                      thumb: '-set colorspace sRGB -strip',
                      mini: '-set colorspace sRGB -strip'
                    }
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}
end
