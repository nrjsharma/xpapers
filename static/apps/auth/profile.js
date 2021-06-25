function disconectSocial() {
    $.ajax({
        url: DISCONNECT_SOCIAL_URL,
        headers: {
            'Conten-Type': 'application/json',
            'X-CSRFToken': $.cookie("csrftoken")
        },
        type: "POST",
        cache: false,
        processData: false,
        contentType: false,
        beforeSend: function () {
            $('#disconnect-btn').prop('disabled', true);
        },
        success: function (data) {
            location.reload();
        },
        error: function (rs, e) {
            alert(rs.status)
            console.error(rs.responseText);
        },
        complete: function () {
            $('#disconnect-btn').prop('disabled', false);
        }
    }); // end ajax
}