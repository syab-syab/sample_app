class User < ApplicationRecord
  attr_accessor :remember_token
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
  # セキュリティのためにパスワードをハッシュ化する
  has_secure_password
  # パスワードの存在性と最小文字数
  validates :password, presence: true, length: { minimum: 6 }

  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    # update_attributeを使って記憶ダイジェストを更新
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # ユーザーのログイン情報を破棄する
  def forget
    # 記憶ダイジェストをnilで更新
    update_attribute(:remember_digest, nil)
  end
end


# テストデータのパスワードはすべて123456789