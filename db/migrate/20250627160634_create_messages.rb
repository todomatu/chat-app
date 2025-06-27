class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|

      t.timestamps
      t.string :content
      t.references :user,foreign_key: true, null: false
      t.references :room,foreign_key: true, null: false
    end
  end
end
