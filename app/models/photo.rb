class Photo < ActiveRecord::Base
  belongs_to :article
  validates_presence_of :title, :image
end
