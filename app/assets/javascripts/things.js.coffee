$(document).on 'turbolinks:load', ->
  $(".image-text-container").mouseenter ->
    $(this).children('.image-text').first().css('opacity', '1')
  $(".image-text-container").mouseleave ->
    $(this).children('.image-text').first().css('opacity', '0')

  $("input.submit-on-click").on 'change', ->
    $(this).closest('form').submit()
