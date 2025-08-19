<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>회원 탈퇴</title>

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
        .row label { width:120px; text-align:right; font-size:20px; font-weight:bold; }
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
        <h1 class="title">회원 탈퇴</h1>
        <p style="margin-bottom:20px;">보안을 위해 <strong>현재 비밀번호</strong>를 입력하세요.</p>

        <form id="f">
            <div class="row">
                <label for="password">비밀번호:</label>
                <input type="password" id="password" name="password" placeholder="현재 비밀번호 입력" />
            </div>
            <button type="button" class="btn" id="btnWithdraw">회원 탈퇴</button>
            <button type="button" class="btn cancel" onclick="history.back()">취소</button>
        </form>
    </section>
</main>

<%--모달창--%>
<div id="signupModal" class="modal">
    <div class="modal-content">
        <h2>메르헨드</h2>
        <p>로그아웃 완료!!</p>
        <button id="modalLoginBtn">메인 화면으로</button>
    </div>
</div>

<script>

    $("#btnWithdraw").on("click", function () {
        const pw = $("#password").val().trim();
        if (!pw) return alert("비밀번호를 입력하세요.");

        if (!confirm("정말 탈퇴하시겠습니까? 탈퇴 시 데이터가 삭제됩니다.")) return;

        $.post("/user/withdrawProc", { password: pw }, function (res) {
            if (res.result === 1) {
                alert("탈퇴가 완료되었습니다.");
                // 세션 무효화가 서버에서 되었으니 메인/로그인으로
                location.href = "/";
            } else {
                alert(res.msg || "탈퇴에 실패했습니다.");
            }
        }, "json");
    });
</script>
<script src="${pageContext.request.contextPath}/js/headerLogout.js"></script>
</body>
</html>
