<%@ page import="kopo.poly.hanium.util.CmmUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String[] words = (String[]) request.getAttribute("words");
	String[] results = (String[]) request.getAttribute("results");
	int score = (request.getAttribute("score") != null) ? (int) request.getAttribute("score") : 0;
	int total = (request.getAttribute("total") != null) ? (int) request.getAttribute("total") : 1; // 나누기 0 방지
	int percentScore = (int) (((double) score / total) * 100);
%>
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

	<%-- 모달창 css --%>
	<link rel="stylesheet" href="/css/headerLogout.css" />

	<%-- Jquery --%>
	<script type="text/javascript" src="/js/jquery-3.6.0.min.js"></script>
	<style>
		.score-text {
			font-size: 130px;
			color: #29B969;
			margin-top: 20px;
		}

		.score-result {
			background-color: #fff;
			padding: 20px;
			flex: none;
			display: flex;
			flex-direction: column;
			align-items: center;
			border: 15px solid #fca08c;
			width: 66.6666%;
			height: 600px;
			font-size: 55px;
			overflow-y: auto;
			max-height: 600px;
		}

		.score-result::-webkit-scrollbar {
			width: 15px;               /* 스크롤바 너비 */
			height: 20px;
		}

		.score-result::-webkit-scrollbar-track {
			background: #ffe5de;       /* 스크롤 트랙 배경 */
			width: 2px;
		}

		.score-result::-webkit-scrollbar-thumb {
			background-color: #fca08c; /* 스크롤바 색상 */
			border-radius: 10px;
			border: 3px solid #ffe5de; /* thumb 테두리 색상 (트랙과 같게 하면 패딩처럼 보임) */
		}

		.score-result div {
			font-size: 100px;
		}

		.result.correct {
			color: #29B969;
		}

		.result.wrong {
			color: #ff3333;
		}

		.make-wrapper-two {
			display: flex;
			justify-content: space-between; /* 버튼을 양쪽 끝으로 정렬 */
			align-items: center;
			margin-top: 10px;
			width: 100%; /* 전체 너비 사용 */
			padding: 0 0; /* 좌우 여백 조절 (원하면 조정 가능) */
			box-sizing: border-box;
		}

		.make-wrapper-two button {
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
			white-space: nowrap;
			writing-mode: horizontal-tb;
			width: 200px;
			height: 80px;
		}

		.make-wrapper-two button:hover {
			background-color: #fca08c;
			color: white;
		}
	</style>
</head>

<body>
<!-- 상단바 -->
<%@ include file="../includes/header.jsp"%>

<form id="f">
	<main>
		<div class="top-bar">
			<a class="button top-home-button" onclick="location.href='/user/main'">
				<i class="fa-solid fa-house fa-2xl"></i>
			</a>
			<div class="top-title">채점 결과</div>
			<div style="width: 60px;"></div>
		</div>

		<div class="container">
			<div class="card-wrapper">
				<div class="card card-img">
					<div class="score-text"><%= percentScore %>점</div>
				</div>
				<div class="score-result">
					<% if (words != null && results != null) {
						for (int i = 0; i < words.length; i++) {
							String word = words[i];
							boolean isCorrect = "true".equals(results[i]);
					%>
					<div>
						<span class="word"><%= word %></span> : <span class="result <%= isCorrect ? "correct" : "wrong" %>"> <%= isCorrect ? "정답" : "오답" %> </span>
					</div>
					<%     }
					}
					%>
				</div>
			</div>
			<div class="make-wrapper-two">
				<button type="button" id="reTryBtn">다시풀기</button>
				<button type="button" class="button make" id="quizSaveBtn">퀴즈목록</button>
			</div>
		</div>
		<input type="hidden" name="nSeq" value="<%= request.getAttribute("quizId") %>">
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

<script>

	document.getElementById('quizSaveBtn').addEventListener('click', function () {
		const form = document.getElementById('f');
		form.action = '/quiz/quizList';
		form.method = 'get';
		form.submit();
	});

	document.getElementById('reTryBtn').addEventListener('click', function () {
		const form = document.getElementById('f');
		form.action = '/quiz/quizInfo';
		form.method = 'get';
		form.submit();
	});

</script>
<script src="${pageContext.request.contextPath}/js/headerLogout.js"></script>
</body>
</html>