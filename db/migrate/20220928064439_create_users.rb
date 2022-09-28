class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email

      # timestampsでcreated_atとupdated_atの二つのカラムが作成される
      t.timestamps
    end
  end
end
