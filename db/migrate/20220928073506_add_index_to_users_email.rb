class AddIndexToUsersEmail < ActiveRecord::Migration[5.1]
  def change
    # アドレスの一意性を強制
    add_index :users, :email, unique: true
  end
end
