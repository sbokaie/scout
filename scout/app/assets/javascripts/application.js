// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require handlebars.runtime
//= require_tree ./templates
//= require_tree .

var scout = {};

$(function(){
  $("#results").on("click", ".hold", function(event) {
      console.log("HOLDING ONTO", this.source)
      var channelId = $(this).closest(".thumbnail").attr("data-atr-channel-id")
      var viewCount = $(this).closest(".thumbnail").find(".viewCount strong").text()
      $.post("/channels?chanelId=" + channelId + "&viewCount=" + viewCount )
        .success(function(data) {
          console.log(data)
          alert("successfully saved!")
        })

      // this is where you save to the database
      // then update fresh data as new entries
  })

  $("#usernameSearch").on("submit", function(event){
    event.preventDefault();
    $this = $(this)
    $.get("/search.json?query="+$this.find("#queryParam").val())
    .success(function(data) {
      console.log(data)

        var source = {} 
        source.username= data["items"][0]["snippet"]["title"]
        source.description = data["items"][0]["snippet"]["description"]
        source.viewCount = data["items"][0]["statistics"]["viewCount"]
        source.videoCount = data["items"][0]["statistics"]["videoCount"]
        source.subscriberCount = data["items"][0]["statistics"]["subscriberCount"]
        source.channelid = data["items"][0]["id"]


        result = HandlebarsTemplates['channels/channels'](source);
        $("#results").append(result)
        
        

 
    })
  })
})

// 