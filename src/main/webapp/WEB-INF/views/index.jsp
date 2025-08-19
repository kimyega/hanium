<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8" />
	<title>Märchand</title>

	<!-- Google Fonts -->
	<link href="https://fonts.googleapis.com/css2?family=Kavoon&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Cute+Font&display=swap" rel="stylesheet">

	<!-- Font Awesome -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />


	<!-- CSS -->
	<link rel="stylesheet" href="/css/table.css" />

	<%-- 모달창 css --%>
	<link rel="stylesheet" href="/css/headerLogout.css" />

	<%-- Jquery --%>
	<script type="text/javascript" src="/js/jquery-3.6.0.min.js"></script>

	<style>
		:root{
			--peach:#fca08c;
			--peach-border:#f59c8b;
			--shadow:0 8px 12px rgba(0,0,0,.10);
		}
		html,body{
			height:100%; margin:0;
			font-family:'Cute Font',sans-serif;
			background:#fff;
			overflow:hidden; /* ✅ 스크롤 제거 */
		}

		/* ===== 메인 Hero ===== */
		.hero-wrap{
			width:100%;
			height:calc(100vh - 80px); /* 헤더 제외한 전체 화면 */
			background:url('/images/start.png') no-repeat center center;
			background-size:cover;      /* ✅ 화면에 꽉 차게 */
			display:flex;
			justify-content:flex-end;   /* 버튼을 아래쪽으로 배치 */
			align-items:center;         /* 가운데 정렬 */
			flex-direction:column;
			position:relative;
		}

		/* 버튼 */
		.btn-box{
			margin-bottom:60px; /* 화면 하단에서 띄우기 */
			display:flex;
			gap:40px;
			justify-content:center;
		}
		.menu-btn{
			padding:16px 40px;
			font-size:28px;
			border-radius:40px;
			border:6px solid var(--peach-border);
			background:#fff;
			cursor:pointer;
			box-shadow:var(--shadow);
			transition:all .2s ease;
		}
		.menu-btn:hover{
			background:#fffaf7;
			transform:translateY(-3px);
			box-shadow:0 14px 20px rgba(0,0,0,.18);
		}

		/* 반응형 */
		@media (max-width: 768px){
			.btn-box{ flex-direction:column; gap:20px; }
			.menu-btn{ width:80%; margin:0 auto; font-size:22px; }
		}
	</style>
</head>
<body>

<!-- ===== 상단바 (table.css 구조 건드리지 않음) ===== -->
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
			<button class="start-button" onclick="location.href='/user/register'" type="button">회원 가입</button>
			<button class="start-button" onclick="location.href='/user/login'" type="button">로그인</button>


		</div>
	</div>
</main>

<%--모달창--%>
<div id="signupModal" class="modal">
	<div class="modal-content">
		<h2>메르헨드</h2>
		<p>로그아웃 완료!!</p>
		<button id="modalLoginBtn">메인 화면으로</button>
	</div>
</div>

<script src="${pageContext.request.contextPath}/js/headerLogout.js"></script>

</body>
</html>
