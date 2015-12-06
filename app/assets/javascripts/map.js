function findUser(){
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function(position) {
            var mapOptions = {
                center: new google.maps.LatLng(position.coords.latitude, position.coords.longitude),
                zoom: 16};
            console.log("got location");
            $.ajax({
                url: "graph/save_user_location",
                type: "POST",
                data: {lat: position.coords.latitude, lng: position.coords.longitude}
            });
            initMap(mapOptions)
        },
        function (error) {
            if (error.code == error.PERMISSION_DENIED) {
                console.log("location denied");
                var mapOptions = {
                    center: new google.maps.LatLng(34.413347, -119.855441),
                    zoom: 16
                };
                initMap(mapOptions)
            }
        });
    }
    else {
        alert("Please use a browser that supports HTML5")
    }
}
function getViewerLocation(lat, lng){
    var mapOptions = {
        center: new google.maps.LatLng(lat,lng),
        zoom: 16};
    initMap(mapOptions);
}
function getMarkers(lat, lng, num){
    return $.ajax({
        url: "graph/load_local_deals",
        type: "GET",
        data: {lat: lat, lng: lng, num: num},
        dataType: 'json'
    });
}
function updateCount(deal_id, count_type){
    $.ajax({
        url: "deals/update_" + count_type + "_count",
        type: "PATCH",
        data: {deal_id: deal_id},
        dataType: 'json'
    });
}

function addMarkers(handler){
  getMarkers(handler.getMap().getCenter().lat(), handler.getMap().getCenter().lng(), window["countClicks"]).done(function(result) {
    result.map(function(m){
      marker = handler.addMarker(m);
      google.maps.event.addListener(marker.getServiceObject(), 'click', function(){
        var deal_id = m.infowindow.split("deal_id: ").pop().split('<')[0];
        updateCount(deal_id, 'view');
      });
    });
  });
}

function initMap(mapOptions) {
    handler = Gmaps.build('Google');
    handler.buildMap({ provider: mapOptions, internal: {id: 'map_canvas'}}, function(){
      addMarkers(handler)
      google.maps.event.addListener(handler.getMap(), 'idle', function() {
        window["countClicks"] = 1
        addMarkers(handler)
      });
      document.getElementById("click").addEventListener("click", function(){
        addMarkers(handler)
      });
    });
}
