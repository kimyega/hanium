<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>회원가입 | Märchand</title>
    <link href="https://fonts.googleapis.com/css2?family=Kavoon&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Cute+Font&family=Kavoon&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
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
                <input type="text" id="userid" placeholder="아이디 입력 (6 ~ 20자 이내)" />
                <button type="button" onclick="checkUsername()">중복 확인</button>
            </div>
            <span class="message" id="userid-msg"></span>

            <label for="password">비밀번호</label>
            <input type="password" id="password" placeholder="비밀번호 입력 (문자, 숫자, 특수문자 포함 8~20자 이내)" />
            <span class="message" id="password-msg"></span>

            <label for="password-check">비밀번호 확인</label>
            <input type="password" id="password-check" placeholder="비밀번호를 다시 입력해 주세요." />
            <span class="message" id="password-check-msg"></span>

            <label for="name">이름</label>
            <input type="text" id="name" placeholder="이름을 입력해 주세요." />
            <span class="message" id="name-msg"></span>

            <label for="email">이메일</label>
            <div class="input-group">
                <input type="email" id="email" placeholder="이메일 주소를 입력해 주세요." />
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
                <input type="text" id="birth-year" placeholder="년(4자)" maxlength="4" />
                <select id="birth-month">
                    <option value="">월</option>
                </select>
                <input type="text" id="birth-day" placeholder="일" maxlength="2" />
            </div>
            <span class="message" id="birth-msg"></span>

            <div class="signup-buttons">
                <button type="submit" class="signup-btn">회원가입</button>
                <button type="button" class="cancel-btn" onclick="location.href='main.html'">회원가입 취소</button>
            </div>
        </form>
    </div>
</main>

<script>
    const toggle = document.getElementById('headerDropdownToggle');
    const menu = document.getElementById('headerDropdownMenu');

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
        const isDuplicated = ["admin", "test", "user1"].includes(value);
        if (isDuplicated) setError(input, msg, "중복된 아이디 입니다.");
        else setSuccess(input, msg, "사용가능한 아이디 입니다.");
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

        const isDuplicated = ["test@test.com"].includes(value);
        if (isDuplicated) return setError(input, msg, "중복된 이메일 입니다.");

        setSuccess(input, msg, "사용 가능한 이메일입니다.");
    }


    function verifyEmailCode() {
        const code = document.getElementById("email-code");
        const msg = document.getElementById("email-code-msg");
        const emailInput = document.getElementById("email");
        const emailBtn = emailInput.nextElementSibling;

        const expected = "123456";
        const inputCode = code.value.trim();

        if (!inputCode) {
            return setError(code, msg, "인증번호를 입력해 주세요.");
        }

        if (inputCode !== expected) {
            return setError(code, msg, "인증번호가 일치하지 않습니다.");
        }

        // ✅ 인증번호가 일치할 경우만 아래 코드 실행됨
        setSuccess(code, msg, "인증되었습니다.");

        // 이메일 입력란, 버튼, 코드 입력창 비활성화
        emailInput.disabled = true;
        emailBtn.disabled = true;
        code.disabled = true;

        // 버튼 스타일도 비활성화처럼 보이게
        emailBtn.style.opacity = 0.5;
        emailBtn.style.cursor = "not-allowed";
    }

    function validateBirth() {
        const year = document.getElementById("birth-year");
        const month = document.getElementById("birth-month");
        const day = document.getElementById("birth-day");
        const msg = document.getElementById("birth-msg");
        if (!year.value) return setError(year, msg, "년도를 입력해 주세요.");
        if (!/^[0-9]{4}$/.test(year.value)) return setError(year, msg, "년도는 4자리수 입니다.");
        if (!month.value) return setError(month, msg, "월을 선택해 주세요.");
        if (!day.value) return setError(day, msg, "일을 입력해 주세요.");
        const date = new Date(`${year.value}-${month.value}-${day.value}`);
        if (isNaN(date.getTime()) || date.getDate() != day.value)
            return setError(day, msg, "일수가 맞지 않습니다.");
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
</script>
</body>

</html>