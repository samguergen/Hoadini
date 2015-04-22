$(document).ready(function(){

//ajax get for displaying new criteria form

$('#add').on('click', function(event){
  event.preventDefault();
  $.ajax({
    url: '/user_preferences/new'
  }).done(function(result){
    $('#add').toggle(false);
    $('.preflist').append(result);
  });
  });


//ajax create for displaying submitting criteria

$('.preflist').on('submit', '.newcrit', function(event){
  event.preventDefault();

  var $form = $( this ),

  crit = $form.find("input[type='radio']:checked").val(),
  score = $form.find( "input[name='score']" ).val(),
  search = $form.find( "input[name='search']" ).val();
  // url = $form.attr( "action" );
$.ajax({
    method: 'POST',
    url: '/user_preferences',
    data: {
      criterium_id: crit,
      score: score,
      search: search
    }
  }).done(function(result){
    $('.newcrit').prepend(result);
  });
});


//ajax get for displaying edit criteria form

$('.edit').on('click', function(event){
  event.preventDefault();
  target = event.target;
  $.ajax({
    url: target.pathname
  }).done(function(result){
    $('.preflist').append(result);
  });
  });

// ajax edit form

$('.preflist').on('submit', '.editcrit', function(event){
  event.preventDefault();
    // debugger;
    target = event.target;

  var $form = $( this ),

  score = $form.find( "input[name='score']" ).val(),
  search = $form.find( "input[name='search']" ).val();
  // url = $form.attr( "action" );
$.ajax({
    method: 'PATCH',
    url: target.action,
    data: {
      score: score,
      search: search
    }
  }).done(function(result){
    console.log(result);
    $('.preflist').append(result);
    $('.editcrit').toggle(false);
  });
});

});