<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>별주부전</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Kavoon&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Cute+Font&display=swap" rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

    <!-- CSS 파일 -->
    <link rel="stylesheet" href="/css/table.css" />

    <!-- 💡 추가 인라인 스타일 -->
    <style>
        html, body {
            margin: 0;
            padding: 0;
            height: 100vh;
            overflow: hidden; /* 💥 스크롤 방지 */
            font-family: 'Cute Font', sans-serif;
        }

        .start-container {
            width: 100vw;
            height: 100vh;
            position: relative;
            overflow: hidden;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .start-image {
            max-width: 100%;
            max-height: 100%;
            height: auto;
            width: auto;
            display: block;
        }

        .start-buttons {
            position: absolute;
            bottom: 200px;
            display: flex;
            gap: 70px;
        }

        .start-button {
            font-size: 30px;
            padding: 20px 40px;
            border-radius: 35px;
            border: none;
            background-color: white;
            border: 2px solid #f59c8b;
            font-family: 'Cute Font', sans-serif;
            cursor: pointer;
            box-shadow: 2px 2px 6px rgba(0, 0, 0, 0.15);
        }

        .top-bar {
            position: absolute;
            top: 80px;
            left: 20px;
        }

        .top-home-button {
            background: none;
            border: none;
            cursor: pointer;
        }
    </style>
</head>

<body class="start-page">
<header>
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


    <div class="start-container">
        <img src="/Hanium/배경이미지.png" alt="동물 그림" class="start-image" />
        <div class="start-buttons">
            <button class="start-button" onclick="location.href='/Hanium/signup.html'" type="button">회원 가입</button>
            <button class="start-button" onclick="location.href='/'" type="button">로그인</button>
        </div>
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
</script>
</body>
</html>
