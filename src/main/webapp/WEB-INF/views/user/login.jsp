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
    <script type="text/javascript" src="/js/jquery-3.6.0.min.js"></script>

    <!-- ✅ 공통 상단바 스타일 -->
 
    <link rel="stylesheet" href="/css/table.css" />

    <style>
        .main-container {
            position: relative;
            width: 100vw;
            height: 100vh;
            overflow: hidden;
        }


        .background-image {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
 
            z-index: 0;
        }

        .background-image img.bg-img {
            position: absolute;
            top: 0;
            left: -20px;   /* ← 여기서 오른쪽으로 이동시키기 위해 조정 */
            width: 100vw;
            height: 100vh;
            object-fit: cover;
        }


 
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
            font-size: 24px;
            padding: 12px 30px;

           
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

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 40px;
            background-color: #fca08c;
            z-index: 3;
        }

        .header-logo {
            font-size: 26px;
            font-family: 'Kavoon', cursive;
        }

        .header-icon-stack {
            display: flex;
            gap: 10px;
            font-size: 24px;
        }
    </style>
    <script>
        $(document).ready(function () {

            $("#btnLogin").on("click", function () {
                let f = document.getElementById("f");

                if (f.userId.value === "") {
                    alert("아이디를 입력하세요.");
                    f.userId.focus();
                    return;
                }

                if (f.password.value === "") {
                    alert("비밀번호를 입력하세요.");
                    f.password.focus();
                    return;
                }

                // Ajax 호출해서 로그인하기
                $.ajax({
                        url: "/user/loginProc",
                        type: "post", // 전송방식은 Post
                        dataType: "JSON", // 전송 결과는 JSON으로 받기
                        data: $("#f").serialize(), // form 태그 내 input 등 객체를 자동으로 전송할 형태로 변경하기
                        success: function (json) { // /notice/noticeUpdate 호출이 성공했다면..

                            if (json.result === 1) { // 로그인 성공
                                alert(json.msg); // 메시지 띄우기
                                location.href = "/"; // 로그인 성공 페이지 이동

                            } else { // 로그인 실패
                                alert(json.msg); // 메시지 띄우기
                                $("#userId").focus(); // 아이디 입력 항목에 마우스 커서 이동
                            }

                        }
                    }
                )

            })
        })

    </script>
</head>

<body>
<div class="main-container">
    <!-- 배경 이미지 -->
    <div class="background-image">
        <img src="/images/login.png" alt="배경 이미지" class="bg-img" />
    </div>

    <!-- 상단바 -->
    <header>
        <div class="header-icon-stack">
            <i class="fa-solid fa-book-open book"></i>
            <i class="fa-solid fa-hands-holding hands"></i>
        </div>
        <div class="header-logo">Märchand</div>
    </header>

    <form id="f">
        <div class="login-wrapper">
            <label><span>ID :</span><input type="text" name="userId" id="userId" placeholder="ID를 입력 하세요"></label>
            <label><span>비밀번호 :</span><input type="password" name="password" id="password" placeholder="비밀번호를 입력하세요."></label>

            <div class="login-buttons">
                <button type="button" id="btnLogin">로그인!</button>
            </div>

            <div class="find-links">
                ID나 비밀번호가 기억이 안나시나요?<br>
                <a href="/user/findId">ID 찾기</a> /
                <a href="/contents/findPw">비밀번호 찾기</a>
            </div>
        </div>
    </form>
</div>
</body>
</html>
