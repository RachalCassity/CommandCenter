class AddReplyToMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :reply, :text
  end
end
