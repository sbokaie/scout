class ChannelsController < ApplicationController
  def index
    request = Typhoeus.get(
      "https://www.googleapis.com/youtube/v3/channels?part=contentDetails")
    @results = JSON.parse(request.body)
  end
end
