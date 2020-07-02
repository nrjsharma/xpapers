function callApi(slug, objType) {
    if (objType == 'collage') {
        window.location = window.location.href + `&col=${slug}`
    } else if (objType == 'course') {
        window.location = window.location.href + `&cou=${slug}`
    } else if (objType == 'branch') {
        window.location = window.location.href + `&bra=${slug}`
    } else if (objType == 'subject') {
        window.location = window.location.origin + "/show" + window.location.search +`&sub=${slug}`
    }
}

function loadTable() {
    perms = window.location.search
    $('#example').DataTable({
        "processing": true,
        "serverSide": false,
        "ajax": {
            "type" : "GET",
            "url": SEARCH_URL + `${perms}`,
            dataSrc: "",
        },
        "columns": [
            {
                "title": "ID",
                "data": "id",
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

// ***************
// ** DYNAMIC COLUMNS **
// ***************
// var columns = [];
//
// function capitalizeFirstLetter(string) {
//     return string.charAt(0).toUpperCase() + string.slice(1);
// }
//
// function loadTable() {
//     let visible_columns = ['name', 'id']
//     perms = window.location.search;
//     $.ajax({
//         url: SHOW_URL + `${perms}`,
//         success: function (data) {
//             columnNames = Object.keys(data[0]);
//             for (var i in columnNames) {
//                 if (visible_columns.includes(columnNames[i])) {
//                     columns.push({
//                         title: capitalizeFirstLetter(columnNames[i]),
//                         data: columnNames[i]
//                     });
//                 }
//             }
//             console.log(columns)
//             $('#example').DataTable({
//                 processing: true,
//                 serverSide: false,
//                 "ajax": {
//                     "type": "GET",
//                     "url": SHOW_URL + `${perms}`,
//                     dataSrc: "",
//                 },
//                 "columns": columns
//             });
//         }
//     });
// }

$(document).ready(function () {
    loadTable()
});