// 간단 드롭다운 (table.js 쓰면 생략 가능)
const toggle = document.getElementById('headerDropdownToggle');
const menu = document.getElementById('headerDropdownMenu');

if (toggle && menu){
    toggle.addEventListener('click', e => {
        e.stopPropagation();
        menu.style.display = (menu.style.display === 'block') ? 'none' : 'block';
    });
    document.addEventListener('click', () => menu.style.display = 'none');
}

$(document).ready(function () {

    $("#headerDropDownLogout").on("click", function () {

        $.ajax({
            url: "/user/logout",
            type: "POST",
            dataType: "json",
            success: function (res) {
                if (res.result === 1) {
                    const modal = document.getElementById("signupModal");
                    modal.style.display = "block";

                    document.getElementById("modalLoginBtn").onclick = function() {
                        location.href = "/";
                    };

                } else {
                    showCustomAlert("실패: " + res.msg);
                }
            },
            error: function () {
                showCustomAlert("서버 통신 중 오류가 발생했습니다.");
            }
        });
    });
});