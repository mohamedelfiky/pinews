class Pin < ActiveRecord::Base
  belongs_to :article
  belongs_to :user

  validates_uniqueness_of :user_id, scope: :article_id, message: "User can't pin article more than once"
  validates_presence_of :user_id, :article_id
end
