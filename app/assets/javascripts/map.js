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
function updateCount(deal_id, count_type){
    $.ajax({
        url: "deals/update_" + count_type + "_count",
        type: "PATCH",
        data: {deal_id: deal_id},
        dataType: 'json'
    });
}
function initMap(mapOptions) {
    console.log("building map");
    handler = Gmaps.build('Google');
    handler.buildMap({ provider: mapOptions, internal: {id: 'map_canvas'}}, function(){
        getMarkers(handler.getMap().getCenter().G, handler.getMap().getCenter().K).done(function(result) {
            result.map(function(m){
                marker = handler.addMarker(m);
                google.maps.event.addListener(marker.getServiceObject(), 'click', function(){
                    //TODO: Clean up HTML parsing
                    var deal_id = m.infowindow.split("deal_id: ").pop().split('<')[0];
                    updateCount(deal_id, 'view');
                });
            });
        });
        google.maps.event.addListener(handler.getMap(), 'idle', function() {
            getMarkers(handler.getMap().getCenter().G, handler.getMap().getCenter().K).done(function (result) {
                result.map(function(m){
                    marker = handler.addMarker(m);
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
