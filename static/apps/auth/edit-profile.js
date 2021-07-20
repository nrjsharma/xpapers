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

function select2_serialize(data) {
    let return_data = []
    for (let obj of data) {
        let temp = new Object()
        temp.id = "#Ea^T|@I^p<0>-" + obj.id;
        temp.text = obj.name;
        return_data.push(temp)
    }
    return return_data
}

function select2_university() {
    $('#university').select2({
        placeholder: "University Name",
        allowClear: true,
        tags: true,
        ajax: {
            url: UNIVERSITY_SELECT2_URL,
            dataType: 'json',
            processResults: function (data) {
                return {
                    results: select2_serialize(data)
                };
            }
        },
    });

    // Fetch the preselected item, and add to the control
    var thisSelect = $('#university');
    var userID = $('#userID').val()
    $.ajax({
        type: 'GET',
        url: USER_PROFILE_URL + userID + '/',
    }).then(function (data) {
        // create the option and append to Select2
        if (data.university) {
            var option = new Option(data.university.name, "#Ea^T|@I^p<0>-" + data.university.id, true, true);
            thisSelect.append(option).trigger('change');
        }
        // manually trigger the `select2:select` event
        thisSelect.trigger({
            type: 'select2:select',
            params: {
                data: data
            }
        });
    });
}

function select2_collage(university_id = null) {
    $('#collage').select2({
        placeholder: "Collage Name",
        allowClear: true,
        tags: true,
        ajax: {
            url: COLLAGE_SELECT2_URL + '?uni=' + university_id,
            dataType: 'json',
            processResults: function (data) {
                return {
                    results: select2_serialize(data)
                };
            }
        },
    });

    // Fetch the preselected item, and add to the control
    var thisSelect = $('#collage');
    var userID = $('#userID').val()
    $.ajax({
        type: 'GET',
        url: USER_PROFILE_URL + userID + '/',
    }).then(function (data) {
        // create the option and append to Select2
        if (data.collage) {
            var option = new Option(data.collage.name, "#Ea^T|@I^p<0>-" + data.collage.id, true, true);
            thisSelect.append(option).trigger('change');
        }
        // manually trigger the `select2:select` event
        thisSelect.trigger({
            type: 'select2:select',
            params: {
                data: data
            }
        });
    });
}

function select2_course() {
    $('#course').select2({
        placeholder: "Course (BTech, MBA, MTech,...)",
        allowClear: true,
        tags: true,
        ajax: {
            url: COURSE_SELECT2_URL,
            dataType: 'json',
            processResults: function (data) {
                return {
                    results: select2_serialize(data)
                };
            }
        },
    });

    // Fetch the preselected item, and add to the control
    var thisSelect = $('#course');
    var userID = $('#userID').val()
    $.ajax({
        type: 'GET',
        url: USER_PROFILE_URL + userID + '/',
    }).then(function (data) {
        // create the option and append to Select2
        if (data.course) {
            var option = new Option(data.course.name, "#Ea^T|@I^p<0>-" + data.course.id, true, true);
            thisSelect.append(option).trigger('change');
        }
        // manually trigger the `select2:select` event
        thisSelect.trigger({
            type: 'select2:select',
            params: {
                data: data
            }
        });
    });
}

function select2_branch() {
    $('#branch').select2({
        placeholder: "Branch (CSE, CEVIL, ECE, MECH ,...)",
        allowClear: true,
        tags: true,
        ajax: {
            url: BRANCH_SELECT2_URL,
            dataType: 'json',
            processResults: function (data) {
                return {
                    results: select2_serialize(data)
                };
            }
        },
    });

    // Fetch the preselected item, and add to the control
    var thisSelect = $('#branch');
    var userID = $('#userID').val()
    $.ajax({
        type: 'GET',
        url: USER_PROFILE_URL + userID + '/',
    }).then(function (data) {
        // create the option and append to Select2
        if (data.branch) {
            var option = new Option(data.branch.name, "#Ea^T|@I^p<0>-" + data.branch.id, true, true);
            thisSelect.append(option).trigger('change');
        }
        // manually trigger the `select2:select` event
        thisSelect.trigger({
            type: 'select2:select',
            params: {
                data: data
            }
        });
    });
}

function initSelect2() {
    select2_university();
    select2_collage();
    select2_course();
    select2_branch();
}

function resetForm() {
    $(".error").html("");
    $(".error").css('display', 'none');
    $('#formBtn').prop('disabled', false);
}

$(document).ready(function () {
    initSelect2();

    $("#formBtn").click(function () {
        $("#profileForm").submit();
    });

    $("#profileForm").submit(function (event) {
        event.preventDefault();
        resetForm()
        var userID = $('#userID').val()
        if (!$('#username').val().trim()) {
            $(".error").html("enter username");
            $(".error").css('display', 'block');
            return
        } else if (!$('#email').val().trim()) {
            $(".error").html("enter email");
            $(".error").css('display', 'block');
            return
        }
        var formData = new FormData($('#profileForm')[0]);
        $.ajax({
            url: USER_PROFILE_URL + userID + '/',
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
                $('#formBtn').prop('disabled', true);
                console.log('saving...')
            },
            success: function (data) {
                window.location = `/user/${data.username}/`
            },
            error: function (rs, e) {
                console.log(rs)
                if (rs.responseJSON) {
                    if (rs.responseJSON['username']) {
                        $(".error").html(rs.responseJSON['username']);
                    } else {
                        $(".error").html(rs.responseText);
                    }
                }

                $(".error").css('display', 'block');
                console.error(rs.status);
            },
            complete: function () {
                $('#formBtn').prop('disabled', false);
                console.log('request completed')
            }
        }); // end ajax
    });


});

$("#profile-image").change(function () {
    readURL(this);
});

function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            // $('#profile-img-tag').attr('src', e.target.result);
            $('#main-user-profile').css('background-image', 'url(' + e.target.result + ')');
        }
        reader.readAsDataURL(input.files[0]);
    }
}
