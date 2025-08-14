<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>회원가입 | Märchand</title>
    <link href="https://fonts.googleapis.com/css2?family=Kavoon&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Cute+Font&family=Kavoon&display=swap" rel="stylesheet">

    <script type="text/javascript" src="/js/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <link rel="stylesheet" href="/css/table.css" />
    <style>
        .signup-container {
            max-width: 800px;
            margin: 15px auto 10px;
            padding: 35px;
            padding-top: 15px;
            border: 4px solid #f9b59e;
            border-radius: 40px;
            background-color: #fff;
            font-family: 'Cute Font', sans-serif;
        }

        .signup-title {
            text-align: center;
            font-size: 48px;
            margin-top: 0;
            margin-bottom: 0px;
        }

        .signup-form label {
            display: block;
            margin-top: 10px;
            margin-bottom: 5px;
            font-size: 30px;
        }

        .signup-form input,
        .signup-form select {
            width: 100%;
            padding: 10px;
            border: 2px solid #f4c2a5;
            border-radius: 15px;
            font-size: 16px;
            margin-bottom: 10px;
        }

        .input-group {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .input-group input {
            flex: 1;
        }

        .input-group button {
            padding: 10px 15px;
            background-color: #fca88f;
            color: white;
            border: none;
            border-radius: 15px;
            font-size: 14px;
        }

        .birth-group {
            display: flex;
            gap: 10px;
        }

        .signup-buttons {
            display: flex;
            justify-content: center;
            /* 중앙 정렬 */
            gap: 40px;
            /* 버튼 사이 여백 */
            margin-top: 20px;
        }

        .signup-btn {
            width: 160px;
            /* 가로 너비 넓힘 */
            padding: 14px 0;
            /* 위아래 패딩 */
            font-size: 18px;
            /* 글자 크기 키움 */
            border-radius: 15px;
            background-color: #fca88f;
            color: white;
            border: none;
            padding: 12px 20px;
            font-size: 16px;
            border-radius: 15px;
        }

        .cancel-btn {
            width: 160px;
            /* 가로 너비 넓힘 */
            padding: 14px 0;
            /* 위아래 패딩 */
            font-size: 18px;
            /* 글자 크기 키움 */
            border-radius: 15px;
            background-color: #f29191;
            color: white;
            border: none;
            padding: 12px 20px;
            font-size: 16px;
            border-radius: 15px;
        }

        .message {
            display: block;
            margin-top: 5px;
            margin-bottom: 5px;
            font-size: 24px;
        }

        .message.success {
            color: #03C75A;
        }

        .message.error {
            color: #FF3F3F;
        }

        input.valid {
            border-color: #03C75A;
        }

        input.invalid {
            border-color: #FF3F3F;
        }


        .input-group button,
        .signup-btn,
        .cancel-btn {
            transition: background-color 0.2s ease, transform 0.1s ease;
        }

        /* 공통 hover */
        .input-group button:hover,
        .signup-btn:hover,
        .cancel-btn:hover {
            background-color: #f99074;
            /* 기존보다 살짝 진한 살구색 */
        }

        /* 공통 클릭시 효과 */
        .input-group button:active,
        .signup-btn:active,
        .cancel-btn:active {
            background-color: #e87b5f;
            /* 더 진한 클릭 색상 */
            transform: scale(0.98);
            /* 눌리는 느낌 */
        }


        /*** 모달 창 CSS ***/

        /* 모달 배경 */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.5);
        }

        /* 모달 박스 */
        .modal-content {
            background-color: #fff;
            margin: 12% auto;
            padding: 30px 25px;
            border: 8px solid #f9b59e;
            border-radius: 40px;
            width: 450px;      /* 가로로 조금 늘림 */
            text-align: center;
            font-family: 'Cute Font', sans-serif;
        }

        /* 제목 */
        .modal-content h2 {
            font-size: 56px;  /* 제목 좀 더 크게 */
            margin-bottom: 15px;
        }

        /* 내용 */
        .modal-content p {
            font-size: 40px;  /* 요청하신 대로 40px */
            margin-bottom: 25px;
        }

        /* 버튼 */
        #modalLoginBtn {
            padding: 10px 0;      /* 세로 패딩 조금 줄임 */
            width: 100%;
            font-size: 28px;      /* 버튼 글자 약간 작게 조정 */
            border-radius: 30px;
            border: 4px solid #f4c2a5;
            background-color: #fca88f;
            color: white;
            cursor: pointer;
            transition: background-color 0.2s ease, transform 0.1s ease;
        }

        #modalLoginBtn:hover {
            background-color: #f99074;
        }

        #modalLoginBtn:active {
            background-color: #e87b5f;
            transform: scale(0.98);
        }
    </style>
