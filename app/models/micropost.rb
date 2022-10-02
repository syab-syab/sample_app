class Micropost < ApplicationRecord
  # userモデルと関連付け(1 → user)
  belongs_to :user
  # 作成された順に取り出す(降順)
  default_scope -> { order(created_at: :desc) }
  # 画像投稿
  mount_uploader :picture, PictureUploader
  # user_idが存在しているかどうかのバリデーション
  validates :user_id, presence: true
  # contentの存在性と文字数のバリデーション
  validates :content, presence: true, length: { maximum: 140 }
  # 画像サイズの制御
  validate  :picture_size

  private

    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
