class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.integer :targetable_id
      t.string :targetable_type
      t.integer :send_user_id
      t.string :type

      t.timestamps
    end
  end
end
