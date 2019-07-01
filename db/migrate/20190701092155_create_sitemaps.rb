class CreateSitemaps < ActiveRecord::Migration[5.2]
  def change
    create_table :sitemaps do |t|
      t.references :site, foreign_key: true
      t.string :body
      t.string :url
      
      t.timestamps
    end
  end
end
