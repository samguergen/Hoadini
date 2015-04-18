function findPlace(nelatitude, nelongitude, swlatitude, swlongitude) {
  $.ajax(
    {
      beforeSend: function(xhr) {
        xhr.setRequestHeader("X-Mashape-Key", "Aq8RN3VWDnmshWqAaThekfgTPEbap1a3Tn3jsnBYV3fjrNDyQZ");
      },
      url: 'https://zilyo.p.mashape.com/search',
      data: {
        isinstantbook: 'true',
        nelatitude: nelatitude,//'22.37',
        nelongitude: nelongitude,//'-154.48000000000002',
        swlatitude: '18.55',
        swlongitude: '-160.52999999999997',
        provider: 'airbnb,housetrip'
      },
      dataType: 'JSON'
    }).done(function(r){
      console.log(r);
  })
}