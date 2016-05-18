class Photo < ActiveRecord::Base
  belongs_to :article

  has_attached_file :image,
                    path: "#{ Rails.root }/public/assets/images/articles/:article_id/images/:id_:style.:extension",
                    url: '/assets/images/articles/:article_id/images/:id_:style.:extension',
                    styles: { medium: '400x400>', thumb: '100x100>', mini: '90x90#' },
                    size: { in: 0..6.megabytes },
                    convert_options: {
                      medium: '-set colorspace sRGB -strip',
                      thumb: '-set colorspace sRGB -strip',
                      mini: '-set colorspace sRGB -strip'
                    }
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}
  validates :title, :image, presence: true

  Paperclip.interpolates :article_id do |attachment, _style|
    attachment.instance.article_id
  end
end
