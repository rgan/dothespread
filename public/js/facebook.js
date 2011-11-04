function rsvp() {
    FB.login(function(response) {
        if (response.authResponse) {
            doRsvp();
        }
    }, { scope: 'rsvp_event' });
}

function doRsvp() {
    FB.api('/265793463456799/attending', 'post', { message: ''}, function(response) {
        if (!response || response.error) {
            alert('There was a problem sending your RSVP to Facebook.');
        } else {
            alert("Thanks! We've sent your RSVP to Facebook.");
        }
    });

}