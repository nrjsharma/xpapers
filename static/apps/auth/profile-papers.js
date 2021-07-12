$(document).ready(function () {
    var userID = $('#userID').val()
    $.ajax({
        url: USER_PROFILE_URL + userID + '/',
        type: "GET",
        success: function (data) {
        },
        error: function (rs, e) {
            if(rs.responseJSON){
                if(rs.responseJSON['detail']){
                    $(".error").html(rs.responseJSON['detail']);
                }
            }else{
                $(".error").html(rs.responseText);
            }
            $(".error").css('display', 'block');
        }
    }); // end ajax
});