$(document).ready(function () {
    var userID = $('#userID').val()
    $.ajax({
        url: USER_PROFILE_URL + userID + '/',
        type: "GET",
        success: function (data) {
            $("#set-user-name").html(data.username)
            $("#user-email").html(data.email)
            $("#username").val(data.username);
            $("#email").val(data.email);
            if (data.university) {
                $("#university").val(data.university.name);
            }
            if (data.collage) {
                $("#collage").val(data.collage.name);
            }

            if (data.course) {
                $("#course").val(data.course.name);
            }

            if (data.branch) {
                $("#branch").val(data.branch.name);
            }

            $('#user-profile').css('background-image', 'url(' + data.profile_image + ')');
            $('#main-user-profile').css('background-image', 'url(' + data.profile_image + ')');
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