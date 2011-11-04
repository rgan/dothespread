function rsvp() {
    FB.getLoginStatus(function(response) {
      if (response.authResponse) {
        doRsvp();
      } else {
        FB.login(function(response) {
            if (response.authResponse) {
                doRsvp();
            }
        });
      }
    });
}

function doRsvp() {
    FB.api('/265793463456799/attending', 'post', { message: ''}, function(response) {
        if (!response || response.error) {
            alert('Error RSVPing for event');
        }
    });
}