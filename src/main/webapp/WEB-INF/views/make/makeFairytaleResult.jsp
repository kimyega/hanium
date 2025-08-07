<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>동화 생성 결과</title>
	<!-- Google Fonts: Kavoon, Cute Font -->
	<link href="https://fonts.googleapis.com/css2?family=Kavoon&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Cute+Font&family=Kavoon&display=swap" rel="stylesheet">

	<!-- Font Awesome -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
	<link rel="stylesheet" href="/css/table.css" />
	<style>
		.made {
			background-color: #fff;
			padding: 20px;
			flex: none;
			display: flex;
			flex-direction: column;
			align-items: center;
			border: 15px solid #fca08c;
			width: 50%;
			height: 600px;
			font-size: 55px;
		}

		.made.contents {
			text-align: center;
			overflow-y: auto;
		}

		.made.contents::-webkit-scrollbar {
			width: 15px;               /* 스크롤바 너비 */
			height: 20px;
		}

		.made.contents::-webkit-scrollbar-track {
			background: #ffe5de;       /* 스크롤 트랙 배경 */
			width: 2px;
		}

		.made.contents::-webkit-scrollbar-thumb {
			background-color: #fca08c; /* 스크롤바 색상 */
			border-radius: 10px;
			border: 3px solid #ffe5de; /* thumb 테두리 색상 (트랙과 같게 하면 패딩처럼 보임) */
		}

		.made-card-wrapper {
			width: 60%;
			display: flex;
			justify-content: space-between;
			gap: 0;
			margin: 15px auto 0 auto;
			margin-top: 15px;
			box-shadow: 0 3px 10px rgba(0, 0, 0, 0.05);
			border-radius: 10px;
			border: 15px solid #fca08c;
		}

		.make-wrapper-two {
			display: flex;
			justify-content: space-between; /* 버튼을 양쪽 끝으로 정렬 */
			align-items: center;
			margin-top: 10px;
			width: 100%; /* 전체 너비 사용 */
			padding: 0 30px; /* 좌우 여백 조절 (원하면 조정 가능) */
			box-sizing: border-box;
		}

		.make-wrapper-two button {
			font-family: 'Cute Font', sans-serif;
			font-size: 35px;
			padding: 30px 90px;
			border-radius: 100px;
			border: 8px solid #fca08c;
			background-color: white;
			cursor: pointer;
			text-align: center;
			display: flex;
			align-items: center;
			justify-content: center;
			line-height: 1.2;
			white-space: nowrap;
			writing-mode: horizontal-tb;
			width: 200px;
			height: 80px;
		}

		.make-wrapper-two button:hover {
			background-color: #fca08c;
			color: white;
		}
	</style>
</head>

<body>
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

<form id="f">
	<main>
		<div class="top-bar">
			<button class="button top-home-button" onclick="location.href='/home.html'">
				<i class="fa-solid fa-house fa-2xl"></i>
			</button>
		</div>

		<div class="container">
			<div class="made-card-wrapper">
				<div class="made card card-img">
					<img src="/images/castle.png" alt="없습니다.">
				</div>
				<div class="made contents">
					<p>
						옛날 옛날에 용궁에 용왕님이 살고 있었는데,
						어느날 용왕님이 죽을병에 걸리고 말았어요.
					</p>
					<p>
						용왕님의 <span class="highlight underline">병</span>을 고치려면 <span class="highlight underline">토끼</span>의 간이 필요해요
					</p>
				</div>
			</div>
			<div class="make-wrapper-two">
				<button class="button make" onclick="location.href='/pre-page.html'">다시 만들기</button>
				<button class="button make" onclick="location.href='/next-page.html'">동화생성</button>
			</div>
		</div>

	</main>
</form>

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