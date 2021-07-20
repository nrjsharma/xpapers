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
        formData.append('email', email);
        formData.append('password', password);
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
            },
            success: function (data) {
                window.location = '/'
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
});