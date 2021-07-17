function callApi(slug, objType) {
    // postTable = null;
    if(objType == 'university'){
        window.location = window.location.href + `?&uni=${slug}`
    }
    else if (objType == 'collage') {
        window.location = window.location.href + `&col=${slug}`
    } else if (objType == 'course') {
        window.location = window.location.href + `&cou=${slug}`
    } else if (objType == 'branch') {
        window.location = window.location.href + `&bra=${slug}`
    } else if (objType == 'subject') {
        window.location = window.location.href + `&sub=${slug}`
    }
}

function loadTable() {
    let perms = window.location.search
    $('#example').DataTable({
        "processing": true,
        "serverSide": false,
        "ajax": {
            "type": "GET",
            "url": SHOW_USER_PAPERS_URL + `${perms}`,
            data: {
                'username': $('#userID').val(),
            },
            dataSrc: "",
        },
        "columns": [
            {
                "title": 'Sno',
                "data": "",
                "render": function (data, type, row, meta) {
                    return meta.row + meta.settings._iDisplayStart + 1;
                },
                "width": "1%",
            },
            {
                "title": 'Name',
                "data": "name",
                "width": "99%",
                "render": function (data, type, row, meta) {
                    return `<a href="javascript:callApi('${row.slug}', '${row.obj_type}')">${row.name}</a>`
                }
            },
        ]
    });
}

function loadPostTable() {
    let perms = window.location.search
    $('#example').DataTable({
        "processing": true,
        "serverSide": false,
        "scrollY": "auto",
        "ajax": {
            "type": "GET",
            "url": SHOW_USER_PAPERS_URL + `${perms}`,
            data: {
                'username': $('#userID').val(),
            },
            dataSrc: "",
        },
        "columns": [
            {
                "title": 'Sno',
                "data": "",
                "render": function (data, type, row, meta) {
                    return meta.row + meta.settings._iDisplayStart + 1;
                },
                "width": "1%",
            },
            {
                "title": 'Subject Name',
                "data": "subject",
            },
            {
                "title": 'Year',
                "data": "year",
            },
            {
                "title": 'Type',
                "data": "type",
            },
            {
                "title": 'Collage',
                "data": "collage",
            },
            {
                "title": 'User',
                "data": "user",
            },
            {
                "title": 'View',
                "data": "view",
                "render": function (data, type, row, meta) {
                    if (row.postfiles[0]) {
                        return `<a href="${row.postfiles[0].file}" target="_blank">view</a>`
                    } else {
                        return "-"
                    }
                }
            },
        ]
    });
}

$(document).ready(function () {
    let perms = window.location.search;
    $.ajax({
        url: SEARCH_OBJECT_URL + `${perms}`,
        headers: {
            'Conten-Type': 'application/json',
        },
        type: "get",
        success: function (data) {
            // metaTag(data)
            if (data['data'] == "post") {
                loadPostTable()
            } else {
                loadTable()
            }
        }, error: function (rs, e) {
            alert(rs.status)
        }
    }); // end ajax
});