// This example adds a search box to a map, using the Google Place Autocomplete
// feature. People can enter geographical searches. The search box will return a
// pick list containing a mix of places and predicted search terms.
var markersArray = [];
var image = '/images/house.png';

function initialize() {

  var markers = [];
  var mapOptions = {
          mapTypeId: google.maps.MapTypeId.ROADMAP,
          center: { lat: 40.7063634, lng: -74.0090963},
          zoom: 15
        };

  var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

  // Create the search box and link it to the UI element.
  var input = /** @type {HTMLInputElement} */(
      document.getElementById('pac-input'));
  map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

  var searchBox = new google.maps.places.SearchBox(
    /** @type {HTMLInputElement} */(input));

  // [START region_getplaces]
  // Listen for the event fired when the user selects an item from the
  // pick list. Retrieve the matching places for that item.
  google.maps.event.addListener(searchBox, 'places_changed', function() {
    var places = searchBox.getPlaces();

    if (places.length == 0) {
      return;
    }
    for (var i = 0, marker; marker = markers[i]; i++) {
      marker.setMap(null);
    }

    // For each place, get the icon, place name, and location.
    markers = [];
    //variable bounds contains window boundaries
    var bounds = new google.maps.LatLngBounds();
    for (var i = 0, place; place = places[i]; i++) {
      var image = {
        url: place.icon,
        size: new google.maps.Size(71, 71),
        origin: new google.maps.Point(0, 0),
        anchor: new google.maps.Point(17, 34),
        scaledSize: new google.maps.Size(25, 25)
      };

      // Create a marker for each place.
      var marker = new google.maps.Marker({
        map: map,
        icon: image,
        title: place.name,
        position: place.geometry.location
      });

      markers.push(marker);

      bounds.extend(place.geometry.location);
    }

    map.fitBounds(bounds);
  });

    
  // [END region_getplaces]

  // Bias the SearchBox results towards places that are within the bounds of the
  // current map's viewport.
  google.maps.event.addListener(map, 'bounds_changed', function() {
    var bounds = map.getBounds();
    searchBox.setBounds(bounds);

    for(i=0;i<markersArray.length; i++){
      markersArray[i].setMap(null);
    }

  });


  // find properties when map moves
  google.maps.event.addListener(map, 'dragend zoom_changed', function() {
    //TODO placeholder for showing loading
    $('.properties-list ul').html('Loading');
    var bounds = map.getBounds();
    var ne = bounds.getNorthEast();
    var sw = bounds.getSouthWest();
    var nelat = ne.lat();
    var nelng = ne.lng();
    var swlat = sw.lat();
    var swlng = sw.lng();
    $.ajax({
      url: '/properties/list',
      data: {nelatitude: nelat,
             nelongitude: nelng,
             swlatitude: swlat,
             swlongitude: swlng
           }
     }).done(function(response){
      $('.properties-list ul').html(print_properties(response, map));
      $('.properties-list ul').html(set_map(response, map));
    });
  });
}

google.maps.event.addDomListener(window, 'load', initialize);


function print_properties(jsonArray, map) {
  html = ''
  jsonArray.forEach(function(json){
   html += '<h6>'+json.attr.heading+'</h6>'+'<div id="carousel-example-generic-' + json.id + '" class="carousel slide" data-ride="carousel">'+
      '<ol class="carousel-indicators">'+
        '<li data-target="#carousel-example-generic" data-slide-to="0" class="active">'+
          '</li>'+
            '<li data-target="#carousel-example-generic" data-slide-to="1"></li>'+
            '<li data-target="#carousel-example-generic" data-slide-to="2"></li>'+
      '</ol>'+
    '<div class="carousel-inner" role="listbox">'+
      '<div class="item active">'+
        "<a href='/properties/" + json.id + "'><img src='"+ json.photos[0].small + "'height = '200' width = '200'>"+
        "</a>"+
          '<div class="carousel-caption">'+
           // ''+ json.attr.heading + ''+
          '</div>'+
        '</div>'+
        '<div class="item">'+
          "<a href='/properties/" + json.id + "'><img src='"+ json.photos[1].small + "''height = '200' width = '200'>"+
          "</a>"+
          '<div class="carousel-caption">'+
          // ''+ json.attr.heading + ''+
        '</div>'+
      '</div>'+
        '<div class="item">'+
          "<a href='/properties/" + json.id + "'><img src='"+ json.photos[2].small + "''height = '200' width = '200'>"+
          "</a>"+
          '<div class="carousel-caption">'+
          // ''+ json.attr.heading + ''+
        '</div>'+
      '</div>'+
    '</div>'+

    '<a class="left carousel-control" href="#carousel-example-generic-' + json.id + '" role="button" data-slide="prev">'+
      '<span class="icon-prev" aria-hidden="true"></span>'+
      '<span class="sr-only">Previous</span>'+
    '</a>'+
    '<a class="right carousel-control" href="#carousel-example-generic-' + json.id + '" role="button" data-slide="next">'+
      '<span class="icon-next" aria-hidden="true"></span>'+
      '<span class="sr-only">Next</span>'+
    '</a>'+
    '</div>';
  })
  return html;
}

 function set_map(jsonArray, map) {   
  jsonArray.forEach(function(json){
    var myLatlng = new google.maps.LatLng(json.latLng[0],json.latLng[1]);
     //add the marker to the map, use the 'map' property
    var marker = new google.maps.Marker({
        position: myLatlng,
        map: map,
        animation: google.maps.Animation.DROP,
        title: json.attr.heading,
        icon: image
    });
    markersArray.push(marker);

    //Sets info window for marker
    var infowindow = new google.maps.InfoWindow({
         content: '<h6>' + json.location.all + '</h6>'
     });

    google.maps.event.addListener(marker, 'click', function() {
      infowindow.open(map,marker);
    });


  })
}

