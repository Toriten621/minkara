class CreateGroupTopics < ActiveRecord::Migration[6.1]
  def change
    create_table :group_topics do |t|
      t.references :group, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
