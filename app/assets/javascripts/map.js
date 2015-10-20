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
            console.log("sent location");
            initMap(mapOptions)
        });
    }
    else {
        alert("Please use a browser that supports HTML5")}
}
function getViewerLocation(lat, lng){
    var mapOptions = {
        center: new google.maps.LatLng(lat,lng),
        zoom: 16};
    initMap(mapOptions);
}
function getMarkers(lat, lng){
    return $.ajax({
        url: "graph/load_local_deals",
        type: "GET",
        data: {lat: lat, lng: lng},
        dataType: 'json'
    });
}
function initMap(mapOptions) {
    console.log("building map");
    handler = Gmaps.build('Google');
    handler.buildMap({ provider: mapOptions, internal: {id: 'map_canvas'}}, function(){
        getMarkers(handler.getMap().getCenter().A, handler.getMap().getCenter().F).done(function(result) {
            console.log(result);
            handler.addMarkers(result)
        });
        google.maps.event.addListener(handler.getMap(), 'idle', function() {
            console.log(handler.getMap().getCenter());
            getMarkers(handler.getMap().getCenter().A, handler.getMap().getCenter().F).done(function (result) {
                console.log(result);
                handler.addMarkers(result)
            });
        });
    });
}
