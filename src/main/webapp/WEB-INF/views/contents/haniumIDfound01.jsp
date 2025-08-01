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
</head>
<body>

<header>
    <div class="header-icon-stack">
        <i class="fa-solid fa-book-open book"></i>
        <i class="fa-solid fa-hands-holding hands"></i>
    </div>
    <div class="header-logo" onclick="location.href='main.html'">Märchand</div>
    <div class="header-user-area">
        <div class="header-user-icon">
            <i class="fa-solid fa-circle-user fa-2xl"></i>
        </div>
        <div class="header-dropdown">
            <button class="header-dropdown-toggle" id="headerDropdownToggle">홍길동 ▼</button>
            <ul class="header-dropdown-menu" id="headerDropdownMenu">
                <li onclick="location.href='profile.html'">내 정보</li>
                <li onclick="location.href='logout.html'">로그아웃</li>
            </ul>
        </div>
    </div>
</header>

<main>
    <!-- 1단계 -->
    <section id="step1" class="find-id-box">
        <h1 class="find-id-title">아이디 찾기</h1>
        <form class="find-id-form">
            <div class="form-row">
                <label for="name">이름:</label>
                <input type="text" id="name" placeholder="이름을 입력하세요." />
            </div>
            <div class="form-row">
                <label for="email">이메일:</label>
                <input type="email" id="email" placeholder="이메일을 입력하세요." />
            </div>
            <button type="submit" class="verify-button">인증메일 받기</button>
        </form>
    </section>

    <!-- 2단계 -->
    <section id="step2" class="find-id-box" style="display: none;">
        <h1 class="find-id-title">이메일로 온 인증번호를 입력해 주세요.</h1>
        <form class="find-id-form">
            <div class="form-row">
                <label for="code">인증번호:</label>
                <input type="text" id="code" placeholder="인증번호 입력" />
            </div>
            <button type="submit" class="verify-button">인증번호 확인</button>
        </form>
    </section>

    <!-- 3단계 -->
    <section id="step3" class="find-id-box" style="display: none;">
        <h1 class="find-id-title">홍길동님의 아이디를 찾았습니다!</h1>
        <p style="font-size: 20px; margin: 30px 0;">아이디: <strong>honggil572</strong></p>
        <button class="verify-button" onclick="location.href='/'">로그인 화면으로 돌아가기</button>
    </section>
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

    // 단계 전환
    const step1 = document.getElementById('step1');
    const step2 = document.getElementById('step2');
    const step3 = document.getElementById('step3');

    document.querySelector('#step1 form').addEventListener('submit', function(e) {
        e.preventDefault();
        alert('인증 메일이 전송되었습니다.');
        step1.style.display = 'none';
        step2.style.display = 'block';
    });

    document.querySelector('#step2 form').addEventListener('submit', function(e) {
        e.preventDefault();
        const code = document.getElementById('code').value;
        if (code === '123456') {
            step2.style.display = 'none';
            step3.style.display = 'block';
        } else {
            alert('인증번호가 올바르지 않습니다.');
        }
    });
</script>
</body>
</html>
