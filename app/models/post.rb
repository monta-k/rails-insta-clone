class Post < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :likes, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :comments, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :notifications, dependent: :destroy

  #あるユーザーからいいねされているかを調べるメソッド
  def liked_by(user)
    Like.find_by(user_id: user.id, post_id: id)
  end

  #投稿があるユーザーによるものかを調べるメソッド
  def is_belongs_to?(user)
    Post.find_by(user_id: user.id, id: id)
  end

end
