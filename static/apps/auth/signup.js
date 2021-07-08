function resetForm() {
    $("#error").html("");
    $("#error").css('display', 'none');
    $('#loginBtn').prop('disabled', false);
}

$(document).ready(function () {
    $("#signupForm").submit(function (event) {
        event.preventDefault();
        resetForm();
        let email = $('#email').val().trim();
        let password = $('#password').val().trim();

        if(!email){
            $("#error").html("enter email");
            $("#error").css('display', 'block');
            return;
        }
        if(!password){
            $("#error").html("enter password");
            $("#error").css('display', 'block');
            return;
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
                $('#loginBtn').prop('disabled', true);
                console.log('saving...')
            },
            success: function (data) {
                console.log('login...')
                window.location = '/'
            },
            error: function (rs, e) {
                console.log(rs)
                if (rs.responseJSON['detail']) {
                    $("#error").html(rs.responseJSON['detail']);
                }else if(rs.responseJSON['non_field_errors']) {
                    $("#error").html(rs.responseJSON['non_field_errors']);
                }else if(rs.responseJSON['email']){
                    $("#error").html(rs.responseJSON['email']);
                }else{
                    $("#error").html(rs.responseText);
                }
                $("#error").css('display', 'block');
                console.error(rs.status);
            },
            complete: function () {
                $('#loginBtn').prop('disabled', false);
            }
        }); // end ajax

    });
});