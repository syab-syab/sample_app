class Relationship < ApplicationRecord
  # belongs_toに渡された名前と実際のクラス名が異なるときに
  # class_nameオプションで都合をつける感じだと思う
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  # follower_id, followed_idの存在性バリデーション
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
