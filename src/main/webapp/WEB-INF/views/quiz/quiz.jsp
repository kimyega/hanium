<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="kopo.poly.hanium.dto.SignWordsDTO" %>
<%
	List<SignWordsDTO> rList = (List<SignWordsDTO>) request.getAttribute("rList");
%>
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

	<%-- 모션인식을 위한 tensorflow --%>
	<script src="https://cdn.jsdelivr.net/npm/@tensorflow/tfjs@4.2.0/dist/tf.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/@tensorflow-models/pose-detection"></script>
	<script src="https://cdn.jsdelivr.net/npm/@mediapipe/pose"></script>

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

		#saveBtnWrapper {
			display: none;
			position: absolute;
			left: 94.5%;
			transform: translateX(-50%);
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

		/*///////////  정답/오답 모달 디자인 /////////*/
		.modal-res {
			display: none;
			position: fixed;
			z-index: 9999;
			left: 0; top: 0;
			width: 100%; height: 100%;
			background: rgba(0,0,0,0.5);
		}

		.modal-con {
			background: white;
			border-radius: 15px;
			padding: 30px;
			text-align: center;
			width: 700px;
			margin: 200px auto;
			font-family: 'Cute Font', sans-serif;
			font-size: 30px;
			border: 8px solid #f9b59e;
		}

		/* 제목 */
		.modal-con h2 {
			font-size: 56px;  /* 제목 좀 더 크게 */
			margin-bottom: 15px;
		}

		/* 내용 */
		.modal-con p {
			font-size: 40px;  /* 요청하신 대로 40px */
			margin-bottom: 25px;
		}

		#answerSymbol {
			font-size: 150px;
			font-weight: bold;
			margin-top: 20px;
		}

		/*버튼 디자인*/
		.footer-two {
			display: flex;
			justify-content: space-between;  /* 양 끝 정렬 */
			align-items: center;
			margin-top: 40px;
			position: relative;
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
			<a class="button top-home-button" onclick="location.href='/home.html'">
				<i class="fa-solid fa-house fa-2xl"></i>
			</a>
			<div class="top-title">단어 퀴즈</div>
			<div style="width: 60px;"></div>
		</div>

		<div class="container">
			<div class="card-wrapper">
				<div class="card card-img">
					<div class="screen-text">카메라에 손 모양을 보여주세요</div>
					<video class="black-screen" id="video" autoplay muted playsinline></video>
				</div>
				<div class="card text-card">
					<fieldset class="quiz-container">
						<legend class="lengend-score">1 / 10</legend>
						<h1>자라</h1>
					</fieldset>
				</div>
				<div class="card card-dic" id="dicCard">
					<div class="card-dic-title-text">정답</div> <!-- 버튼 대신 텍스트 -->
					<div class="card-dic-img" id="cardDicImg">
						<i class="fa-solid fa-question fa-2xl" style="color: #fca08c;"></i>
					</div>
				</div>
			</div>

			<div class="footer-two">
				<button type="button" class="button" id="prevBtn">
					<i class="fa-solid fa-arrow-left fa-2xl"></i>
				</button>
				<div class="page-number">1</div>
				<button type="button" class="button" id="nextBtn">
					<i class="fa-solid fa-arrow-right fa-2xl"></i>
				</button>
				<div class="make-wrapper" style="display: none" id="saveBtnWrapper">
					<button type="button" class="button make" id="quizResultBtn">퀴즈결과</button>
				</div>
			</div>
		</div>
	</main>
	<input type="hidden" name="quizId" value="<%= request.getParameter("nSeq") %>" />
</form>

<%--모달창--%>
<div id="signupModal" class="modal">
	<div class="modal-content">
		<h2>메르헨드</h2>
		<p>로그아웃 완료!!</p>
		<button id="modalLoginBtn" class="modal-btn">메인 화면으로</button>
	</div>
</div>

<!-- 정답/오답 모달 -->
<div id="answerModal" class="modal-res" style="display:none;">
	<div class="modal-con">
		<h2>메르헨드</h2>
		<p id="answerMessage">정답!</p>
		<div id="answerSymbol"></div>
	</div>
</div>

<%--실시간 캠 관련 javascript--%>
<script>
	const video = document.getElementById('video'); //html코드에서 id 부분 스크립트 코드에서 다루기위해 변수엠 담음
	navigator.mediaDevices.getUserMedia({ video: true, audio: false }) // 미디어 장치(예: 카메라, 마이크)에 액세스할 수 있는 미디어 스트림을 반환하는 스트림
			.then(function (stream) {
				video.srcObject = stream; // HTML <video> 요소의 srcObject 속성에 할당함으로써, 사용자의 웹캠으로 부터 비디오를 보여주는 작업
			});

	const screen = video; // 테두리 변경 대상

	let detector;

	// Pose 모델 초기화 함수
	async function initPoseModel() {
		await tf.ready();
		detector = await poseDetection.createDetector(
				poseDetection.SupportedModels.MoveNet,
				{ modelType: poseDetection.movenet.modelType.SINGLEPOSE_LIGHTNING }
		);
		console.log("MoveNet 모델 로드 완료");
		console.log(poseDetection.movenet.modelType);
	}

	// 자세 추정 함수
	let greenStartTime = null;
	let modalShown = false;

	let lastLeft = null, lastRight = null; // 이전 손 위치 저장

	async function detectPose() {
		if (!detector || video.readyState < 2) {
			requestAnimationFrame(detectPose);
			return;
		}

		const poses = await detector.estimatePoses(video);
		if (poses.length > 0) {
			const kp = poses[0].keypoints;
			const lw = kp.find(k => k.name === 'left_wrist');
			const rw = kp.find(k => k.name === 'right_wrist');

			let isHandUp = lw?.score > 0.5 && rw?.score > 0.5 && lw.y < 750 && rw.y < 750;
			let isHandMoving = false;

			if (lastLeft && lastRight && lw && rw) {
				const deltaLX = Math.abs(lw.x - lastLeft.x);
				const deltaLY = Math.abs(lw.y - lastLeft.y);
				const deltaRX = Math.abs(rw.x - lastRight.x);
				const deltaRY = Math.abs(rw.y - lastRight.y);

				// 움직임 감지 기준 (픽셀 단위, 필요 시 조정)
				isHandMoving = (deltaLX + deltaLY + deltaRX + deltaRY) > 30;
			}

			// 현재 손 위치 저장 (다음 프레임 비교용)
			lastLeft = lw;
			lastRight = rw;

			// 조건 : 손을 올렸거나 + 손이 움직였을 때
			if (isHandUp || isHandMoving) {
				screen.style.border = "8px solid #00cc66";

				if (!greenStartTime) {
					greenStartTime = Date.now();
				}

				if (!modalShown && Date.now() - greenStartTime >= 1500) {
					modalShown = true;

					const isCorrect = Math.random() < 0.8;
					quizResults[currentIndex] = isCorrect;
					const modal = document.getElementById("answerModal");
					const msg = document.getElementById("answerMessage");
					const symbol = document.getElementById("answerSymbol");

					if (isCorrect) {
						msg.innerText = "정답!";
						msg.style.color = "#00cc66";
						symbol.innerText = "◯";            // ✅ O 출력
						symbol.style.color = "#00cc66";
					} else {
						msg.innerText = "오답!";
						msg.style.color = "#ff3333";
						symbol.innerText = "✕";            // ✅ X 출력
						symbol.style.color = "#ff3333";
					}

					modal.style.display = "block";

					setTimeout(() => {
						modal.style.display = "none";

						// ✅ 모달 닫힌 후 카드 이미지 변경
						const dicCard = document.getElementById("dicCard"); // 카드 DOM 요소 가져오기
						const icon = document.getElementById("cardDicImg");
						if (dicCard) {
							dicCard.style.backgroundImage = "url('/images/language.png')";
							dicCard.style.backgroundSize = "cover";
							dicCard.style.backgroundPosition = "center";
							icon.remove(); // 기존 텍스트/아이콘 제거
							isImageShown = true;
						}
					}, 2000);
				}

			} else {
				screen.style.border = "8px solid #ff3333";
				greenStartTime = null;
			}
		}

		requestAnimationFrame(detectPose);
	}

	// 페이지 로드 시 Pose 모델 초기화 및 추정 시작
	window.onload = async () => {
		await initPoseModel();
		detectPose();
	};
</script>

<%--퀴즈 단어 변경--%>
<script>
	// -------------------- 퀴즈 문제 데이터 --------------------
	const quizWords = [
		<%
            for (int i = 0; i < rList.size(); i++) {
                String word = rList.get(i).getWord();
        %>
		"<%= word %>"<%= (i < rList.size() - 1) ? "," : "" %>
		<%
            }
        %>
	];
	// 각 단어의 결과 저장 (true = 정답, false = 오답)
	let quizResults = new Array(quizWords.length).fill(null);
	let currentIndex = 0;

	const prevBtn = document.getElementById("prevBtn");
	const nextBtn = document.getElementById("nextBtn");

	// -------------------- 페이지 업데이트 함수 --------------------
	function updateQuizPage() {
		// 문제 텍스트
		document.querySelector(".quiz-container h1").innerText = quizWords[currentIndex];

		console.log(currentIndex);
		console.log(quizWords.length);

		// legend: 1 / 10 형식
		document.querySelector(".lengend-score").innerText = currentIndex + 1 + "/" + quizWords.length;

		// footer 페이지 번호
		document.querySelector(".page-number").innerText = currentIndex + 1;

		// 정답 카드 초기화
		const dicCard = document.getElementById("dicCard");
		dicCard.style.backgroundImage = "none";
		dicCard.innerHTML = `
            <div class="card-dic-title-text">정답</div>
            <div class="card-dic-img" id="cardDicImg">
                <i class="fa-solid fa-question fa-2xl" style="color: #fca08c;"></i>
            </div>
        `;

		// 모션인식 리셋
		modalShown = false;
		greenStartTime = null;
		isImageShown = false;

		// 버튼 제어
		prevBtn.style.visibility = (currentIndex === 0) ? "hidden" : "visible";
		nextBtn.style.visibility = (currentIndex === quizWords.length - 1) ? "hidden" : "visible";
		prevBtn.style.pointerEvents = (currentIndex === 0) ? "none" : "auto";
		nextBtn.style.pointerEvents = (currentIndex === quizWords.length - 1) ? "none" : "auto";

		// 마지막 페이지일 때 저장 버튼 보이기
		const saveWrapper = document.getElementById("saveBtnWrapper");
		if (currentIndex === quizWords.length - 1) {
			saveWrapper.style.display = "flex"; // flex로 하면 가운데 정렬 가능
		} else {
			saveWrapper.style.display = "none";
		}
	}

	// -------------------- 버튼 이벤트 --------------------
	nextBtn.addEventListener("click", () => {
		if (currentIndex < quizWords.length - 1) {
			currentIndex++;
			updateQuizPage();
		}
	});

	prevBtn.addEventListener("click", () => {
		if (currentIndex > 0) {
			currentIndex--;
			updateQuizPage();
		}
	});

	// 초기화
	updateQuizPage();
</script>

<script>

	document.getElementById('quizResultBtn').addEventListener('click', function () {
		const form = document.getElementById('f');
		form.action = '/quiz/quizResult';
		form.method = 'post';

		// 기존 hidden input 제거
		document.querySelectorAll('.quiz-hidden-input').forEach(e => e.remove());

		// 단어와 결과를 함께 전송
		quizWords.forEach((word, index) => {
			const result = quizResults[index];

			// 단어
			const wordInput = document.createElement("input");
			wordInput.type = "hidden";
			wordInput.name = "words";
			wordInput.value = word;
			wordInput.classList.add("quiz-hidden-input");
			form.appendChild(wordInput);

			// 결과
			const resultInput = document.createElement("input");
			resultInput.type = "hidden";
			resultInput.name = "results";
			resultInput.value = result;
			resultInput.classList.add("quiz-hidden-input");
			form.appendChild(resultInput);
		});

		form.submit();
	});

</script>

<script src="${pageContext.request.contextPath}/js/headerLogout.js"></script>
</body>
</html>