class ChannelsController < ApplicationController
  # Add ability to respond_to json
  # The route will become /.json 
  # That way, our AJAX call returns JSON that we then put on the page

  def index

    if params[:query]

    url =  "https://www.googleapis.com/youtube/v3/channels?part=+statistics%2C+snippet&forUsername=" + params[:query] +"&key=AIzaSyAp9cRjnSBQIWAdLqRUyWx2OEaY6UCNBFI"
    puts url
      request = Typhoeus.get(url)

      @results = JSON.parse(request.body)

      @username = @results["items"][0]["snippet"]["title"]
      @user_description = @results["items"][0]["snippet"]["description"]
      # According to Docs, image may not be accessible, need to look into
      ap @results["items"][0]["snippet"]["thumbnails"]["default"]["medium"]
      @user_img = @results["items"][0]["snippet"]["thumbnails"]["default"]["medium"]
      @subscriber_count = @results["items"][0]["statistics"]["subscriberCount"]
      @view_count = @results["items"][0]["statistics"]["viewCount"]
      @video_count = @results["items"][0]["statistics"]["videoCount"]
    end

      @all_channels = []
      @channels = Channel.all

      channel_params = params.permit(:username, :user_description, :user_img, :view_count, :video_count)
      
      @channels.each do |channel|
        User.create(channel_params)
        new_channel = {}
        new_channel["channel"] = channel

      @all_channels.push new_channel
    end
      respond_to do |f|
        f.html
        f.json {render json: request.body}
      end
  end

  def hold
    binding.pry
  end
end


