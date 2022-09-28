class User < ApplicationRecord
  before_save { self.email = email.downcase }
  # name、emailカラムの存在性(presence)をチェック
  # つまり両方とも空白や未入力は受け付けない
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                              # アドレスのフォーマットの検証
                              format: { with: VALID_EMAIL_REGEX },
                              # 一意性の検証(大文字小文字を区別しない)
                              uniqueness: { case_sensitive: false }
end
