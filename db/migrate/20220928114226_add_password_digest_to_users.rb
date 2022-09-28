class AddPasswordDigestToUsers < ActiveRecord::Migration[5.1]
  def change
    # has_secure_passwordを使うために
    # password_digestカラムが必要
    add_column :users, :password_digest, :string
  end
end
