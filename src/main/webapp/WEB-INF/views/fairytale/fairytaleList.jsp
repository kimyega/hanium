<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>동화 목록</title>
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
			<div class="top-search">
				<i class="fa-solid fa-magnifying-glass fa-sm" style="color: #000000;"></i>
			</div>
			<div style="width: 60px;"></div>
		</div>

		<hr style="color: #fca08c; border: 2px solid;">

		<div class="slide-container">
			<div class="slide-card-wrapper" id="slideCardWrapper">
				<div class="slide-card" onclick="goToDetail('/stories/pig.html')">
					<div class="card-inner" style="background-color: #fca0b3">
						<img src="/images/pig.png" alt="아기돼지 삼형제">
						<div class="card-title">아기돼지 삼형제</div>
					</div>
				</div>
				<div class="slide-card" onclick="goToDetail('/stories/pig.html')">
					<div class="card-inner" style="background-color: #ffd167">
						<img src="/images/castle.png" alt="코딩 왕자">
						<div class="card-title">코딩 왕자</div>
					</div>
				</div>
				<div class="slide-card" onclick="goToDetail('/stories/pig.html')">
					<div class="card-inner" style="background-color: #ff93c9">
						<img src="/images/hansel.png" alt="헨젤과 그레텔">
						<div class="card-title">헨젤과 그레텔</div>
					</div>
				</div>
				<div class="slide-card" onclick="goToDetail('/contents/hanium.jsp')">
					<div class="card-inner" style="background-color: #a0e7e5">
						<img src="/images/turtle.png" alt="별주부전">
						<div class="card-title">별주부전</div>
					</div>
				</div>
				<div class="slide-card" onclick="goToDetail('/stories/pig.html')">
					<div class="card-inner" style="background-color: #d3a4ff">
						<img src="/images/heungbu.png" alt="흥부놀부">
						<div class="card-title">흥부놀부</div>
					</div>
				</div>
				<div class="slide-card" onclick="goToDetail('/stories/pig.html')">
					<div class="card-inner" style="background-color: #ffe9a7">
						<img src="/images/castle.png" alt="메르헨 동산">
						<div class="card-title">메르헨 동산</div>
					</div>
				</div>
			</div>
		</div>

		<div class="slide-btn-container">
			<button type="button" class="slide left" onclick="slide(-1, event)">
				<i class="fa-solid fa-arrow-left fa-2xl"></i>
			</button>
			<button type="button" class="slide right" onclick="slide(1, event)">
				<i class="fa-solid fa-arrow-right fa-2xl"></i>
			</button>
		</div>

		<div class="footer">
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

	const wrapper = document.getElementById('slideCardWrapper');
	const cardCount = document.querySelectorAll('.slide-card').length;
	const cardsPerPage = 3;
	let currentIndex = 0;

	function slide(direction, event) {
		if (event) event.preventDefault();  // 버튼 기본 동작 방지

		const maxIndex = Math.ceil(cardCount / cardsPerPage) - 1;
		currentIndex += direction;

		if (currentIndex < 0) currentIndex = 0;
		if (currentIndex > maxIndex) currentIndex = maxIndex;

		const offset = currentIndex * 100;
		wrapper.style.transform = `translateX(-${offset}%)`;
	}

	function goToDetail(url) {
		window.location.href = url;
	}
</script>

</body>
</html>