$(document).ready(function () {
    $.ajax({
        url: USER_PROFILE_URL,
        type: "GET",
        success: function (data) {
            if(!data.is_username_varified && window.location.pathname != "/user/set-username/"){
                window.location = '/user/set-username/'
            }else{
                $("#header-options-bar").html(renderUser(data))
                $('#header-profile-pic').css('background-image', 'url(' + data.profile_image + ')');
                $('#header-profile-dropdown-pic').css('background-image', 'url(' + data.profile_image + ')');
            }
        },
        error: function (rs, e) {
            if (rs.status == 401){
                $("#header-options-bar").html(renderLoginSignup())
            }
        }
    }); // end ajax
});

function logout() {
    $.ajax({
        url: LOGOUT_URL,
        headers: {
            'Conten-Type': 'application/json',
            'X-CSRFToken': $.cookie("csrftoken")
        },
        type: "POST",
        success: function (data) {
            window.location = '/'
        }, error: function (rs, e) {
            console.error(rs.responseText)
            console.error(rs.status)
        }, complete: function () {
            console.log('request completed')
        }

    }); // end ajax
}

function renderLoginSignup() {
    return `
        <div class="topbar-item mr-4">
            <a href="/user/login/" class="navi-item px-8">LogIn</a>
            <a href="/user/signup/" class="navi-item px-8" style="padding-left: 0px !important;">Sign Up</a>
        </div>
    `
}

function renderUser(user) {
    return `
    <div class="topbar-item mr-4">
    <div class="dropdown">
        <!--begin::Toggle-->
        <div class="topbar-item" data-toggle="dropdown" data-offset="0px,0px" aria-expanded="false">
            <div class="btn btn-icon w-auto btn-clean d-flex align-items-center btn-lg px-2">
                <span class="text-muted font-weight-bold font-size-base d-none d-md-inline mr-1">Hi,</span>
                <span class="text-dark-50 font-weight-bolder font-size-base d-none d-md-inline mr-3">${user.username}</span>
                            <span class="symbol symbol-35 symbol-light-success">
                                <span class="symbol-label" id="header-profile-pic"></span>
                            </span>
            </div>
        </div>
        <!--end::Toggle-->
        <!--begin::Dropdown-->
        <div class="dropdown-menu p-0 m-0 dropdown-menu-right dropdown-menu-anim-up dropdown-menu-lg p-0"
             style="">
            <!--begin::Header-->
            <div class="d-flex align-items-center wave wave-animate-slow wave-danger justify-content-between flex-wrap p-8 bgi-size-cover bgi-no-repeat rounded-top">
                <div class="d-flex align-items-center mr-2">
                    <!--begin::Symbol-->
                    <div class="symbol bg-white-o-15 mr-3">
                        <span class="symbol-label" id="header-profile-dropdown-pic"></span>
                    </div>
                    <!--end::Symbol-->
                    <!--begin::Text-->
                    <div class="text-white m-0 flex-grow-1 mr-3 font-size-h5" style="color: black !important;">${user.username}</div>
                    <!--end::Text-->
                </div>
            </div>
            <!--end::Header-->
            <!--begin::Nav-->
            <div class="navi navi-spacer-x-0 pt-5">
                <!--begin::Item-->
                <a href="/user/${user.username}/"
                   class="navi-item px-8">
                    <div class="navi-link">
                        <div class="navi-icon mr-2">
                            <i class="flaticon2-calendar-3 text-success"></i>
                        </div>
                        <div class="navi-text">
                            <div class="font-weight-bold">My Profile</div>
                            <div class="text-muted">Account settings and more
                            </div>
                        </div>
                    </div>
                </a>
                <!--end::Item-->
                <!--begin::Footer-->
                <div class="navi-separator mt-3"></div>
                <div class="navi-footer px-8 py-5">
                    <form id="logout-form" style="width: auto;">
                        <a href="javascript:logout();" class="btn btn-light-primary font-weight-bold">Sign
                            Out</a>
                    </form>

                    <!--<a href="/metronic/demo1/custom/user/login-v2.html" target="_blank"-->
                       <!--class="btn btn-clean font-weight-bold">Upgrade Plan</a>-->
                </div>
                <!--end::Footer-->
            </div>
            <!--end::Nav-->
        </div>
        <!--end::Dropdown-->
    </div>
</div>
    `
}