class AddImageUrlToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :imageUrl, :string
  end
end
