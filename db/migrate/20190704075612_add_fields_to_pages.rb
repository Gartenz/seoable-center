class AddFieldsToPages < ActiveRecord::Migration[5.2]
  def change
    add_column :pages, :lastmod, :string
    add_index :pages, :url, unique: true
  end
end
