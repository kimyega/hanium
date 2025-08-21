<%@ page import="kopo.poly.hanium.dto.StoryDTO" %>
<%@ page import="kopo.poly.hanium.dto.StoryPageDTO" %>
<%@ page import="kopo.poly.hanium.service.IStoryService" %>
<%@ page import="java.util.List" %>
<%@ page import="org.springframework.web.context.WebApplicationContext" %>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String storyIdParam = request.getParameter("storyId");
	int storyId = storyIdParam != null ? Integer.parseInt(storyIdParam) : 0;

	WebApplicationContext ctx = WebApplicationContextUtils.getRequiredWebApplicationContext(application);
	IStoryService storyService = (IStoryService) ctx.getBean("storyService");

	StoryDTO story = storyService.getStoryInfo(storyId);
	List<StoryPageDTO> pageList = storyService.getStoryPages(storyId);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title><%= story != null ? story.getTitle() : "동화" %></title>

	<!-- Google Fonts -->
	<link href="https://fonts.googleapis.com/css2?family=Kavoon&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Cute+Font&display=swap" rel="stylesheet">

	<!-- Font Awesome -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

	<!-- 공통 CSS -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/table.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/headerLogout.css" />

	<!-- jQuery -->
	<script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
	<style>
	/* ===== 카드 숨김/보임 ===== */
	.card-wrapper {
	display: none;
	position: relative;   /* ✅ 퀴즈 버튼 위치 기준점 */
	}
	.card-wrapper.active {
	display: flex;
	}

	/* ===== 퀴즈 버튼 ===== */
	.make-wrapper {
		position: fixed;   /* 화면에 고정 */
		right: 60px;       /* 오른쪽 끝에서 30px */
		bottom: 30px;      /* 아래 끝에서 30px */
		margin: 0;
		z-index: 999;      /* 다른 요소보다 위에 보이게 */
	}

	.make-wrapper button {
		font-family: 'Cute Font', sans-serif;
		font-size: 35px;
		border-radius: 100px;
		border: 8px solid #fca08c;
		background-color: white;
		cursor: pointer;

		/* ✅ 글씨 중앙 정렬 */
		display: flex;
		align-items: center;     /* 세로 가운데 */
		justify-content: center; /* 가로 가운데 */

		width: 200px;
		height: 80px;
		padding: 0;              /* 패딩 제거 (중앙 정렬 방해 안 하도록) */
		line-height: normal;     /* ✅ 고정 line-height 대신 normal */
		white-space: nowrap;
	}

	.make-wrapper button:hover {
		background-color: #fca08c;
		color: white;
	}


	/* ===== 하단 네비게이션 ===== */
	.footer {
	position: relative;
	width: 100%;
	max-width: 100%;
	margin: 50px auto 0 auto;
	padding: 0 20px;
	box-sizing: border-box;
	display: flex;
	justify-content: center;
	align-items: center;
	}

	/* 버튼은 table.css의 .button 그대로 사용 */
	#prevBtn, #nextBtn {
	position: absolute;
	top: 50%;
	transform: translateY(-50%);
	}
	#prevBtn { left: 5px; }
	#nextBtn { right: 5px; }
	</style>
</head>
<body>

<!-- ===== 상단바 ===== -->
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

