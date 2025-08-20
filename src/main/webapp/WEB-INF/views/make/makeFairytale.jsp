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
					<video class="black-screen" id="video" autoplay muted playsinline></video>
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