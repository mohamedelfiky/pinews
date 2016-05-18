class Pin < ActiveRecord::Base
  belongs_to :article
  belongs_to :user

  validates :user_id, uniqueness: { scope: :article_id, message: 'you pined this article before' }
  validates :user_id, :article_id, presence: true
end
