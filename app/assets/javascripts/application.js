// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
function StopWatch() {
  var startTime = null;
  var stopTime = null;
  var totalTime = 0;
  var running = false;

  function getTime(){
    var day = new Date();
    return day.getTime();
  }

  this.running = function(){
    return running;
  }

  this.toggle = function(){
    if (running == true)
      this.stop();
    else
      this.start();
  }

  this.start = function(){ 
    startTime = getTime();
    stopTime = null; 
    running = true;    
  }

  this.stop = function(){ 
    stopTime = getTime();
    totalTime += this.duration();
    running = false; 
  }

  this.total = function(){
    return Math.round(totalTime + this.duration());
  }

  this.duration = function(){ 
    if(startTime == null || running == false)
      return 0;
    else {
      if (stopTime == null)
        return (getTime() - startTime) / 1000;
      else
        return (stopTime - startTime) / 1000;
    }
  }
}

ltimer = new StopWatch();
rtimer = new StopWatch();
var id = setInterval(function() {
  $("#event_left_breast").val(ltimer.total());
}, 500);
var id = setInterval(function() {
  $("#event_right_breast").val(rtimer.total());
}, 500);

$(document).ready(function() {
  $("#left_button").click(function(a) {
    ltimer.toggle();
    if (ltimer.running())
      $("#left_button").attr("class", "btn btn-success");
    else
      $("#left_button").attr("class", "btn btn-primary");

    return false;
  });
  $("#right_button").click(function(a) {
    rtimer.toggle();
    if (rtimer.running())
      $("#right_button").attr("class", "btn btn-success");
    else
      $("#right_button").attr("class", "btn btn-primary");

    return false;
  });
});
