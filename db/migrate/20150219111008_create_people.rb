class CreatePeople < ActiveRecord::Migration
  def change
    create_table :attestates do |t|

      t.string :attname
    end
    create_table :people do |t|

      t.integer :attestate_id
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
