<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>아이디 찾기</title>

    <!-- 폰트 및 아이콘 -->
    <link href="https://fonts.googleapis.com/css2?family=Kavoon&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Cute+Font&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet" href="/css/table.css" />
    <link rel="stylesheet" href="/css/modal.css" />

    <%-- 모달창 css --%>
    <link rel="stylesheet" href="/css/headerLogout.css" />

    <%-- Jquery --%>
    <script type="text/javascript" src="/js/jquery-3.6.0.min.js"></script>
    <style>

        main {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 80vh;
        }

        .find-id-box {
            background-color: white;
            border: 6px solid #fca08c;
            border-radius: 30px;
            padding: 60px 80px;
            box-shadow: 8px 8px 10px rgba(0,0,0,0.1);
            width: 600px;
            text-align: center;
        }

        .find-id-title {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 40px;
        }

        .find-id-form {
            display: flex;
            flex-direction: column;
            gap: 30px;
            width: 100%;
        }

        .form-row {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .form-row label {
            font-size: 20px;
            font-weight: bold;
            width: 80px;
            text-align: right;
            white-space: nowrap;
        }

        .form-row input {
            flex: 1;
            border: none;
            border-bottom: 2px solid gray;
            outline: none;
            background-color: transparent;
            font-size: 18px;
            padding: 6px 4px;
            font-family: 'Cute Font', sans-serif;
        }

        .form-row input::placeholder {
            color: #e6bcbc;
        }

        .verify-button {
            margin-top: 20px;
            width: 100%;
            font-size: 24px;
            padding: 15px 0;
            border: none;
            background-color: #fca08c;
            color: white;
            border-radius: 40px;
            cursor: pointer;
            font-family: 'Cute Font', sans-serif;
            box-shadow: 5px 5px 5px rgba(0,0,0,0.15);
            transition: background-color 0.3s ease;
        }

        .verify-button:hover {
            background-color: #ffbfa8;
        }
    </style>
    <script>

        let emailAuthNumber = "";

        $(document).ready(function () {

            let f = document.getElementById("f");
            let f2 = document.getElementById("f2");

            $("#btnEmail").on("click", function () {
                emailExists(f)
            })
            $("#btnCheck").on("click", function () {
                doCheck(f2);
            })
        })

        function emailExists(f) {
            if (f.userName.value === "") {
                showModal("이름을 입력하세요.");
                f.email.focus();
                return;
            }

            if (f.email.value === "") {
                showModal("이메일을 입력하세요.");
                f.email.focus();
                return;
            }

            $.ajax({
                url: "/user/emailAuthNumber",
                type: "post",
                dataType: "JSON",
                data: $("#f").serialize(),
                success: function (json) {
                    if (json.existsYn === "Y") {
                        step1.style.display = 'none';
                        step2.style.display = 'block';

                        emailAuthNumber = json.authNumber;

                        document.getElementById("hiddenUserName").value = f.userName.value;
                        document.getElementById("hiddenEmail").value = f.email.value;
                    } else {
                        showModal("존재하지 않는 이름 또는 메일 입니다.")
                        f.email.focus();
                    }
                }
            })
        }
        function doCheck(f2) {

            if (f2.authNumber.value === "") {
                showModal("인증번호를 입력하세요.");
                f2.authNumber.focus();
                return;
            }

            if (parseInt(f2.authNumber.value) !== emailAuthNumber) {
                showModal("인증번호가 일치하지 않습니다.")
                f2.authNumber.focus();
                return;
            }

            $.ajax({
                url: "/user/searchUserIdProc",
                type: "post",
                dataType: "JSON",
                data: $("#f2").serialize(),
                success: function (json) {

                    if (json.result === 1) {
                        console.log("인증 성공, 페이지 전환 시도");
                        step2.style.display = 'none';
                        step3.style.display = 'block';

                        const title = step3.querySelector(".find-id-title");
                        title.textContent = json.name + "님의 아이디를 찾았습니다!";

                        const strongEl = step3.querySelector("strong");
                        strongEl.textContent = json.msg;
                    } else {
                        showModal(json.msg);
                    }
                }
            })
        }
    </script>
</head>
<body>

<!-- 상단바 -->
<%@ include file="../includes/header.jsp"%>

<main>
    <!-- 1단계 -->
    <section id="step1" class="find-id-box">
        <h1 class="find-id-title">아이디 찾기</h1>
        <form class="find-id-form" id="f">
            <div class="form-row">
                <label for="userName">이름:</label>
                <input type="text" name="userName" id="userName" placeholder="이름을 입력하세요." />
            </div>
            <div class="form-row">
                <label for="email">이메일:</label>
                <input type="email" name="email" id="email" placeholder="이메일을 입력하세요." />
            </div>
            <button type="button" id="btnEmail" class="verify-button">인증메일 받기</button>
        </form>
    </section>

    <!-- 2단계 -->
    <section id="step2" class="find-id-box" style="display: none;">
        <h1 class="find-id-title">이메일로 온 인증번호를 입력해 주세요.</h1>
        <form class="find-id-form" id="f2">
            <input type="hidden" name="userName" id="hiddenUserName" />
            <input type="hidden" name="email" id="hiddenEmail" />
            <div class="form-row">
                <label for="code">인증번호:</label>
                <input type="text" id="code" name="authNumber" placeholder="인증번호 입력" />
            </div>
            <button type="button" class="verify-button" id="btnCheck">인증번호 확인</button>
        </form>
    </section>

    <!-- 3단계 -->
    <section id="step3" class="find-id-box" style="display: none;">
        <h1 class="find-id-title">님의 아이디를 찾았습니다!</h1>
        <p style="font-size: 20px; margin: 30px 0;">아이디: <strong></strong></p>
        <button class="verify-button" onclick="location.href='/user/login'">로그인 화면으로 돌아가기</button>
    </section>
</main>

<%--모달창--%>
<div id="signupModal" class="modal">
    <div class="modal-content">
        <h2>메르헨드</h2>
        <p>로그아웃 완료!!</p>
        <button id="modalLoginBtn" class="modal-btn">메인 화면으로</button>
    </div>
</div>
<script src="/js/modal.js"></script>
<script>

    const step1 = document.getElementById('step1');
    const step2 = document.getElementById('step2');
    const step3 = document.getElementById('step3');

</script>
<script src="${pageContext.request.contextPath}/js/headerLogout.js"></script>
</body>
</html>
