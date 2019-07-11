class CreateStatistics < ActiveRecord::Migration[5.2]
  def change
    create_table :statistics do |t|
      t.references :page, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
