function callApi(slug, objType) {
    postTable = null;
    if (objType == 'collage') {
        window.location = window.location.href + `&col=${slug}`
    } else if (objType == 'course') {
        window.location = window.location.href + `&cou=${slug}`
    } else if (objType == 'branch') {
        window.location = window.location.href + `&bra=${slug}`
    } else if (objType == 'subject') {
        //window.location = window.location.origin + "/show" + window.location.search +`&sub=${slug}`
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
            "url": SEARCH_URL + `${perms}`,
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
            "url": SEARCH_URL + `${perms}`,
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

// function metaTag(data) {
//     if (!data)
//         return null
//
//     let url = document.URL;
//     let breadcrumbs_url = url.split("s?");
//     let url_host = breadcrumbs_url[0] + "s?";
//     let url_body = breadcrumbs_url[1].split('&')
//     let url_university = url_host + url_body[0]
//     document.title = data['tag'].replaceAll(">", "") + " Previous Year Question Paper - Xpapers";
//     $("head").append(`<link rel="canonical" href="${url}"/>`);
//     $("head").append(`<meta name="keywords" content="${data['keywords']}">`);
//     $("head").append(`<meta name="description" content="${data['description']}">`);
//     $("head").append(`<meta property="og:title" content="${document.title}"/>`);
//     $("head").append(`<meta property="og:url" content="${url}"/>`);
//     $("head").append(`<meta property="og:keywords" content="${data['keywords']}"/>`);
//     $("head").append(`<meta property="og:description" content="${data['description']}"/>`);
//
//     if (data['data'] == "course") {
//         // show university data
//         let tagHtml = `<div id="tag-inner">
// 	    <div id="tag-img"><img src="${data['uni-thumbnail']}" width="220px" alt="${document.title}"/></div>
// 	    <div id="tag-name">
// 	    <h1>${data['tag']} Previous Year Papers</h1>
// 	    ${data['uni-description'] ? `<p>${data['uni-description']}</p>` : `<p>${data['description']}</p>`}
// 	    ${data['uni-url'] ? `<p>Go to <a href="${data['uni-url']}" target="_blank">${data['tag']}</a> website</p>` : ''}
// 	    </div>
// 	    </div>`;
//         let underTableData = `
// 	    ${data['uni-about'] ?
//             `
// 	      <div id="underTable-inner">
// 	      <h2>About ${data['tag']}</h2>
// 	      <p>${data['uni-about']}</p>
// 	      </div>
// 	      `
//             : ``}
// 	    `;
//         $("#tagline").html(tagHtml);
//         $("#underTable").html(underTableData);
//         $("#pageTitle").html(`${data['tag']}`);
//     }else{
//         var a = data['tag'].split(" > "),
//         i, thisURL, j;
//         let tagHtml = ``;
//         for (i = 1; i < a.length; i++) {
//             // breadcrumbs
//             for (j = 0; j <= i; j++){
//                 if (j == 0){
//                     thisURL = url_host + url_body[j];
//                 }else{
//                     thisURL = thisURL + "&" + url_body[j];
//                 }
//             }
//             if (i == a.length - 1) {
//                 tagHtml = tagHtml + `
//                 <li class="breadcrumb-item text">
//                 <a href="${thisURL}" class="text">${a[i]}</a>
//                 </li>
//             `;
//             } else {
//                 tagHtml = tagHtml + `
//                 <li class="breadcrumb-item text-muted">
//                 <a href="${thisURL}" class="text-muted">${a[i]}</a>
//                 </li>
//             `;
//             }
//
//         }
//         $("#pageTitle").html(`<a href="${url_university}">${a[0]}</a>`);
//         $("#pageTitleList").html(tagHtml);
//     }
// }

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
