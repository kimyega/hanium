<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>비밀번호 찾기</title>

    <!-- 폰트 및 아이콘 -->
    <link href="https://fonts.googleapis.com/css2?family=Kavoon&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Cute+Font&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <%-- 모달창 css --%>
    <link rel="stylesheet" href="/css/headerLogout.css" />

    <!-- 공통 스타일 -->
    <link rel="stylesheet" href="/css/table.css" />

    <%-- Jquery --%>
    <script type="text/javascript" src="/js/jquery-3.6.0.min.js"></script>
    <style>
        main { display:flex; justify-content:center; align-items:center; min-height:80vh; }
        .find-id-box {
            background:#fff; border:6px solid #fca08c; border-radius:30px;
            padding:60px 80px; box-shadow:8px 8px 10px rgba(0,0,0,0.1);
            width:600px; text-align:center;
        }
        .find-id-title { font-size:28px; font-weight:bold; margin-bottom:40px; }
        .find-id-form { display:flex; flex-direction:column; gap:30px; width:100%; }
        .form-row { display:flex; align-items:center; gap:10px; }
        .form-row label { font-size:20px; font-weight:bold; width:80px; text-align:right; white-space:nowrap; }
        .form-row input {
            flex:1; border:none; border-bottom:2px solid gray; outline:none; background:transparent;
            font-size:18px; padding:6px 4px; font-family:'Cute Font', sans-serif;
        }
        .form-row input::placeholder { color:#e6bcbc; }
        .verify-button {
            margin-top:20px; width:100%; font-size:24px; padding:15px 0; border:none;
            background:#fca08c; color:#fff; border-radius:40px; cursor:pointer;
            font-family:'Cute Font', sans-serif; box-shadow:5px 5px 5px rgba(0,0,0,0.15);
            transition:background-color .3s ease;
        }
        .verify-button:hover { background:#ffbfa8; }

        /* ===== 모달 공통 ===== */
        .modal-overlay {
            position: fixed; inset: 0; background: rgba(0,0,0,0.35);
            display: none; align-items: center; justify-content: center;
            z-index: 9999;
        }
        .modal-overlay.show { display:flex; }
        .modal-box {
            width:520px; max-width:calc(100vw - 40px);
            background:#fff; border:6px solid #fca08c; border-radius:30px;
            box-shadow:8px 8px 10px rgba(0,0,0,0.15);
            padding:36px 28px; text-align:center;
        }
        .modal-title { font-size:24px; font-weight:700; margin-bottom:14px; }
        .modal-message { font-size:18px; line-height:1.6; margin:10px 0 22px; white-space:pre-line; }
        .modal-actions .verify-button { width:160px; margin:0 auto; }
    </style>

    <script>
        let emailAuthNumber = "";

        $(function () {
            $("#btnEmail").on("click", function () { emailExists(); });
            $("#btnCheck").on("click", function () { doCheck(); });
            $("#modalOk").on("click", closeModal);
            $(document).on("keydown", function(e){ if(e.key==="Escape") closeModal(); });
        });

        /* ===== 모달 유틸 ===== */
        function showModal(message, onOk) {
            $("#appModal .modal-title").text("알림");
            $("#appModal .modal-message").text(message);
            $("#appModal").addClass("show");
            // OK 후처리 등록
            $("#modalOk").data("onOk", onOk || null);
        }
        function closeModal() {
            $("#appModal").removeClass("show");
            const cb = $("#modalOk").data("onOk");
            $("#modalOk").data("onOk", null);
            if (typeof cb === "function") cb();
        }

        // 1) 이메일 존재 확인 + 아이디/이메일 본인확인 → Step2로
        function emailExists() {
            const userId = $("#userId").val()?.trim();
            const email  = $("#email").val()?.trim();

            if (!email)  { showModal("이메일을 입력하세요.",  () => $("#email").focus());  return; }
            if (!userId) { showModal("아이디를 입력하세요.", () => $("#userId").focus()); return; }

            $.ajax({
                url: "/user/emailAuthNumber",
                type: "POST",
                dataType: "JSON",
                data: { email },
                success: function (json) {
                    if (json.existsYn === "Y") {
                        $.ajax({
                            url: "/user/searchPasswordProc",
                            type: "POST",
                            dataType: "JSON",
                            data: { userId, email },
                            success: function (r) {
                                if (r.result === 1) {
                                    emailAuthNumber = String(json.authNumber);
                                    $("#hiddenUserId").val(userId);
                                    $("#hiddenEmail").val(email);
                                    $("#step1").hide();
                                    $("#step2").show();
                                } else {
                                    showModal(r.msg || "본인 확인에 실패했습니다.");
                                }
                            },
                            error: onAjaxErr
                        });
                    } else {
                        showModal("존재하지 않는 이메일입니다.", () => $("#email").focus());
                    }
                },
                error: onAjaxErr
            });
        }

        // 2) 인증번호 확인 → changePw(Reset 모드)로 이동
        function doCheck() {
            const code = $("#code").val()?.trim();
            if (!code) { showModal("인증번호를 입력하세요.", () => $("#code").focus()); return; }

            if (String(code) !== String(emailAuthNumber)) {
                showModal("인증번호가 일치하지 않습니다.", () => $("#code").focus());
                return;
            }

            const uid = encodeURIComponent($("#hiddenUserId").val());
            window.location.href = "/user/changePw?reset=1&userId=" + uid;
        }

        function onAjaxErr(xhr) {
            console.error("AJAX ERROR", xhr.status, xhr.responseText);
            if (xhr.status === 403) showModal("요청이 차단되었습니다.\n(CSRF 설정을 확인하세요)");
            else showModal("요청 중 오류가 발생했습니다.");
        }
    </script>
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
    <!-- 1단계: 아이디 + 이메일 -->
    <section id="step1" class="find-id-box">
        <h1 class="find-id-title">비밀번호 찾기</h1>
        <form class="find-id-form" id="f">
            <div class="form-row">
                <label for="userId">아이디:</label>
                <input type="text" name="userId" id="userId" placeholder="아이디를 입력하세요." />
            </div>
            <div class="form-row">
                <label for="email">이메일:</label>
                <input type="email" name="email" id="email" placeholder="이메일을 입력하세요." />
            </div>
            <button type="button" id="btnEmail" class="verify-button">인증메일 받기</button>
        </form>
    </section>

    <!-- 2단계: 인증번호 확인 -->
    <section id="step2" class="find-id-box" style="display:none;">
        <h1 class="find-id-title">이메일로 온 인증번호를 입력해 주세요.</h1>
        <form class="find-id-form" id="f2">
            <input type="hidden" name="userId" id="hiddenUserId" />
            <input type="hidden" name="email"  id="hiddenEmail" />
            <div class="form-row">
                <label for="code">인증번호:</label>
                <input type="text" id="code" name="authNumber" placeholder="인증번호 입력" />
            </div>
            <button type="button" class="verify-button" id="btnCheck">인증번호 확인</button>
        </form>
    </section>

    <!-- 3단계: (비밀번호 찾기는 바로 changePw로 이동하므로 사용 안 함) -->
    <section id="step3" class="find-id-box" style="display:none;"></section>
</main>

<!-- ✅ 공용 알림 모달 -->
<div id="appModal" class="modal-overlay" style="display:none;">
    <div class="modal-box" style="
    width:520px;max-width:calc(100vw - 40px);background:#fff;border:6px solid #fca08c;border-radius:30px;
    box-shadow:8px 8px 10px rgba(0,0,0,0.15);padding:36px 28px;text-align:center;">
        <h3 class="modal-title" style="font-size:24px;font-weight:700;margin-bottom:14px;">알림</h3>
        <p class="modal-message" style="font-size:18px;line-height:1.6;margin:10px 0 22px;white-space:pre-line;"></p>
        <button type="button" id="modalOk" class="verify-button" style="width:160px;margin:0 auto;">확인</button>
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

<style>
    .modal-overlay{position:fixed;inset:0;background:rgba(0,0,0,.35);display:none;align-items:center;justify-content:center;z-index:9999}
    .modal-overlay.show{display:flex}
</style>


<script src="${pageContext.request.contextPath}/js/headerLogout.js"></script>
</body>
</html>