</head>

<body>
<header>
    <!-- 기존 헤더 유지 -->
    <div class="header-icon-stack">
        <i class="fa-solid fa-book-open book"></i>
        <i class="fa-solid fa-hands-holding hands"></i>
    </div>
    <div class="header-logo" onclick="location.href='/home.html'">Märchand</div>
    <div class="header-user-area">
        <div class="header-user-icon">
            <i class="fa-solid fa-circle-user fa-2xl"></i>
        </div>
        <div class="header-dropdown">
            <button class="header-dropdown-toggle" id="headerDropdownToggle">홍길동 ⏷</button>
            <ul class="header-dropdown-menu" id="headerDropdownMenu">
                <li onclick="location.href='/profile.html'">내 정보</li>
                <li onclick="location.href='/logout.html'">로그아웃</li>
            </ul>
        </div>
    </div>
</header>

<main>
    <div class="signup-container">
        <h2 class="signup-title">회원 가입</h2>
        <form class="signup-form" id="signupForm">
            <label for="userid">아이디</label>
            <div class="input-group">
                <input type="text" id="userid" name="userId" placeholder="아이디 입력 (6 ~ 20자 이내)" />
                <button type="button" onclick="checkUsername()">중복 확인</button>
            </div>
            <span class="message" id="userid-msg"></span>

            <label for="password">비밀번호</label>
            <input type="password" id="password" name="password" placeholder="비밀번호 입력 (문자, 숫자, 특수문자 포함 8~20자 이내)" />
            <span class="message" id="password-msg"></span>

            <label for="password-check">비밀번호 확인</label>
            <input type="password" id="password-check" placeholder="비밀번호를 다시 입력해 주세요." />
            <span class="message" id="password-check-msg"></span>

            <label for="name">이름</label>
            <input type="text" id="name" name="name" placeholder="이름을 입력해 주세요." />
            <span class="message" id="name-msg"></span>

            <label for="email">이메일</label>
            <div class="input-group">
                <input type="email" id="email" name="email" placeholder="이메일 주소를 입력해 주세요." />
                <button type="button" onclick="checkEmail()">인증 메일 받기</button>
            </div>
            <span class="message" id="email-msg"></span>

            <div class="input-group">
                <input type="text" id="email-code" placeholder="이메일주소로 온 인증번호를 입력해 주세요." />
                <button type="button" onclick="verifyEmailCode()">인증 확인</button>
            </div>
            <span class="message" id="email-code-msg"></span>

            <label for="birth-year">생년월일</label>
            <div class="birth-group">
                <input type="text" id="birth-year" name="birthYear" placeholder="년(4자)" maxlength="4" />
                <select id="birth-month" name="birthMonth">
                    <option value="">월</option>
                </select>
                <input type="text" id="birth-day" name="birthDay" placeholder="일" maxlength="2" />
            </div>
            <span class="message" id="birth-msg"></span>

            <div class="signup-buttons">
                <button type="submit" class="signup-btn">회원가입</button>
                <button type="button" class="cancel-btn" onclick="location.href='/'">회원가입 취소</button>
            </div>
        </form>
    </div>
</main>

<!-- 회원가입 완료 모달 -->
<div id="signupModal" class="modal">
    <div class="modal-content">
        <h2>메르헨드</h2>
        <p>회원가입 완료!!</p>
        <button id="modalLoginBtn">로그인 화면으로</button>
    </div>
</div>

