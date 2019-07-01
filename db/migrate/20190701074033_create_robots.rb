class CreateRobots < ActiveRecord::Migration[5.2]
  def change
    create_table :robots do |t|
      t.references :site
      t.string :body

      t.timestamps
    end
  end
end
