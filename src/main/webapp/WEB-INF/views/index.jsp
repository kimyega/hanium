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


	<!-- CSS -->
	<link rel="stylesheet" href="/css/table.css" />
	<style>
		html, body {
			margin: 0;
			padding: 0;
			height: 100vh;
			overflow: hidden;
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

		header {
			background-color: #fca08c;
			padding: 15px 40px;
			display: flex;
			justify-content: space-between;
			align-items: center;
		}

		.header-logo {
			font-family: 'Kavoon', cursive;
			font-size: 26px;
			color: #333;
			cursor: pointer;
		}

		.header-icon-stack {
			display: flex;
			gap: 10px;
			font-size: 24px;
			color: #333;
		}

		.header-user-area {
			display: flex;
			align-items: center;
			gap: 10px;
		}

		.header-dropdown-toggle {
			border: none;
			background: none;
			cursor: pointer;
			font-size: 18px;
		}

		.header-dropdown-menu {
			display: none;
			position: absolute;
			top: 60px;
			right: 40px;
			background-color: white;
			border: 1px solid #ccc;
			border-radius: 8px;
			list-style: none;
			padding: 10px 0;
			box-shadow: 0 2px 6px rgba(0,0,0,0.15);
		}

		.header-dropdown-menu li {
			padding: 10px 20px;
			cursor: pointer;
		}

		.header-dropdown-menu li:hover {
			background-color: #f1f1f1;
		}
		/* start-page 클래스가 body에 있을 때만 유저 아이콘 영역 숨기기 */
		.start-page .header-user-area {
			display: none;
		}

	</style>

	
</head>

<body class="start-page">
<header>
	<div class="header-icon-stack">
		<i class="fa-solid fa-book-open book"></i>
		<i class="fa-solid fa-hands-holding hands"></i>
	</div>
 
	<div class="header-logo" onclick="location.href='/'">Märchand</div>

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

		<img src="/images/start.png" alt="동물 그림" class="start-image" />
		<div class="start-buttons">
			<!-- ✅ 회원가입 / 로그인 버튼 경로 수정 -->
			<!-- index.jsp 내 최종 수정 -->
			<button class="start-button" onclick="location.href='/contents/register'" type="button">회원 가입</button>
			<button class="start-button" onclick="location.href='/contents/login'" type="button">로그인</button>


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
