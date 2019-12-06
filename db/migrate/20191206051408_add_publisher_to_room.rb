class AddPublisherToRoom < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :publisher, :string
  end
end
