class CreatePeople < ActiveRecord::Migration
  def change

    create_table :people do |t|

     # t.integer :attestat_id
      t.integer :wmid, :limit => 8
      t.string :name
      t.integer :lvl
      t.string :date
      t.string :att
      t.string :review
      t.string :rdate
    end
  end
end
