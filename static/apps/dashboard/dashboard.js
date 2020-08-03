$(document).ready(function () {
    $('#universityTbl').DataTable({
        "processing": true,
        "serverSide": false,
        "ajax": {
            "type": "GET",
            "url": UNIVERSITY_URL,
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
                "render": function (data, type, row, meta) {
                    return `<a href="/s?uni=${row.slug}">${row.name}</a>`
                }
            },
        ]
    });
});