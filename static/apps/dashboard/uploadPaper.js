$("#upload-paper").submit(function (event) {
    event.preventDefault();
    $('#btn-submit').prop('disabled', true);
    $('.upload-paper').css("display", "none");
    $('.uploading').css("display", "block");
    var progress_bar = new ldBar("#progressBar");
    var data = new FormData($('#upload-paper')[0]);
    data.append('csrfmiddlewaretoken', $.cookie("csrftoken"));
    $.ajax({
        // xhr method is for Progress bar
        xhr: function () {
            var xhr = new window.XMLHttpRequest();
            xhr.upload.addEventListener("progress", function (evt) {
                var percent = Math.round(evt.loaded / evt.total * 100)
                if (percent < 100) {
                    progress_bar.set(Math.round(percent));
                }
                else {
                    document.getElementById("progressBar").innerHTML = "<i>loading...</i>";
                }
            });
            return xhr;
        },
        url: UPLOAD_PAPER_URL,
        type: "post",
        data: data,
        cache: false,
        processData: false,
        contentType: false,
        success: function (data) {
            Swal.fire({
                icon: "success",
                title: "Uploaded Successfully",
                showConfirmButton: false,
                timer: 2000
            });
            $('.uploading').css("display", "none");
            $('.upload-successfully').css("display", "block");
        }, error: function (rs, e) {
            Swal.fire({
                icon: "error",
                title: "Error",
                text: rs.responseText,
                showConfirmButton: true,
                confirmButtonText: "Close"
            });
            $('#btn-submit').prop('disabled', false);
        }
    });
});

function preSetSelect2Data(field=null) {
    // Setting the preselected item, and add to the control
    if (field && window['user'] && window['user'][`${field}`]) {
        var thisSelect = $(`#${field}`);
        var option = new Option(window['user'][`${field}`]['name'], "#Ea^T|@I^p<0>-" + window['user'][`${field}`]['id'], true, true);
        thisSelect.append(option).trigger('change');
        // manually trigger the `select2:select` event
        thisSelect.trigger({
            type: 'select2:select',
            params: {
                data: window['user']
            }
        });
    }
}

// serialize -->
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

// SELECT2 -->
function select2_year() {
    let currentYear = new Date().getFullYear();
    let data = [];
    let i = currentYear;
    for (i; i > currentYear - 5; i--) {
        item = {
            id: i,
            text: i
        };
        data.push(item);
    }
    $('#year').select2({
        data: data,
        minimumResultsForSearch: -1
    });
}

function select2_type() {
    let data = [
        {id: 'F', text: "Final"},
        {id: 'M', text: "M.S.T"}
    ];
    $('#type').select2({
        data: data,
        minimumResultsForSearch: -1
    });
}

function select2_university() {
    $('#university').select2({
        placeholder: "University Name",
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
        insertTag: function (data, tag) {
            // Insert the tag at the end of the results
            data.push(tag);
        }
    });
    preSetSelect2Data('university')
}

function select2_collage(university_id = null) {
    $('#collage').select2({
        placeholder: "Collage Name",
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
        insertTag: function (data, tag) {
            // Insert the tag at the end of the results
            data.push(tag);
        }
    });
    $('.select2-selection--multiple').css('border', '1px solid #ced4da');
    $('.select2-search__field').css('height', '27px');
}

function select2_course() {
    $('#course').select2({
        placeholder: "Course (BTech, MBA, MTech,...)",
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
        insertTag: function (data, tag) {
            // Insert the tag at the end of the results
            data.push(tag);
        }
    });
    $('.select2-selection--multiple').css('border', '1px solid #ced4da');
    $('.select2-search__field').css('height', '27px');

    preSetSelect2Data('course')
}

function select2_branch() {
    $('#branch').select2({
        placeholder: "Branch (CSE, CEVIL, ECE, MECH ,...)",
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
        insertTag: function (data, tag) {
            // Insert the tag at the end of the results
            data.push(tag);
        }
    });
    $('.select2-selection--multiple').css('border', '1px solid #ced4da');
    $('.select2-search__field').css('height', '27px');

    preSetSelect2Data('branch')
}

function select2_subject() {
    $('#subject').select2({
        placeholder: "Subject Name",
        tags: true,
        ajax: {
            url: SUBJECT_SELECT2_URL,
            dataType: 'json',
            processResults: function (data) {
                return {
                    results: select2_serialize(data)
                };
            }
        },
        insertTag: function (data, tag) {
            // Insert the tag at the end of the results
            data.push(tag);
        }
    });
    $('.select2-selection--multiple').css('border', '1px solid #ced4da');
    $('.select2-search__field').css('height', '27px');
}

function getUser() {
    $(document).ready(function () {
        $.ajax({
            url: USER_PROFILE_URL,
            type: "GET",
            success: function (data) {
                window['user'] = data
            },
            error: function (rs, e) {
                console.error(rs.status);
            }, complete: function () {
                initSelect2();
            }
        }); // end ajax
    });
}

function initSelect2() {
    select2_year();
    select2_type();
    select2_university();
    // select2_collage();
    select2_course();
    select2_branch();
    select2_subject();
}

$(document).ready(function () {
    $('#divCollage').css('display', 'none');
    $('#kt_subheader').css('display', 'none');
    $('.upload-paper-link').css("display", "none");
    getUser()

    $('#type').on('change', function (e) {
        if ($('#university').select2('data')[0]) {
            let university_id = $('#university').select2('data')[0].id
            if (university_id.includes('#Ea^T|@I^p<0>-')) {
                university_id = university_id.split('#Ea^T|@I^p<0>-')[1]
                select2_collage(university_id);
            } else {
                select2_collage();
            }
            if ($(e.target).select2("val") == "M") {
                $('#divCollage').css('display', 'block');
            } else {
                $('#divCollage').css('display', 'none');
            }
        }
    });

    $('#university').on('change', function (e) {
        if ($('#type').select2('data')[0].id == "M") {
            let university_id = $(e.target).select2("val")
            if (university_id.includes('#Ea^T|@I^p<0>-')) {
                university_id = university_id.split('#Ea^T|@I^p<0>-')[1]
                select2_collage(university_id);
            } else {
                select2_collage();
            }
            $('#divCollage').css('display', 'block');
        }
    });

});

