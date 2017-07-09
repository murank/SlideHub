class SetCategoryIdToNullable < ActiveRecord::Migration[5.0]
  def self.up
    change_column :slides, :category_id, :integer, null: true
  end
end
