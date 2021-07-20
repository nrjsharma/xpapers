function resetForm() {
    $("#error").html("");
    $("#error").css('display', 'none');
}

function setUserName() {
    // window.onbeforeunload = function () {
    //     return "Username will be set randomly?";
    // };
    $("#usernameForm").submit(function (event) {
        event.preventDefault();
        resetForm();
        let username = $('#username').val().trim();

        if (!username) {
            $("#error").html("enter username");
            $("#error").css('display', 'block');
            return false;
        }
        username = username.toLowerCase();
        var formData = new FormData();
        formData.append('username', username);
        $.ajax({
            url: SET_USERNAME_URL +'0/',
            headers: {
                'Conten-Type': 'application/json',
                'X-CSRFToken': $.cookie("csrftoken")
            },
            type: "PATCH",
            data: formData,
            cache: false,
            processData: false,
            contentType: false,
            beforeSend: function () {
                $('#username-form-btn').prop('disabled', true);
                console.log('saving...')
            },
            success: function (data) {
                // window.onbeforeunload = function () {};
                window.location = `/user/${data.username}/`
            },
            error: function (rs, e) {
                if (rs.responseJSON['detail']) {
                    $("#error").html(rs.responseJSON['detail']);
                } else if (rs.responseJSON['non_field_errors']) {
                    $("#error").html(rs.responseJSON['non_field_errors']);
                } else if (rs.responseJSON['username']) {
                    $("#error").html(rs.responseJSON['username']);
                } else {
                    $("#error").html(rs.responseText);
                }
                $("#error").css('display', 'block');
                console.error(rs.status);
            },
            complete: function () {
                $('#username-form-btn').prop('disabled', false);
            }
        }); // end ajax

    });
}

$(document).ready(function () {
    setUserName()
});