<!-- ===== 본문 ===== -->
<main>
	<div class="top-bar">
		<button class="button top-home-button" onclick="location.href='/'">
			<i class="fa-solid fa-house fa-2xl"></i>
		</button>
		<div class="top-title"><%= story.getTitle() %></div>
		<div style="width: 60px;"></div>
	</div>

	<div class="container">
		<% for (int i = 0; i < pageList.size(); i++) {
			StoryPageDTO p = pageList.get(i);

			String img = (p.getContentImage()!=null && !p.getContentImage().isEmpty())
					? ("/images/" + p.getContentImage())
					: "/images/default.png";

			String text = (p.getContentText()!=null) ? p.getContentText() : "";

			String signImg = null, signWord = null;
			try{
				java.lang.reflect.Method m1 = p.getClass().getMethod("getSignImage");
				java.lang.reflect.Method m2 = p.getClass().getMethod("getSignWord");
				Object si = m1.invoke(p), sw = m2.invoke(p);
				signImg = (si!=null && !si.toString().isEmpty()) ? ("/images/" + si.toString()) : "/images/rabbit.png";
				signWord = (sw!=null && !"null".equalsIgnoreCase(sw.toString()) && !sw.toString().isEmpty())
						? sw.toString()
						: "";

			}catch(Exception ignore){}
		%>
		<div class="card-wrapper <%= (i==0) ? "active" : "" %>" data-index="<%= i %>">
			<div class="card card-img">
				<img
						src="<%= (img != null && !img.equals("")) ? img : "/images/pig.png" %>"
						alt="동화 이미지"
						onerror="this.src='/images/default.png'"/>
			</div>

			<div class="card text-card">
				<%= (text != null) ? text : "" %>
			</div>

			<div class="card card-dic">
				<div class="card-dic-title">수어 사전</div>
				<div class="card-dic-img">
					<img
							src="<%= (signImg != null && !signImg.equals("")) ? signImg : "/images/language.png" %>"
							alt="수어 이미지"
							onerror="this.src='/images/language.png'"/>
				</div>
				<!-- ✅ signWord가 '수어 사전'일 때는 출력 안 함 -->
				<p><%= (signWord != null && !signWord.equals("수어 사전")) ? signWord : "" %></p>
			</div>

		</div>
		<% } %>

		<!-- 하단 네비 -->
		<!-- 하단 네비 -->
		<div class="footer">
			<!-- 이전 버튼 -->
			<button id="prevBtn" class="button prev">
				<i class="fa-solid fa-arrow-left fa-2xl"></i>
			</button>

			<!-- 페이지 넘버 -->
			<div id="pageIndicator" class="page-number">1</div>

			<!-- 다음 버튼 -->
			<button id="nextBtn" class="button next">
				<i class="fa-solid fa-arrow-right fa-2xl"></i>
			</button>

			<!-- 퀴즈 버튼 -->
			<div class="make-wrapper">
				<button type="button" class="button make" id="quizBtn">퀴즈</button>
			</div>
		</div>

	</div>
</main>

<!-- ✅ 모달 -->
<div id="signupModal" class="modal">
	<div class="modal-content">
		<h2>메르헨드</h2>
		<p>로그아웃 완료!!</p>
		<button id="modalLoginBtn" class="modal-btn">메인 화면으로</button>
	</div>
</div>

<script>
	const pages = Array.from(document.querySelectorAll('.card-wrapper'));
	const total = pages.length;
	const indicator = document.getElementById('pageIndicator');
	const nextBtn = document.getElementById('nextBtn');
	const prevBtn = document.getElementById('prevBtn');
	const quizBtn = document.getElementById('quizBtn');
	let idx = 0;

	function show(i){
		pages.forEach(p => p.classList.remove('active'));
		pages[i].classList.add('active');

		// ✅ 페이지 번호 업데이트 (형식: 현재페이지)
		indicator.textContent = (i+1);

		// ✅ 첫 화면에서는 이전 버튼 숨김
		if(i === 0){
			prevBtn.style.display = "none";
		} else {
			prevBtn.style.display = "inline-block";
		}

		// ✅ 마지막 화면에서는 퀴즈 버튼 표시
		if(i === total-1){
			nextBtn.style.display = "none";
			quizBtn.style.display = "inline-block";
		} else {
			nextBtn.style.display = "inline-block";
			quizBtn.style.display = "none";
		}
	}

	nextBtn.addEventListener('click', () => {
		if(idx < total-1){ idx++; show(idx); }
	});
	prevBtn.addEventListener('click', () => {
		if(idx > 0){ idx--; show(idx); }
	});

	// 초기화
	show(idx);

</script>

<!-- ✅ 공통 드롭다운/로그아웃 JS -->
<script src="${pageContext.request.contextPath}/js/headerLogout.js"></script>

</body>
</html>
