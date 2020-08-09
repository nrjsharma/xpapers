let responseJSONValue = undefined;
function showError(errorMessage = "something went wrong") {
    $("#formBtn").css("background-color", "#F5A9A9");
    $(".error").html(errorMessage);
    $('.error').css('display', 'block');
}

function hideError() {
    $("#formBtn").css("background-color", "#19aa8d");
    $('.error').css('display', 'none');
}

$("#loginForm").submit(function (event) {
    $("#formBtn").css("background-color", "#F5F6CE");
    hideError()
    event.preventDefault();
    let email = $('#email').val().trim();
    let password = $('#password').val().trim();

    var formData = new FormData();
    formData.append('email', email);
    formData.append('password', password);
    $.ajax({
        url: LOGIN_URL,
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
            window.location = '/'
        }, error: function (rs, e) {
            responseJSONValue = Object.keys(rs.responseJSON)[0];
            showError(rs.responseJSON[responseJSONValue])
        }, complete: function () {
            console.log('request completed')
        }
    }); // end ajax
});