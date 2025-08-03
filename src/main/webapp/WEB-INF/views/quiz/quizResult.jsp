<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>퀴즈 결과</title>
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
			<div class="top-title">체점 결과</div>
			<div style="width: 60px;"></div>
		</div>

		<div class="container">
			<div class="card-wrapper">
				<div class="card card-img">
					<div class="score-text">100점</div>
				</div>
				<div class="score-result">
					<div><span class="word">토끼</span> : <span class="result correct">정답</span></div>
					<div><span class="word">자라</span> : <span class="result correct">정답</span></div>
					<div><span class="word">동물</span> : <span class="result correct">정답</span></div>
					<div><span class="word">용왕</span> : <span class="result correct">정답</span></div>
					<div><span class="word">보물</span> : <span class="result correct">정답</span></div>
					<div><span class="word">생일</span> : <span class="result correct">정답</span></div>
				</div>
			</div>
			<div class="make-wrapper">
				<button type="button" class="button make" id="quizSaveBtn">저장하기</button>
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

	const nextBtn = document.querySelector('.button.make');

	nextBtn.addEventListener('click', function () {
		alert('저장되었습니다.');
	});

	document.getElementById('quizSaveBtn').addEventListener('click', function () {
		const form = document.getElementById('f');
		form.action = '/contents/quizList';
		form.method = 'get';
		form.submit();
	});

</script>
</body>
</html>