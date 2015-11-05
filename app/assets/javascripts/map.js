function geolocateUser(){
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function(position) {
            return [position.coords.latitude, position.coords.longitude];
        });
    }
    else {
        alert("Please use a browser that supports HTML5")}
}
function getUserWithNoCache(){
    var location = geolocateUser();
    saveUserLocation(location[0], location[1]);
    var mapOptions = {
        center: new google.maps.LatLng(location[0], location[1]),
        zoom: 16};
    initMap(mapOptions, location[0], location[1]);
}
function saveUserLocation(lat, lng) {
    $.ajax({
        url: "graph/save_user_location",
        type: "POST",
        data: {lat: lat, lng: lng}
    });
}
function getViewerLocation(lat, lng){
    var mapOptions = {
        center: new google.maps.LatLng(lat,lng),
        zoom: 16};
    initMap(mapOptions, lat, lng);
}
function getMarkers(lat, lng){
    return $.ajax({
        url: "graph/load_local_deals",
        type: "GET",
        data: {lat: lat, lng: lng},
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
function initMap(mapOptions, lat, lng) {
    handler = Gmaps.build('Google');
    handler.buildMap({ provider: mapOptions, internal: {id: 'map_canvas'}}, function(){
        //Determine if user is in a different location
        var location = geolocateUser();
        if(location[0] !== lat || location[1] !== lng){
            handler.getMap().center = new google.maps.LatLng(location[0], location[1]);
        }
        //After getting location
        getMarkers(handler.getMap().getCenter().A, handler.getMap().getCenter().F).done(function(result) {
            result.map(function(m){
                marker = handler.addMarker(m);
                //INFO Window Click Listener
                google.maps.event.addListener(marker.getServiceObject(), 'click', function(){
                    //TODO: Clean up HTML parsing
                    var deal_id = m.infowindow.split("deal_id: ").pop().split('<')[0];
                    updateCount(deal_id, 'view');
                });
            });
        });
        //Map Move IDLE Listener
        google.maps.event.addListener(handler.getMap(), 'idle', function() {
            getMarkers(handler.getMap().getCenter().A, handler.getMap().getCenter().F).done(function (result) {
                result.map(function(m){
                    marker = handler.addMarker(m);
                    //INFO Window Click Listener
                    google.maps.event.addListener(marker.getServiceObject(), 'click', function(){
                        //TODO: Clean up HTML parsing
                        var deal_id = m.infowindow.split("deal_id: ").pop().split('<')[0];
                        updateCount(deal_id, 'view');
                    });
                });
            });
        });
    });
}
