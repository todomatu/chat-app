class CreateRoomUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :room_users do |t|

      t.timestamps
      t.references :user,foreign_key: true,null: false
      t.references :room,foreign_key: true,null: false
    end
  end
end
