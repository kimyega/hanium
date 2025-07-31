<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>비밀번호 찾기</title>

    <!-- 폰트 및 아이콘 -->
    <link href="https://fonts.googleapis.com/css2?family=Kavoon&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Cute+Font&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="stylesheet" href="/css/table.css" />
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            background-color: #f5f3f2;
            font-family: 'Cute Font', sans-serif;
            font-size: 20px;
        }

        header {
            background-color: #fca08c;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 30px;
            position: relative;
        }

        .header-icon-stack {
            position: relative;
            width: 60px;
            height: 60px;
        }

        .header-icon-stack .book {
            position: absolute;
            top: 10px;
            left: 20%;
            transform: translateX(-50%);
            font-size: 20px;
            color: black;
        }

        .header-icon-stack .hands {
            position: absolute;
            bottom: 10px;
            left: 20%;
            transform: translateX(-50%);
            font-size: 40px;
            color: black;
        }

        .header-logo {
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
            font-family: 'Kavoon', cursive;
            font-size: 24px;
        }

        .header-logo:hover { cursor: pointer; }

        .header-user-area {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 14px;
        }

        .header-user-icon {
            width: 24px;
            height: 24px;
            font-size: 30px;
            margin-right: 40px;
        }

        .header-dropdown {
            position: relative;
        }

        .header-dropdown-toggle {
            background-color: #fca08c;
            border: none;
            font-family: 'Cute Font', sans-serif;
            font-size: 35px;
            cursor: pointer;
            padding: 5px 10px;
            border-radius: 5px;
        }

        .header-dropdown-toggle:hover {
            background-color: #ffe1d7;
        }

        .header-dropdown-menu {
            display: none;
            position: absolute;
            right: 0;
            background-color: white;
            border: 1px solid #ccc;
            min-width: 180px;
            box-shadow: 0px 8px 16px rgba(0,0,0,0.2);
            z-index: 1;
            border-radius: 5px;
        }

        .header-dropdown-menu li {
            padding: 10px;
            cursor: pointer;
            list-style: none;
            font-size: 24px;
        }

        .header-dropdown-menu li:hover {
            background-color: #fca08c;
            color: white;
        }

        main {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 80vh;
        }

        .find-box {
            background-color: white;
            border: 6px solid #fca08c;
            border-radius: 30px;
            padding: 60px 80px;
            box-shadow: 8px 8px 10px rgba(0,0,0,0.1);
            width: 600px;
            text-align: center;
        }

        .find-title {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 40px;
        }

        .find-form {
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
            font-size: 22px;
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
            font-family: 'Cute Font', sans-serif;
            padding: 6px 4px;
        }

        .form-row input::placeholder {
            color: #e6bcbc;
        }

        .verify-button {
            margin-top: 20px;
            width: 100%;
            font-size: 24px;
            font-family: 'Cute Font', sans-serif;
            padding: 15px 0;
            border: none;
            background-color: #fca08c;
            color: white;
            border-radius: 40px;
            cursor: pointer;
            box-shadow: 5px 5px 5px rgba(0,0,0,0.15);
            transition: background-color 0.3s ease;
        }

        .verify-button:hover {
            background-color: #ffbfa8;
        }
    </style>
</head>
<body>
<header>
    <div class="header-icon-stack">
        <i class="fa-solid fa-book-open book"></i>
        <i class="fa-solid fa-hands-holding hands"></i>
    </div>
    <div class="header-logo">Märchand</div>
    <div class="header-user-area">
        <div class="header-user-icon">
            <i class="fa-solid fa-circle-user fa-2xl"></i>
        </div>
        <div class="header-dropdown">
            <button class="header-dropdown-toggle" id="headerDropdownToggle">홍길동 ▼</button>
            <ul class="header-dropdown-menu" id="headerDropdownMenu">
                <li onclick="location.href='/profile.html'">내 정보</li>
                <li onclick="location.href='/logout.html'">로그아웃</li>
            </ul>
        </div>
    </div>
</header>

<main>
    <section id="step1" class="find-box">
        <h1 class="find-title">비밀번호 찾기</h1>
        <form class="find-form">
            <div class="form-row">
                <label for="userid">아이디:</label>
                <input type="text" id="userid" placeholder="아이디를 입력하세요." />
            </div>
            <div class="form-row">
                <label for="email">이메일:</label>
                <input type="email" id="email" placeholder="이메일을 입력하세요." />
            </div>
            <button type="submit" class="verify-button">인증메일 받기</button>
        </form>
    </section>

    <section id="step2" class="find-box" style="display: none;">
        <h1 class="find-title">인증번호를 입력하세요.</h1>
        <form class="find-form">
            <div class="form-row">
                <label for="code">인증번호:</label>
                <input type="text" id="code" placeholder="인증번호 입력" />
            </div>
            <button type="submit" class="verify-button">인증번호 확인</button>
        </form>
    </section>

    <section id="step3" class="find-box" style="display: none;">
        <h1 class="find-title">새 비밀번호를 입력하세요.</h1>
        <form class="find-form">
            <div class="form-row">
                <label for="newpw">새 비밀:</label>
                <input type="password" id="newpw" placeholder="새 비밀번호" />
            </div>
            <div class="form-row">
                <label for="confirmpw">확인:</label>
                <input type="password" id="confirmpw" placeholder="비밀번호 확인" />
            </div>
            <button type="submit" class="verify-button">비밀번호 변경</button>
        </form>
    </section>

    <section id="step4" class="find-box" style="display: none;">
        <h1 class="find-title">비밀번호가 변경되었습니다!</h1>
        <button class="verify-button" onclick="location.href='/'">로그인 화면으로 돌아가기</button>
    </section>niu
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

    const step1 = document.getElementById('step1');
    const step2 = document.getElementById('step2');
    const step3 = document.getElementById('step3');
    const step4 = document.getElementById('step4');

    step1.querySelector('form').addEventListener('submit', function(e) {
        e.preventDefault();
        step1.style.display = 'none';
        step2.style.display = 'block';
    });

    step2.querySelector('form').addEventListener('submit', function(e) {
        e.preventDefault();
        const code = document.getElementById('code').value;
        if (code === '123456') {
            step2.style.display = 'none';
            step3.style.display = 'block';
        } else {
            alert('인증번호가 올바르지 않습니다.');
        }
    });

    step3.querySelector('form').addEventListener('submit', function(e) {
        e.preventDefault();
        const pw = document.getElementById('newpw').value;
        const confirm = document.getElementById('confirmpw').value;
        if (pw && pw === confirm) {
            step3.style.display = 'none';
            step4.style.display = 'block';
        } else {
            alert('비밀번호가 일치하지 않습니다.');
        }
    });
</script>
</body>
</html>
