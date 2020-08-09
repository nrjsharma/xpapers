function showError(errorMessage = "something went wrong") {
    $("#formBtn").css("background-color", "#F5A9A9");
    $(".error").html(errorMessage);
    $('.error').css('display', 'block');
}

function hideError() {
    $("#formBtn").css("background-color", "#19aa8d");
    $('.error').css('display', 'none');
}

$("#signupForm").submit(function (event) {
    $("#formBtn").css("background-color", "#F5F6CE");
    hideError()
    event.preventDefault();
    let username = $('#username').val().trim();
    let email = $('#email').val().trim();
    let password = $('#password').val().trim();
    let confirmPassword = $('#confirmPassword').val().trim();

    if (username.length < 3) {
        showError("username should be greater then two character")
    } else if (password.length < 5) {
        showError('password should be greater then four character')
    } else if (password != confirmPassword) {
        showError('password didn\'t match')
    } else {
        var formData = new FormData();
        formData.append('username', username);
        formData.append('email', email);
        formData.append('password', password);
        $.ajax({
            url: SIGNUP_URL,
            headers: {
                'Conten-Type': 'application/json',
                'X-CSRFToken': $.cookie("csrftoken")
            },
            type: "post",
            data: formData,
            cache: false,
            processData: false,
            contentType: false,
            success: function (data) {
                $("#formBtn").css("background-color", "#31B404");
            }, error: function (rs, e) {
                responseJSONValue = Object.keys(rs.responseJSON)[0];
                if(responseJSONValue == "username"){
                    showError("username already registered")
                }else if(responseJSONValue == "email"){
                    showError("email already registered")
                }else{
                    showError(rs.responseJSON[responseJSONValue])
                }
            }, complete: function () {
                console.log('request completed')
            }
        }); // end ajax
    }

});