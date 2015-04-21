$(document).ready(function(){

//ajax get for displaying new criteria form

$('#add').on('click', function(event){
  event.preventDefault();
  $.ajax({
    url: '/user_preferences/new',
  }).done(function(result){
    $('.preflist').append(result);
  });
});






// $('.newcrit').on('submit', function(event){
//   event.preventDefault();
// });

});