class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.timestamps
      t.string :username
      t.string :user_description
      t.string :user_img
      t.integer :subscriber_count
      t.integer :view_count
      t.integer :video_count

      @view_count = @results["items"][0]["statistics"]["viewCount"]
      @video_count = @results["items"][0]["statistics"]["videoCount"]
    end
  end
end
