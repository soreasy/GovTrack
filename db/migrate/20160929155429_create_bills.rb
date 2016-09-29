class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.string :introduced_date
      t.string :status
      t.integer :congress_id
      t.string :sponsor
      t.string :title
      t.string :link
      t.string :desc

      t.timestamps(null: false)
    end
  end
end
