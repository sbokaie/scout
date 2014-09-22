class ChannelsController < ApplicationController
  def index
    request = Typhoeus.get(
      "https://www.googleapis.com/youtube/v3/channels?part=contentDetails")
    @results = JSON.parse(request.body)

    @all_channels = []
    @channels = Channel.all

    @channels.each do |channel|
      new_channel = {}
      new_channel["channel"] = channel

    @all_channels.push new_channel

  end

  
end
