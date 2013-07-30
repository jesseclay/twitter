$(document).ready(function() {
 
  window.onload = function() {
    var refreshDiv = $('.wait');
    if (refreshDiv) {
      refreshDiv.html("<img src='../images/pac.gif' alt='loading...' />")
      refreshDiv.append("<h2>Please wait while we fetch the content!</p>")
      $.ajax({
        url: window.location.pathname,
        method: 'get'
      }).done(function(msg){
        $('.container').html(msg);
        refreshDiv.remove();
        console.log(msg);
      });
    }
  }
});
