<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>퀴즈</title>
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
		.screen-text {
			margin-top: 20px;
		}

		.black-screen {
			width: 100%;
			height: 460px;
			object-fit: cover;
			border-radius: 0;
			margin-top: 20px;
			aspect-ratio: 1 / 1; /* 정사각형 유지 */
			background-color: black;
		}

		fieldset {
			margin-top: 40px;
			border: 5px solid #fca08c;
			border-radius: 10px;
			width: 100%;
			height: 230px;
		}
		legend {
			font-size: 50px;
			font-weight: 305;
		}

		.make-wrapper  button {
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
			white-space: nowrap;         /* 🔥 줄바꿈 방지 */
			writing-mode: horizontal-tb;
			width: 200px;
			height: 80px;
		}
		.make-wrapper button:hover {
			background-color: #fca08c;
			color: white;
		}
		.quiz-container {
			display: flex;
			justify-content: center;
			align-items: center;
			width: 450px;
			height: 600px;
			position: relative;
			border: 5px solid #fca08c;
			border-radius: 10px;
			margin: 0;
			padding: 0;
			background-color: white;
		}
	</style>
</head>

<body>
<header>
	<div class="header-icon-stack">
		<i class="fa-solid fa-book-open book"></i>
		<i class="fa-solid fa-hands-holding hands"></i>
	</div>
	<div class="header-logo" onclick="location.href='/'">Märchand</div>
	<div class="header-user-area">
		<div class="header-user-icon"><i class="fa-solid fa-circle-user fa-xl"></i></div>
		<div class="header-dropdown">
			<button class="header-dropdown-toggle" id="headerDropdownToggle">
				<%
					String uname = (String)session.getAttribute("SS_USER_NAME");
					if (uname == null || uname.trim().isEmpty()) { uname = "메뉴"; }
				%>
				<%= uname %>
				<span>▼</span>
			</button>
			<ul class="header-dropdown-menu" id="headerDropdownMenu">
				<%
					if (uname.equals("메뉴")) {
				%>
				<li onclick="location.href='/user/login'">로그인</li>
				<li onclick="location.href='/user/register'">회원가입</li>
				<%
				} else {
				%>
				<li onclick="location.href='/user/mypage'">내 정보</li>
				<li id="headerDropDownLogout">로그아웃</li>
				<%
					}
				%>
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
			<div class="top-title">단어 퀴즈</div>
			<div style="width: 60px;"></div>
		</div>

		<div class="container">
			<div class="card-wrapper">
				<div class="card card-img">
					<div class="screen-text">카메라에 손 모양을 보여주세요</div>
					<div class="black-screen"></div>
				</div>
				<div class="card text-card">
					<fieldset class="quiz-container">
						<legend>1 / 10</legend>
						<h1>자라</h1>
					</fieldset>
				</div>
				<div class="card card-dic" id="dicCard">
					<div class="card-dic-title-text">정답 확인</div> <!-- 버튼 대신 텍스트 -->
					<div class="card-dic-img">
						<i class="fa-solid fa-question fa-2xl" style="color: #fca08c;"></i>
					</div>
				</div>
			</div>

			<div class="footer">
				<div class="page-number">1</div>
				<button type="button" class="button" id="nextBtn">
					<i class="fa-solid fa-arrow-right fa-2xl"></i>
				</button>
			</div>
		</div>
	</main>
</form>

<%--모달창--%>
<div id="signupModal" class="modal">
	<div class="modal-content">
		<h2>메르헨드</h2>
		<p>로그아웃 완료!!</p>
		<button id="modalLoginBtn">메인 화면으로</button>
	</div>
</div>

<script>

	const dicCard = document.getElementById('dicCard');
	let isImageShown = false;

	dicCard.addEventListener('click', function () {
		if (!isImageShown) {
			dicCard.style.backgroundImage = "url('/images/language.png')"; // 🔁 여기에 원하는 이미지 경로
			dicCard.style.backgroundSize = "cover";
			dicCard.style.backgroundPosition = "center";
			dicCard.innerHTML = ''; // 기존 텍스트/아이콘 제거
			isImageShown = true;
		}
	});

	document.getElementById('nextBtn').addEventListener('click', function () {
		const form = document.getElementById('f');
		form.action = '/contents/quiz2';
		form.method = 'get';
		form.submit();
	});
</script>
<script src="${pageContext.request.contextPath}/js/headerLogout.js"></script>
</body>
</html>