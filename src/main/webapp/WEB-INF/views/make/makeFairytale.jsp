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
		.word-check-text {
			font-size: 60px;
			text-align: center;
		}
		.word-check-container{
			border: 5px solid #fca08c;
			border-radius: 10px;
			display: flex;
			width: 100%;
			height: 350px;
			justify-content: center;
			align-items: center;
		}
		.word-check-content {
			font-size: 100px;
			font-weight: 500;
			width: 100%;
			height: 280px;
			margin-top: 80px;
			text-align: center;
		}
		.word-check-button {
			display: flex;
			justify-content: center;
			align-items: center;
		}
		.re-insert {
			border: 5px solid #fca08c;
			border-radius: 30px;
			font-weight: 500;
			background-color: white;
			width: 100px;
			height: 40px;
			margin-bottom: 0;
		}
		.add-word {
			border: 5px solid #fca08c;
			border-radius: 30px;
			font-weight: 500;
			background-color: white;
			width: 100px;
			height: 40px;
			margin-bottom: 0;
		}
		.btn-text {
			text-align: center;
		}
		.button-container {
			display: flex;
			gap: 20px;
			justify-content: center;
			margin-top: 10px;
		}
		.word-button {
			font-family: 'Cute Font', sans-serif;
			font-size: 35px;
			border: 8px solid #fca08c;
			border-radius: 100px;
			padding: 10px 25px;
			background-color: white;
			cursor: pointer;
			transition: all 0.2s ease;
			width: 200px;
			margin-bottom: 20px;
		}
		.word-button:hover {
			background-color: #fca08c;
			color: white;
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
		.list-content{
			font-size: 40px;
			margin-left: 0px;
			margin-right: 200px;
		}
		.list-main-name {
			margin-top: 80px;
			text-align: center;
			font-size: 50px;
		}
		.list-main-name-insert {
			font-family: 'Cute Font', sans-serif;
			display: block;
			margin: 20px auto;
			width: 200px;
			padding: 8px;
			font-size: 50px;
			text-align: center;
			border: solid 3px #fca08c;
			border-top: 0;
			border-left: 0;
			border-right: 0;
		}

		.make-wrapper {
			display: flex;
			justify-content: flex-end;
			align-items: center;
			margin-top: 10px;
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
	</style>
</head>

<body>
<!-- 상단바 -->
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

<%--모달창--%>
<div id="signupModal" class="modal">
	<div class="modal-content">
		<h2>메르헨드</h2>
		<p>로그아웃 완료!!</p>
		<button id="modalLoginBtn">메인 화면으로</button>
	</div>
</div>

<script>
	document.getElementById('submitBtn').addEventListener('click', function () {
		const form = document.getElementById('f');
		form.action = '/contents/makeResult';
		form.method = 'get';
		form.submit();
	});
</script>
<script src="${pageContext.request.contextPath}/js/headerLogout.js"></script>
</body>
</html>