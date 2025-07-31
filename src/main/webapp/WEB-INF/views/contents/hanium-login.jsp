<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>한이음 - 로그인</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Cute+Font&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Kavoon&display=swap" rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

    <!-- ✅ 공통 상단바 스타일 -->
    <link rel="stylesheet" href="/css/table.css" />

    <style>
        .main-container {
            position: relative;
            width: 100vw;
            height: 100vh;
            overflow: hidden;
        }

        /* ✅ 배경을 이미지로 처리 */
        .background-image {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url('/Hanium/이미지.png'); /* 이미지 경로 확인 필요 */
            background-size: 70%;
            background-position: center;
            background-repeat: no-repeat;
            z-index: 0;
        }

        /* ✅ 로그인 박스 */
        .login-wrapper {
            position: absolute;
            top: 65%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: white;
            border: 6px solid #fca08c;
            border-radius: 30px;
            padding: 30px 50px;
            text-align: left;
            font-size: 24px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
            z-index: 2;
        }

        .login-wrapper label {
            display: flex;
            align-items: center;
            margin: 14px 0;
        }

        .login-wrapper label span {
            display: inline-block;
            width: 100px;
            text-align: right;
            margin-right: 10px;
        }

        .login-wrapper input {
            font-family: 'Cute Font', sans-serif;
            font-size: 24px;
            padding: 8px 10px;
            border: none;
            border-bottom: 2px solid #ccc;
            width: 300px;
        }

        .login-buttons {
            display: flex;
            justify-content: center;
            margin-top: 25px;
        }

        .login-buttons button {
            font-family: 'Cute Font', sans-serif;
            font-size: 30px;
            padding: 16px 60px;
            border: 4px solid #fca08c;
            border-radius: 50px;
            background-color: white;
            cursor: pointer;
            transition: 0.3s;
        }

        .login-buttons button:hover {
            background-color: #fca08c;
            color: white;
        }

        .find-links {
            margin-top: 25px;
            font-size: 18px;
            text-align: center;
        }

        .find-links a {
            color: #3b5eff;
            text-decoration: none;
            margin: 0 5px;
        }

        .find-links a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>
<div class="main-container">
    <!-- ✅ 배경 이미지 -->
    <div class="background-image"></div>

    <!-- ✅ 상단바 -->
    <header>
        <div class="header-icon-stack">
            <i class="fa-solid fa-book-open book"></i>
            <i class="fa-solid fa-hands-holding hands"></i>
        </div>
        <div class="header-logo">Märchand</div>
    </header>

    <!-- ✅ 로그인 폼 -->
    <form>
        <div class="login-wrapper">
            <label><span class="label-text">ID :</span><input type="text" placeholder="ID를 입력 하세요"></label>
            <label><span class="label-text">비밀번호 :</span><input type="password" placeholder="비밀번호를 입력하세요."></label>

            <div class="login-buttons">
                <button type="submit">로그인!</button>
            </div>

            <div class="find-links">
                ID나 비밀번호가 기억이 안나시나요?<br>
                <a href="/Hanium/haniumIDfound01.html">ID 찾기</a> /
                <a href="/Hanium/haniumpassword.html">비밀번호 찾기</a>
            </div>
        </div>
    </form>
</div>
</body>
</html>
