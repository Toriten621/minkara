class CreateGroupComments < ActiveRecord::Migration[6.1]
  def change
    create_table :group_comments do |t|
      t.references :group_topic, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
