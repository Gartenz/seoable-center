class CreatePages < ActiveRecord::Migration[5.2]
  def change
    create_table :pages do |t|
      t.references :site, foreign_key: true
      t.string :url
      t.text :body

      t.timestamps
    end
  end
end
