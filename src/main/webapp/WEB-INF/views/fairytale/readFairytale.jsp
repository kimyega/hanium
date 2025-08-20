<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>별주부전</title>
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

<main>
	<div class="top-bar">
		<button class="button top-home-button" onclick="location.href='/home.html'">
			<i class="fa-solid fa-house fa-2xl"></i>
		</button>
		<div class="top-title">별주부전</div>
		<div style="width: 60px;"></div>
	</div>

	<div class="container">
		<div class="card-wrapper">
			<div class="card card-img">
				<img src="/images/turtle.png" alt="동화 이미지">
			</div>
			<div class="card text-card">
				<p>
					옛날 옛날에 용궁에 용왕님이 살고 있었는데,
					어느날 용왕님이 죽을병에 걸리고 말았어요.
				</p>
				<p>
					용왕님의 <span class="highlight underline">병</span>을 고치려면 <span class="highlight underline">토끼</span>의 간이 필요해요
				</p>
			</div>
			<div class="card card-dic">
				<div class="card-dic-title">수어 사전</div>
				<div class="card-dic-img">
					<img src="/images/language.png" alt="수어 이미지">
				</div>
				<p>토끼</p>
			</div>
		</div>

		<div class="footer">
			<div class="page-number">1</div>
			<button class="button" onclick="location.href='/next-page.html'">
				<i class="fa-solid fa-arrow-right fa-2xl"></i>
			</button>
		</div>
	</div>
</main>

<%--모달창--%>
<div id="signupModal" class="modal">
	<div class="modal-content">
		<h2>메르헨드</h2>
		<p>로그아웃 완료!!</p>
		<button id="modalLoginBtn" class="modal-btn">메인 화면으로</button>
	</div>
</div>

<script src="${pageContext.request.contextPath}/js/headerLogout.js"></script>
</body>
</html>