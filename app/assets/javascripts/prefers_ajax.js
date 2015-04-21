// $(document).ready(function(){
// 	$('#preference-form').on('submit', function(event){
// 		event.preventDefault();
// 		$target = $(event.target);
// 		var url = '/user_preferences/new';
// 		$.post(url, {preference: {content: $('#new-preference').val()
// 	}}, {
// 		dataType: 'json'
// 	}).then(function(preference){
// 		loadPreferences();
// 		$('#new-preference').val('')
// 		})
// 	});
// });