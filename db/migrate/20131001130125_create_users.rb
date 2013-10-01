class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :avatar
      t.string :handle
      t.string :twitter_token
      t.string :twitter_secret
      t.string :twitter_uid

      t.timestamps
    end
  end
end
