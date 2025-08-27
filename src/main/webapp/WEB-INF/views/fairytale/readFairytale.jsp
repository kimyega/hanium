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

	<%-- 모달창 css --%>
	<link rel="stylesheet" href="/css/headerLogout.css" />

	<!-- jQuery -->
	<script src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
	<style>
		.card-wrapper { display: none; position: relative; }
		.card-wrapper.active { display: flex; }

		.make-wrapper { position: fixed; right: 60px; bottom: 30px; margin: 0; z-index: 999; }
		.make-wrapper button {
			font-family: 'Cute Font', sans-serif;
			font-size: 35px;
			border-radius: 100px;
			border: 8px solid #fca08c;
			background-color: white;
			cursor: pointer;
			display: flex; align-items: center; justify-content: center;
			width: 200px; height: 80px; padding: 0;
		}
		.make-wrapper button:hover { background-color: #fca08c; color: white; }

		.footer { position: relative; width: 100%; margin: 50px auto 0; display: flex; justify-content: center; align-items: center; }
		#prevBtn, #nextBtn { position: absolute; top: 50%; transform: translateY(-50%); }
		#prevBtn { left: 5px; } #nextBtn { right: 5px; }

		.story-text {
			font-size: 32px; line-height: 1.8; text-align: center;
			white-space: pre-line; word-break: keep-all;
			font-family: 'Cute Font', sans-serif;
		}
		.signWord {
			color: blue !important;
			font-weight: bold !important;
			text-decoration: underline !important;
			cursor: pointer;
		}
	</style>
</head>
<body>

<%@ include file="../includes/header.jsp"%>

<main>
	<div class="top-bar">
		<button class="button top-home-button" onclick="location.href='/user/main'">
			<i class="fa-solid fa-house fa-2xl"></i>
		</button>
		<div class="top-title"><%= story.getTitle() %></div>
		<div style="width: 60px;"></div>
	</div>

	<div class="container">
		<% for (int i = 0; i < pageList.size(); i++) {
			StoryPageDTO p = pageList.get(i);
			String img = (p.getContentImage()!=null && !p.getContentImage().isEmpty()) ? ("/images/" + p.getContentImage()) : "/images/default.png";
			String text = (p.getContentText()!=null) ? p.getContentText() : "";

			if (text != null && !text.isEmpty()) {
				String[] keywords = {"돼지", "굴", "집","늑대","물","벽돌","나무","가족","과자","길","빵","보물"};
				for (String keyword : keywords) {
					text = text.replace(keyword,
							"<span class='signWord' data-word='" + keyword + "'>" + keyword + "</span>");
				}
			}
		%>
		<div class="card-wrapper <%= (i==0) ? "active" : "" %>" data-index="<%= i %>">
			<div class="card card-img">
				<img src="<%= img %>" alt="동화 이미지" onerror="this.src='/images/default.png'"/>
			</div>

			<div class="card text-card">
				<p class="story-text"><%= text %></p>
			</div>

			<div class="card card-dic">
				<div class="card-dic-title">수어 사전</div>
				<div class="card-dic-img">
					<img class="dicImg" src="/images/default.png" alt="수어 이미지" onerror="this.src='/images/default.png'"/>
				</div>
				<p class="dicWord"></p>
			</div>
		</div>
		<% } %>

		<div class="footer">
			<button id="prevBtn" class="button prev"><i class="fa-solid fa-arrow-left fa-2xl"></i></button>
			<div id="pageIndicator" class="page-number">1</div>
			<button id="nextBtn" class="button next"><i class="fa-solid fa-arrow-right fa-2xl"></i></button>
			<div class="make-wrapper">
				<button type="button" class="button make" id="quizBtn" onclick="location.href='/quiz/quizList'">퀴즈</button>
			</div>
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

<script>
	// 단어-이미지 매핑
	const wordImageMap = {
		"돼지": "/images/words/pig.png",
		"집": "/images/words/house.jpg",
		"늑대": "/images/words/wolf.jpg",
		"굴뚝": "/images/words/chimney.jpg",
		"물": "/images/words/water.jpg",
		"벽돌": "/images/words/brick.jpg",
		"나무": "/images/words/tree.jpg",
		"가족": "/images/words/family.jpg",
		"과자": "/images/words/snack.jpg",
		"길": "/images/words/road.jpg",
		"빵": "/images/words/bread.jpg",
		"보물": "/images/words/treasure.jpg"
	};

	// ✅ 단어 클릭 시 해당 카드 안 dicImg/dicWord 갱신
	document.addEventListener("click", function(e) {
		if (e.target.classList.contains("signWord")) {
			const word = e.target.dataset.word;
			const imgPath = wordImageMap[word] || "/images/default.png";

			const currentCard = e.target.closest(".card-wrapper");
			if (currentCard) {
				const dicImg = currentCard.querySelector(".dicImg");
				const dicWord = currentCard.querySelector(".dicWord");
				if (dicImg && dicWord) {
					dicImg.src = imgPath;
					dicWord.textContent = word;
				}
			}
		}
	});

	// 페이지 네비게이션
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
		indicator.textContent = (i+1);
		prevBtn.style.display = (i === 0) ? "none" : "inline-block";
		nextBtn.style.display = (i === total-1) ? "none" : "inline-block";
		quizBtn.style.display = (i === total-1) ? "inline-block" : "none";
	}
	nextBtn.addEventListener('click', () => { if(idx < total-1){ idx++; show(idx); } });
	prevBtn.addEventListener('click', () => { if(idx > 0){ idx--; show(idx); } });
	show(idx);
</script>

<script src="${pageContext.request.contextPath}/js/headerLogout.js"></script>
</body>
</html>
