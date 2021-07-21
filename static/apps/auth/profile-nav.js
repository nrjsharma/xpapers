$(document).ready(function () {
    var userID = $('#userID').val()
    $.ajax({
        url: USER_PROFILE_URL + userID + '/',
        type: "GET",
        success: function (data) {
            $("#nav-user-name").html(data.username)
            $("#nav-user-email").html(data.email)
            $("#nav-username").val(data.username);
            $('#nav-user-profile').css('background-image', 'url(' + data.profile_image + ')');
            $("#nav-user-profile-link").attr("href", '/user/' + data.username + '/');
            $("#nav-user-profile-paper-link").attr("href", '/user/' + data.username + '/papers/');
            if(window.location.pathname.split('/')[3] == "papers") {
                $("#nav-user-profile-paper-link").addClass("active");
            }else{
                $("#nav-user-profile-link").addClass("active");
            }
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