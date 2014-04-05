class CreatePodcasts < ActiveRecord::Migration
  def change
    create_table :podcasts do |t|
      t.integer :number
      t.string :title
      t.string :description
      t.date :date
    end
  end
end
