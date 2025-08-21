<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>비밀번호 변경</title>

    <link href="https://fonts.googleapis.com/css2?family=Kavoon&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Cute+Font&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet" href="/css/table.css" />

    <%-- 모달창 css --%>
    <link rel="stylesheet" href="/css/headerLogout.css" />

    <%-- Jquery --%>
    <script type="text/javascript" src="/js/jquery-3.6.0.min.js"></script>

    <style>
        main { display:flex; justify-content:center; align-items:center; min-height:80vh; }
        .box {
            background:#fff; border:6px solid #fca08c; border-radius:30px;
            padding:60px 80px; box-shadow:8px 8px 10px rgba(0,0,0,.1);
            width:600px; text-align:center;
        }
        .title { font-size:28px; font-weight:bold; margin-bottom:40px; }
        .row { display:flex; align-items:center; gap:10px; margin:20px 0; }
        .row label { width:140px; text-align:right; font-size:20px; font-weight:bold; }
        .row input {
            flex:1; border:none; border-bottom:2px solid gray; outline:none; background:transparent;
            font-size:18px; padding:6px 4px; font-family:'Cute Font', sans-serif;
        }
        .row input::placeholder { color:#e6bcbc; }
        .btn {
            margin-top:26px; width:100%; font-size:24px; padding:15px 0; border:none;
            background:#f47c6a; color:#fff; border-radius:40px; cursor:pointer;
            font-family:'Cute Font', sans-serif; box-shadow:5px 5px 5px rgba(0,0,0,.15);
        }
        .btn.cancel { background:#c9c9c9; margin-top:12px; }

        /* ===== 모달 ===== */
        .modal-overlay {
            position:fixed; inset:0; background:rgba(0,0,0,.35);
            display:none; align-items:center; justify-content:center; z-index:9999;
        }
        .modal-overlay.show { display:flex; }
        .modal-box {
            width:520px; max-width:calc(100vw - 40px);
            background:#fff; border:6px solid #fca08c; border-radius:30px;
            box-shadow:8px 8px 10px rgba(0,0,0,.15);
            padding:36px 28px; text-align:center;
        }
        .modal-title { font-size:24px; font-weight:700; margin-bottom:14px; }
        .modal-message { font-size:18px; line-height:1.6; margin:10px 0 22px; white-space:pre-line; }
        .modal-actions .btn { width:160px; margin:0 auto; }
    </style>
</head>
<body>

<!-- 상단바 -->
<header>
    <div class="header-icon-stack">
        <i class="fa-solid fa-book-open book"></i>
        <i class="fa-solid fa-hands-holding hands"></i>
    </div>
    <div class="header-logo" onclick="location.href='/'">Märchand</div>
    <div class="header-user-area">
        <div class="header-user-icon"><i class="fa-solid fa-circle-user fa-xl"></i></div>
        <div class="header-dropdown">
            <button class="header-dropdown-toggle" id="headerDropdownToggle">
                <%
                    String uname = (String)session.getAttribute("SS_USER_NAME");
                    if (uname == null || uname.trim().isEmpty()) { uname = "메뉴"; }
                %>
                <%= uname %>
                <span>▼</span>
            </button>
            <ul class="header-dropdown-menu" id="headerDropdownMenu">
                <%
                    if (uname.equals("메뉴")) {
                %>
                <li onclick="location.href='/user/login'">로그인</li>
                <li onclick="location.href='/user/register'">회원가입</li>
                <%
                } else {
                %>
                <li onclick="location.href='/user/mypage'">내 정보</li>
                <li id="headerDropDownLogout">로그아웃</li>
                <%
                    }
                %>
            </ul>
        </div>
    </div>
</header>

<main>
    <section class="box">
        <h1 class="title">비밀번호 변경</h1>
        <form id="changePwForm">
            <!-- reset 모드에서는 이 행을 숨긴다 -->
            <div class="row" id="rowCurrent">
                <label for="currentPw">현재 비밀번호:</label>
                <input type="password" id="currentPw" name="currentPw" placeholder="현재 비밀번호 입력" />
            </div>
            <div class="row">
                <label for="newPw">새 비밀번호:</label>
                <input type="password" id="newPw" name="newPw" placeholder="새 비밀번호 입력" />
            </div>
            <div class="row">
                <label for="newPw2">새 비밀번호 확인:</label>
                <input type="password" id="newPw2" placeholder="새 비밀번호 다시 입력" />
            </div>
            <button type="button" class="btn" id="btnChangePw">비밀번호 변경</button>
            <button type="button" class="btn cancel" onclick="history.back()">취소</button>
        </form>
    </section>
</main>

<!-- ✅ 공용 알림 모달 -->
<div id="appModal" class="modal-overlay">
    <div class="modal-box">
        <h3 class="modal-title">알림</h3>
        <p class="modal-message"></p>
        <div class="modal-actions">
            <button type="button" id="modalOk" class="btn">확인</button>
        </div>
    </div>
</div>

<%--모달창--%>
<div id="signupModal" class="modal">
    <div class="modal-content">
        <h2>메르헨드</h2>
        <p>로그아웃 완료!!</p>
        <button id="modalLoginBtn" class="modal-btn">메인 화면으로</button>
    </div>
</div>

<script>

    /* ===== 모달 유틸 ===== */
    function showModal(message, onOk){
        const ov = document.getElementById('appModal');
        ov.querySelector('.modal-message').textContent = message;
        ov.classList.add('show');
        const ok = document.getElementById('modalOk');
        ok.onclick = function(){
            ov.classList.remove('show');
            if (typeof onOk === 'function') onOk();
        };
    }
    // 혹시 남아 있을 기본 alert 호출도 가로채기
    window.alert = function(msg){ showModal(String(msg)); };

    // ── reset 모드 감지 (비밀번호 찾기에서 넘어온 경우)
    const qs = new URLSearchParams(window.location.search);
    const isReset = qs.get("reset") === "1";
    const resetUserId = qs.get("userId") || qs.get("userid");

    if (isReset) {
        document.getElementById("rowCurrent").style.display = "none";
        document.getElementById("btnChangePw").textContent = "새 비밀번호 설정";
    }

    // 제출
    $("#btnChangePw").on("click", function () {
        const $btn = $(this).prop("disabled", true);
        const cur = $("#currentPw").val().trim();
        const pw1 = $("#newPw").val().trim();
        const pw2 = $("#newPw2").val().trim();

        // 공통 검증
        if (!pw1 || !pw2) { showModal("새 비밀번호를 입력하세요.", () => $("#newPw").focus()); return $btn.prop("disabled", false); }
        if (pw1 !== pw2)  { showModal("새 비밀번호가 일치하지 않습니다.", () => $("#newPw2").focus()); return $btn.prop("disabled", false); }
        if (pw1.length < 8){ showModal("비밀번호는 8자 이상이어야 합니다.", () => $("#newPw").focus()); return $btn.prop("disabled", false); }

        if (isReset) {
            // ✅ 비번 찾기 경유: 현재 비번 없이 바로 재설정
            if (!resetUserId) { showModal("잘못된 접근입니다. 다시 시도해주세요."); return $btn.prop("disabled", false); }

            $.post("/user/resetPasswordProc",
                { userId: resetUserId, password: pw1 },
                function (res) {
                    if (res.result === 1) {
                        showModal("비밀번호가 변경되었습니다. 로그인 해주세요.", () => location.href = "/user/login");
                    } else {
                        showModal(res.msg || "비밀번호 변경에 실패했습니다.");
                    }
                },
                "json"
            ).fail(function(){
                showModal("요청 중 오류가 발생했습니다.");
            }).always(function(){
                $btn.prop("disabled", false);
            });

        } else {
            // ✅ 일반 변경: 현재 비번 검증 후 변경
            if (!cur) { showModal("현재 비밀번호를 입력하세요.", () => $("#currentPw").focus()); return $btn.prop("disabled", false); }

            $.post("/user/changePwProc",
                { currentPw: cur, newPw: pw1 },
                function (res) {
                    if (res.result === 1) {
                        showModal("비밀번호가 변경되었습니다. 다시 로그인 해주세요.", () => location.href = "/user/login");
                    } else {
                        showModal(res.msg || "비밀번호 변경에 실패했습니다.");
                    }
                },
                "json"
            ).fail(function(){
                showModal("요청 중 오류가 발생했습니다.");
            }).always(function(){
                $btn.prop("disabled", false);
            });
        }
    });
</script>
<script src="${pageContext.request.contextPath}/js/headerLogout.js"></script>
</body>
</html>