<script>
    const toggle = document.getElementById('headerDropdownToggle');
    const menu = document.getElementById('headerDropdownMenu');


    const $signupForm = $("#signupForm");

    let userIdCheck = "Y";
    let emailAuthNumber = "";

    toggle.addEventListener('click', function (e) {
        e.stopPropagation();
        menu.style.display = menu.style.display === 'block' ? 'none' : 'block';
    });
    document.addEventListener('click', function () {
        menu.style.display = 'none';
    });

    // 유효성 검사 함수들
    function setError(input, msgEl, message) {
        input.classList.remove("valid");
        input.classList.add("invalid");
        msgEl.classList.remove("success");
        msgEl.classList.add("error");
        msgEl.textContent = message;
    }

    function setSuccess(input, msgEl, message) {
        input.classList.remove("invalid");
        input.classList.add("valid");
        msgEl.classList.remove("error");
        msgEl.classList.add("success");
        msgEl.textContent = message;
    }

    function checkUsername() {
        const input = document.getElementById("userid");
        const msg = document.getElementById("userid-msg");
        const value = input.value.trim();

        if (!value) return setError(input, msg, "아이디를 입력해 주세요.");
        if (value.length < 6 || value.length > 20)
            return setError(input, msg, "아이디는 6 ~ 20 자 이내로 입력해야 합니다.");

        $.ajax({
            url: "/user/getUserIdExists",
            type: "POST",
            dataType: "JSON",
            data: $signupForm.serialize(),
            success: function (json) {
                if (json.existsYn === "Y") {
                    setError(input, msg, "중복된 아이디입니다.");
                    setTimeout(() => input.focus(), 0);
                } else {
                    setSuccess(input, msg, "사용 가능한 아이디입니다.");
                    userIdCheck = "N";
                }
            }
        });
    }

    function validatePassword() {
        const pw = document.getElementById("password");
        const msg = document.getElementById("password-msg");
        const value = pw.value;
        if (!value) return setError(pw, msg, "비밀번호를 입력해 주세요.");
        const regex = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>/?]).{8,20}$/;
        if (!regex.test(value)) return setError(pw, msg, "비밀번호가 조건에 맞지 않습니다.");
        setSuccess(pw, msg, "사용 가능한 비밀번호 입니다.");
    }

    function validatePasswordCheck() {
        const pw = document.getElementById("password").value;
        const chk = document.getElementById("password-check");
        const msg = document.getElementById("password-check-msg");
        if (!chk.value) return setError(chk, msg, "비밀번호를 다시 입력해 주세요.");
        if (chk.value !== pw) return setError(chk, msg, "비밀번호가 일치하지 않습니다.");
        setSuccess(chk, msg, "비밀번호가 일치합니다.");
    }

    function checkEmail() {
        const input = document.getElementById("email");
        const msg = document.getElementById("email-msg");
        const value = input.value.trim();
        if (!value) return setError(input, msg, "이메일을 입력해 주세요.");

        const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!regex.test(value)) return setError(input, msg, "이메일 주소 형식이 맞지 않습니다.");


        $.ajax({
            url: "/user/getEmailExists",
            type: "POST",
            dataType: "JSON",
            data: $signupForm.serialize(),
            success: function (json) {
                if (json.existsYn === "Y") {
                    setError(input, msg, "중복된 이메일 입니다.");
                    setTimeout(() => input.focus(), 0);
                } else {
                    setSuccess(input, msg, "인증번호가 발송되었습니다.");
                    alert(json.authNumber);
                    emailAuthNumber = json.authNumber;
                }
            }
        });


    }


    function verifyEmailCode() {
        const code = document.getElementById("email-code");
        const msg = document.getElementById("email-code-msg");
        const emailInput = document.getElementById("email");
        const emailBtn = emailInput.nextElementSibling;
        const emailCodeBtn = code.nextElementSibling;

        const expected = (emailAuthNumber + "").trim();
        const inputCode = code.value.trim();

        if (!inputCode) {
            return setError(code, msg, "인증번호를 입력해 주세요.");
        }

        if (inputCode !== expected) {
            return setError(code, msg, "인증번호가 일치하지 않습니다.");
        }

        // ✅ 인증번호가 일치할 경우만 아래 코드 실행됨
        setSuccess(code, msg, "인증되었습니다.");

        // 입력/버튼 비활성화
        emailInput.disabled = true;
        emailBtn.disabled = true;
        code.disabled = true;
        emailCodeBtn.disabled = true;

        // 스타일 비활성화
        emailInput.style.opacity = 0.5;
        code.style.opacity = 0.5;

        emailBtn.style.opacity = 0.5;
        emailCodeBtn.style.opacity = 0.5;

        emailInput.style.cursor = "not-allowed";
        code.style.cursor = "not-allowed";
        emailBtn.style.cursor = "not-allowed";
        emailCodeBtn.style.cursor = "not-allowed";


    }

    function validateBirth() {
        const year = document.getElementById("birth-year");
        const month = document.getElementById("birth-month");
        const day = document.getElementById("birth-day");
        const msg = document.getElementById("birth-msg");

        const y = parseInt(year.value, 10);
        const m = parseInt(month.value, 10);
        const d = parseInt(day.value, 10);

        if (!year.value) return setError(year, msg, "년도를 입력해 주세요.");
        if (!/^[0-9]{4}$/.test(year.value)) return setError(year, msg, "년도는 4자리수 입니다.");
        if (!month.value) return setError(month, msg, "월을 선택해 주세요.");
        if (!day.value) return setError(day, msg, "일을 입력해 주세요.");

        // Date 객체를 만들 때 월은 0~11
        const date = new Date(y, m - 1, d);

        // 월과 일이 올바른지 체크
        if (date.getFullYear() !== y || date.getMonth() !== m - 1 || date.getDate() !== d) {
            return setError(day, msg, "일수가 맞지 않습니다.");
        }

        setSuccess(year, msg, "");
        setSuccess(month, msg, "");
        setSuccess(day, msg, "생년월일이 유효합니다.");
    }

    // 자동 연결
    document.getElementById("password").addEventListener("input", validatePassword);
    document.getElementById("password-check").addEventListener("input", validatePasswordCheck);
    document.getElementById("name").addEventListener("input", function () {
        const input = this;
        const msg = document.getElementById("name-msg");
        if (!input.value.trim()) setError(input, msg, "이름을 입력해 주세요.");
        else setSuccess(input, msg, "");
    });
    document.getElementById("birth-year").addEventListener("blur", validateBirth);
    document.getElementById("birth-day").addEventListener("blur", validateBirth);

    // 월 추가
    const select = document.getElementById('birth-month');
    for (let i = 1; i <= 12; i++) {
        const option = document.createElement('option');
        option.value = i;
        option.textContent = i;
        select.appendChild(option);
    }


    $signupForm.on("submit", function (e) {
        e.preventDefault();

        // 아이디 체크
        const userId = document.getElementById("userid");
        const userIdMsg = document.getElementById("userid-msg");
        if (!userId.value.trim()) {
            setError(userId, userIdMsg, "아이디를 입력해 주세요.");
            userId.focus();
            return;
        }

        // 비밀번호 체크
        const pw = document.getElementById("password");
        const pwMsg = document.getElementById("password-msg");
        if (!pw.value.trim()) {
            setError(pw, pwMsg, "비밀번호를 입력해 주세요.");
            pw.focus();
            return;
        }
        if (pw.classList.contains("invalid")) {
            pw.focus();
            return;
        }

        // 비밀번호 확인
        const pwChk = document.getElementById("password-check");
        const pwChkMsg = document.getElementById("password-check-msg");
        if (!pwChk.value.trim()) {
            setError(pwChk, pwChkMsg, "비밀번호를 다시 입력해 주세요.");
            pwChk.focus();
            return;
        }
        if (pwChk.classList.contains("invalid")) {
            pwChk.focus();
            return;
        }

        // 이름 체크
        const name = document.getElementById("name");
        const nameMsg = document.getElementById("name-msg");
        if (!name.value.trim()) {
            setError(name, nameMsg, "이름을 입력해 주세요.");
            name.focus();
            return;
        }

        // 이메일 체크
        const email = document.getElementById("email");
        const emailMsg = document.getElementById("email-msg");
        const emailCode = document.getElementById("email-code");
        const emailCodeMsg = document.getElementById("email-code-msg");
        if (!email.value.trim()) {
            setError(email, emailMsg, "이메일을 입력해 주세요.");
            email.focus();
            return;
        }
        if (emailCode.classList.contains("invalid")) {
            emailCode.focus();
            return;
        }

        // 생년월일 체크
        const year = document.getElementById("birth-year");
        const month = document.getElementById("birth-month");
        const day = document.getElementById("birth-day");
        const birthMsg = document.getElementById("birth-msg");
        if (!year.value.trim()) {
            setError(year, birthMsg, "년도를 입력해 주세요.");
            year.focus();
            return;
        }
        if (!month.value.trim()) {
            setError(month, birthMsg, "월을 선택해 주세요.");
            month.focus();
            return;
        }
        if (!day.value.trim()) {
            setError(day, birthMsg, "일을 입력해 주세요.");
            day.focus();
            return;
        }
        if (day.classList.contains("invalid")) {
            day.focus();
            return;
        }

        // 모든 검증 통과 시 AJAX 요청
        $.ajax({
            url: "/user/insertUserInfo",
            type: "POST",
            dataType: "JSON",
            data: $signupForm.serialize(),
            success: function (json) {
                if (json.result === 1) {
                    // 모달 띄우기
                    const modal = document.getElementById("signupModal");
                    modal.style.display = "block";

                    // 버튼 클릭 시 로그인 페이지로 이동
                    document.getElementById("modalLoginBtn").onclick = function() {
                        location.href = "/user/login";
                    };
                } else {
                    alert(json.msg);
                }
            }
        });
    });

</script>
</body>

</html>