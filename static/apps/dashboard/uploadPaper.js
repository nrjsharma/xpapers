$("#upload-paper").submit(function (event) {
    event.preventDefault();
    $('#btn-submit').prop('disabled', true);
    $('.upload-paper').css("display", "none");
    $('.uploading').css("display", "block");
    var progress_bar = new ldBar("#progressBar");
    var data = new FormData($('form')[0]);
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
            $('.uploading').css("display", "none");
            $('.upload-successfully').css("display", "block");
        }, error: function (rs, e) {
            alert(rs.responseText);
            $('#btn-submit').prop('disabled', false);
        }
    });
});

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
}

function select2_collage() {
    $('#collage').select2({
        placeholder: "Collage Name",
        tags: true,
        ajax: {
            url: COLLAGE_SELECT2_URL,
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

function initSelect2() {
    select2_year();
    select2_university();
    select2_collage();
    select2_course();
    select2_branch();
    select2_subject();
}

$(document).ready(function () {
    $('.upload-paper-link').css("display", "none");
    initSelect2();
});

