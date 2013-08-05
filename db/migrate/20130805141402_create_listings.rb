class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :title
      t.text :description
      t.integer :starting_price
      t.integer :current_price
      t.integer :rrp
      t.date :start_date
      t.string :time
      t.time :time_left
      t.time :time_per_bid

      t.timestamps
    end
  end
end
