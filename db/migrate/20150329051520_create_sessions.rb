class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.references :user, index: true, foreign_key: true
      t.string :authentication_token
      t.datetime :expires_at
      t.timestamps null: false
    end
  end
end
