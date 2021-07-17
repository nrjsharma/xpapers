function resetForm() {
    $("#error").html("");
    $("#error").css('display', 'none');
    $('#loginBtn').prop('disabled', false);
}

function signUpValidation(email=null, password=null, conformPassword=null) {
    if (!email) {
        $("#error").html("enter email");
        $("#error").css('display', 'block');
        return false;
    }
    if (!password) {
        $("#error").html("enter password");
        $("#error").css('display', 'block');
        return false;
    }
    if (!conformPassword) {
        $("#error").html("enter conform password");
        $("#error").css('display', 'block');
        return false;
    }
    if (password.length < 6) {
        $("#error").html("password lenght should be greater than 6");
        $("#error").css('display', 'block');
        return false;
    }
    if (password != conformPassword) {
        $("#error").html("password did't match");
        $("#error").css('display', 'block');
        return false;
    }
    return true
}

function setUserName() {
    window.onbeforeunload = function () {
        return "Username will be set randomly?";
    };
    $("#usernameForm").submit(function (event) {
        event.preventDefault();
        resetForm();
        let username = $('#username').val().trim();

        if (!username) {
            $("#error-username").html("enter username");
            $("#error-username").css('display', 'block');
            return false;
        }
        var formData = new FormData();
        formData.append('username', username)
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
                window.onbeforeunload = function () {};
                window.location = `/user/${data.username}/`
            },
            error: function (rs, e) {
                if (rs.responseJSON['detail']) {
                    $("#error-username").html(rs.responseJSON['detail']);
                } else if (rs.responseJSON['non_field_errors']) {
                    $("#error-username").html(rs.responseJSON['non_field_errors']);
                } else if (rs.responseJSON['username']) {
                    $("#error-username").html(rs.responseJSON['username']);
                } else {
                    $("#error-username").html(rs.responseText);
                }
                $("#error-username").css('display', 'block');
                console.error(rs.status);
            },
            complete: function () {
                $('#username-form-btn').prop('disabled', false);
            }
        }); // end ajax

    });
}

function signup() {
    $("#signupForm").submit(function (event) {
        event.preventDefault();
        resetForm();
        let email = $('#email').val().trim();
        let password = $('#password').val().trim();
        let conformPassword = $('#conform-password').val().trim();

        if (!signUpValidation(email = email, password = password, conformPassword = conformPassword)) {
            return
        }
        var formData = new FormData();
        formData.append('email', email)
        formData.append('password', password)
        $.ajax({
            url: SIGNUP_URL,
            headers: {
                'Conten-Type': 'application/json',
                'X-CSRFToken': $.cookie("csrftoken")
            },
            type: "POST",
            data: formData,
            cache: false,
            processData: false,
            contentType: false,
            beforeSend: function () {
                $('#signup-form-btn').prop('disabled', true);
                console.log('saving...')
            },
            success: function (data) {
                // window.location = `/user/${data.username}/`
                $("#SignupBlock").css('display', 'none');
                $("#UsernameBlock").css('display', 'block');
            },
            error: function (rs, e) {
                if (rs.responseJSON['detail']) {
                    $("#error").html(rs.responseJSON['detail']);
                } else if (rs.responseJSON['non_field_errors']) {
                    $("#error").html(rs.responseJSON['non_field_errors']);
                } else if (rs.responseJSON['email']) {
                    $("#error").html(rs.responseJSON['email']);
                } else {
                    $("#error").html(rs.responseText);
                }
                $("#error").css('display', 'block');
                console.error(rs.status);
            },
            complete: function () {
                $('#signup-form-btn').prop('disabled', false);
            }
        }); // end ajax

    });
}

$(document).ready(function () {
    signup()
    setUserName()
});