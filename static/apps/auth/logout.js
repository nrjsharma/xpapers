$("#logout-form").submit(function (event) {
    event.preventDefault();
    let form = $('#logout-form');
    $.ajax({
        url: LOGOUT_URL,
        headers: {
            'Conten-Type': 'application/json',
            'X-CSRFToken': $.cookie("csrftoken")
        },
        type: "POST",
        data: form.serialize(),
        success: function (data) {
            window.location = '/'
        }, error: function (rs, e) {
            console.error(rs.responseText)
            console.error(rs.status)
        }, complete: function () {
            console.log('request completed')
        }

    }); // end ajax
});