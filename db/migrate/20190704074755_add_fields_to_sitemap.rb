class AddFieldsToSitemap < ActiveRecord::Migration[5.2]
  def change
    add_column :sitemaps, :lastmod, :string
    add_index :sitemaps, :url, unique: true
  end
end
