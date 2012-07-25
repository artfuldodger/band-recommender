# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('#band-recommendations-tab').click (e) ->
    $('#recommendations-tabs .tabs li').toggleClass('active')
    $('#band-recommendations').show()
    $('#similar-users').hide()

  $('#similar-users-tab').click (e) ->
    $('#recommendations-tabs .tabs li').toggleClass('active')
    $('#band-recommendations').hide()
    $('#similar-users').show()
