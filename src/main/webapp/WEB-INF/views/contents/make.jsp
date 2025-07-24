<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>동화 생성</title>
	<!-- Google Fonts: Kavoon, Cute Font -->
	<link href="https://fonts.googleapis.com/css2?family=Kavoon&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Cute+Font&family=Kavoon&display=swap" rel="stylesheet">

	<!-- Font Awesome -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
	<link rel="stylesheet" href="/css/table.css" />
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
			<div class="top-title">동화 만들기</div>
			<div style="width: 60px;"></div>
		</div>

		<div class="container">
			<div class="card-wrapper">
				<div class="card card-img">
					<div class="screen-text">카메라에 손 모양을 보여주세요</div>
					<div class="black-screen"></div>
				</div>
				<div class="card text-card">
					<div class="word-check-text">이 단어가 맞나요?</div>
					<div class="word-check-container">
						<div class="word-check-content">공주</div>
					</div>
					<div class="button-container">
						<input type="button" class="word-button" value="다시 입력">
						<input type="button" class="word-button" value="단어 추가">
					</div>
				</div>
				<div class="card card-dic">
					<div>
						<fieldset>
							<legend>2 / 10</legend>
							<div class="list-content">왕자, 구두</div>
						</fieldset>
						<div class="list-main-name">주인공 이름</div>
						<input type="text" class="list-main-name-insert">
					</div>
				</div>
			</div>
			<div class="make-wrapper">
				<button type="button" class="button make" id="submitBtn">동화 생성</button>
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

	document.getElementById('submitBtn').addEventListener('click', function () {
		const form = document.getElementById('f');
		form.action = '/contents/makeResult';
		form.method = 'get';
		form.submit();
	});
</script>
</body>
</html>