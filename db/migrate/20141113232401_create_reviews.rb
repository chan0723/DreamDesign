class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :body
      t.references :user, index: true
      t.references :school, index: true

      t.timestamps null: false
    end
  end
end
