class ChannelsController < ApplicationController
  def index
      request = Typhoeus.get(
        "https://www.googleapis.com/youtube/v3/channels?part=+statistics%2C+snippet&forUsername=petroliciousco&key=AIzaSyAp9cRjnSBQIWAdLqRUyWx2OEaY6UCNBFI")

      # + params[:query] +
      @results = JSON.parse(request.body)

      @username = @results["items"][0]["snippet"]["title"]
      @user_description = @results["items"][0]["snippet"]["description"]
      # According to Docs, image may not be accessible, need to look into
      ap @results["items"][0]["snippet"]["thumbnails"]["default"]["medium"]
      @user_img = @results["items"][0]["snippet"]["thumbnails"]["default"]["medium"]
      @subscriber_count = @results["items"][0]["statistics"]["subscriberCount"]
      @view_count = @results["items"][0]["statistics"]["viewCount"]
      @video_count = @results["items"][0]["statistics"]["videoCount"]

      @all_channels = []
      @channels = Channel.all

      channel_params = params.permit(:username, :user_description, :user_img, :view_count, :video_count)
      
      @channels.each do |channel|
        User.create(channel_params)
        new_channel = {}
        new_channel["channel"] = channel

      @all_channels.push new_channel
    end
  end
end


