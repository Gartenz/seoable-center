$(document).on('turbolinks:load', function() {
  $('.get-stats').on('ajax:success', function(e) {
    result = e.detail[0];
    stats = JST['templates/stats']({stats: result})
    $('.statistics').html(stats)
  });
});
