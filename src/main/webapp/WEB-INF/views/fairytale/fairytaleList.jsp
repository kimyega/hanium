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

	<%-- 모달창 css --%>
	<link rel="stylesheet" href="/css/headerLogout.css" />

	<%-- Jquery --%>
	<script type="text/javascript" src="/js/jquery-3.6.0.min.js"></script>
	<style>
		.top-search {
			position: relative;
			width: 800px;
			height: 70px;
			border: 8px solid #fca08c;
			border-radius: 50px;
			background-color: white;
			box-shadow: 0 3px 10px rgba(0, 0, 0, 0.05);
			display: flex;
			align-items: center;
			justify-content: center;
		}

		.top-search i {
			position: absolute;
			left: 30px;
			font-size: 20px;
			z-index: 2;
			cursor: pointer;
		}

		.search-bar {
			width: 100%;
			height: 100%;
			padding: 0 20px 0 80px; /* 왼쪽 여백 확보 (아이콘 공간) */
			border: none;
			outline: none;
			font-size: 24px;
			border-radius: 50px;
			background-color: transparent;
			font-family: 'Cute Font', sans-serif;
			box-sizing: border-box;
		}

		.slide-container {
			width: 100%;
			max-width: 1200px;
			margin: 50px auto;
			overflow: hidden;
			position: relative;
		}

		.slide-card-wrapper {
			margin-top: 50px;
			display: flex;
			transition: transform 0.5s ease-in-out;
		}

		.slide-card {
			min-width: 33.33%;
			padding: 20px;
			box-sizing: border-box;
		}

		.card-inner {
			border-top-left-radius: 12px;
			border-top-right-radius: 50px;
			border-bottom-left-radius: 12px;
			border-bottom-right-radius: 12px;
			overflow: hidden;
			box-shadow: 0 4px 8px rgba(0,0,0,0.2);
			background-color: white;
			text-align: center;
			transition: transform 0.3s ease, box-shadow 0.3s ease;
		}

		.card-inner img {
			border-top-left-radius: 12px;
			border-top-right-radius: 50px;
			border-bottom-left-radius: 12px;
			border-bottom-right-radius: 12px;
			width: auto;
			max-width: calc(100% - 60px);
			height: 320px;
			object-fit: contain;
			display: block;
			margin: 30px auto;
		}

		.card-title {
			background: white;
			padding: 10px;
			font-size: 24px;
			border-top: 2px solid #fca08c;
			display: flex;
			justify-content: center; /* 가운데 정렬 */
			align-items: center;
			position: relative;
		}

		.slide-btn-container {
			position: absolute;
			top: 50%;
			left: 0;
			right: 0;
			transform: translateY(-50%);
			display: flex;
			justify-content: space-between;
			padding: 0 20px;
			pointer-events: none;
		}

		.slide-btn-container .slide {
			border: 8px solid #fca08c;
			border-radius: 50%;
			width: 65px;
			height: 65px;
			background-color: white;
			cursor: pointer;
			align-items: center;
			justify-content: center;
			pointer-events: auto;
		}

		.slide-card:hover .card-inner {
			transform: scale(1.05); /* 살짝 커짐 */
			box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3); /* 더 강한 그림자 */
			z-index: 1; /* 주변 카드 위에 보이도록 */
		}

		.slide:hover {
			background-color: #fca08c;
			color: white;
		}

		.slide.right {
			right: 30px;
		}

		.slide.left {
			left: 30px;
		}

		.slide-card {
			cursor: pointer;
		}
	</style>
</head>

<body>
<!-- 상단바 -->
<%@ include file="../includes/header.jsp"%>

<form id="f">
	<main>
		<div class="top-bar">
			<button class="button top-home-button" onclick="location.href='/home.html'">
				<i class="fa-solid fa-house fa-2xl"></i>
			</button>
			<div class="top-search">
				<i class="fa-solid fa-magnifying-glass fa-sm search-icon" onclick="focusInput()"></i>
				<input id="searchInput" class="search-bar" type="text" placeholder="동화를 검색해보세요..." />
			</div>
			<div style="width: 60px;"></div>
		</div>

		<hr style="color: #fca08c; border: 2px solid;">

		<div class="slide-container">
			<div class="slide-card-wrapper" id="slideCardWrapper">
				<div class="slide-card" onclick="goToDetail('/contents/readFairytale?storyId=1')">
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

<%--모달창--%>
<div id="signupModal" class="modal">
	<div class="modal-content">
		<h2>메르헨드</h2>
		<p>로그아웃 완료!!</p>
		<button id="modalLoginBtn" class="modal-btn">메인 화면으로</button>
	</div>
</div>

<script src="${pageContext.request.contextPath}/js/listSlide.js"></script>

<script>

	function goToDetail(url) {
		window.location.href = url;
	}

	function focusInput() {
		document.getElementById('searchInput').focus();
	}

</script>

<script src="${pageContext.request.contextPath}/js/headerLogout.js"></script>

</body>
</html>