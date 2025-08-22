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
			width: 500px;
			height: 230px;
			display: flex;
			flex-direction: column;
		}
		legend {
			font-size: 50px;
			font-weight: 305;
		}
		.list-content {
			flex: 1;
			font-size: 40px;
			width: 100%;
			height: 230px;
			overflow-y: auto;
			overflow-x: hidden;
			word-wrap: break-word;  /* 긴 단어 줄바꿈 */
			white-space: pre-wrap;  /* 줄바꿈 유지 */
		}
		.list-main-name {
			margin-top: 30px;
			text-align: center;
			font-size: 50px;
		}
		.list-main-name-insert {
			font-family: 'Cute Font', sans-serif;
			display: block;
			margin: 20px auto;
			width: 200px;
			font-size: 50px;
			text-align: center;
			border: 0 solid #fca08c;
			border-bottom-width: 3px;
			outline: none;
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



		/* 추가로 넣는 코드 캠 X */
		.card-dic fieldset legend {
			font-size: 50px;
			font-weight: bold;
		}

		/* 삭제 버튼 */
		#removeWordBtn {
			float: right;            /* 오른쪽 정렬 */
			cursor: pointer;
			transition: all 0.2s ease;
		}

		#removeWordBtn:active {
			transform: translateY(2px); /* 눌리는 효과 */
			box-shadow: 1px 1px 2px rgba(0,0,0,0.2); /* 그림자 줄이기 */
		}

		/*로딩 모달*/
		.modal-loading-res {
			display: none;
			position: fixed;
			z-index: 9999;
			left: 0; top: 0;
			width: 100%; height: 100%;
			background: rgba(0,0,0,0.5);
		}

		.modal-loading-con {
			background: white;
			border-radius: 15px;
			padding: 30px;
			text-align: center;
			width: 500px;
			margin: 200px auto;
			font-family: 'Cute Font', sans-serif;
			font-size: 30px;
			border: 8px solid #f9b59e;
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
			<div class="top-title">동화 만들기</div>
			<div style="width: 60px;"></div>
		</div>

		<div class="container">
			<div class="card-wrapper">
				<!-- 카메라 -->
				<div class="card card-img">
					<div class="screen-text">카메라에 손 모양을 보여주세요</div>
					<video class="black-screen" id="video" autoplay muted playsinline></video>
				</div>

				<!-- 단어 확인 -->
				<div class="card text-card">
					<div class="word-check-text">이 단어가 맞나요?</div>
					<div class="word-check-container">
						<div class="word-check-content"></div>
					</div>
					<div class="button-container">
						<input type="button" class="word-button" value="다시 입력">
						<input type="button" class="word-button" value="단어 추가">
					</div>
				</div>

				<!-- 단어 리스트 -->
				<div class="card card-dic">
					<div>
						<button type="button" id="removeWordBtn" class="button">
							<i class="fa-solid fa-arrow-right fa-rotate-180 fa-2xl"></i>
						</button>
						<fieldset>
							<legend><span id="legendCount">0 / 10</span></legend>
							<div class="list-content"></div>
						</fieldset>
						<div class="list-main-name"><label for="listMainName">주인공 이름</label></div>
						<input type="text" id="listMainName" class="list-main-name-insert" name="mainName">
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

<!-- 로딩 모달 -->
<div id="loadingModal" class="modal-loading-res">
	<div class="modal-loading-con">
		<h2>동화 생성 중...</h2>
		<p>잠시만 기다려주세요</p>
		<i class="fa-solid fa-spinner fa-spin" style="font-size: 60px; margin-top: 20px;"></i>
	</div>
</div>

<%--실시간 캠 관련 javascript--%>
<script>
	const video = document.getElementById('video');
	const wordContent = document.querySelector(".word-check-content");
	const addBtn = document.querySelector(".word-button[value='단어 추가']");
	const resetBtn = document.querySelector(".word-button[value='다시 입력']");
	const listContent = document.querySelector(".list-content");
	const legend = document.getElementById("legendCount");

	let detector;
	let currentWord = "";
	let wordList = [];
	let maxWords = 10;
	let greenStartTime = null;
	let modalShown = false;
	let lastLeft = null, lastRight = null;

	// 🔥 랜덤 단어 풀
	let testWords = ["공주", "왕자", "마녀", "구두", "성", "모험", "마법", "동화", "용", "숲"];

	// 랜덤 단어 뽑기 함수
	function getRandomWord() {
		if (testWords.length === 0) {
			return null; // 모든 단어를 다 뽑았으면 null 반환
		}
		const index = Math.floor(Math.random() * testWords.length);
		const word = testWords[index];
		// 뽑은 단어를 배열에서 제거
		testWords.splice(index, 1);
		return word;
	}

	// Pose 모델 초기화
	async function initPoseModel() {
		await tf.ready();
		detector = await poseDetection.createDetector(
				poseDetection.SupportedModels.MoveNet,
				{ modelType: poseDetection.movenet.modelType.SINGLEPOSE_LIGHTNING }
		);
		console.log("MoveNet 모델 로드 완료");
	}

	// 캠 연결
	navigator.mediaDevices.getUserMedia({ video: true, audio: false }) // 미디어 장치(예: 카메라, 마이크)에 액세스할 수 있는 미디어 스트림을 반환하는 스트림
			.then(function (stream) {
				video.srcObject = stream; // HTML <video> 요소의 srcObject 속성에 할당함으로써, 사용자의 웹캠으로 부터 비디오를 보여주는 작업
			});

	const screen = video; // 테두리 변경 대상

	// 자세 추정 함수
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

				isHandMoving = (deltaLX + deltaLY + deltaRX + deltaRY) > 30;
			}

			lastLeft = lw;
			lastRight = rw;

			if (isHandUp || isHandMoving) {
				video.style.border = "8px solid #00cc66";

				if (!greenStartTime) greenStartTime = Date.now();

				if (!modalShown && Date.now() - greenStartTime >= 1500) {
					modalShown = true;

					// 🔥 랜덤 단어 표시
					currentWord = getRandomWord();
					wordContent.innerText = currentWord;
				}
			} else {
				video.style.border = "8px solid #ff3333";
				greenStartTime = null;
			}
		}

		requestAnimationFrame(detectPose);
	}

	// 다시 입력 버튼
	resetBtn.addEventListener("click", () => {
		wordContent.innerText = "";
		currentWord = "";

		modalShown = false;
		greenStartTime = null;
	});

	// 단어 추가 버튼
	addBtn.addEventListener("click", () => {
		if (currentWord && wordList.length < maxWords) {
			wordList.push(currentWord);

			console.log(wordList.length);
			console.log(`${wordList.length} / ${maxWords}`);
			listContent.innerText = wordList.join(", ");
			$('#legendCount').text(wordList.length + ' / ' + maxWords);

			wordContent.innerText = "";
			currentWord = "";

			modalShown = false;
			greenStartTime = null;
		}
	});

	// 시작
	window.onload = async () => {
		await initPoseModel();
		detectPose();
	};

	// 삭제 버튼
	const removeBtn = document.getElementById("removeWordBtn");

	removeBtn.addEventListener("click", () => {
		if (wordList.length > 0) {
			wordList.pop();  // 마지막 단어 제거
			listContent.innerText = wordList.join(", "); // 화면 갱신
			$('#legendCount').text(wordList.length + ' / ' + maxWords);
		}
	});

</script>
<script>
	$('#submitBtn').click(function(e) {
		e.preventDefault(); // 기본 제출 막기

		const form = $('#f');
		const listContentDiv = document.querySelector(".list-content");
		const words = listContentDiv.innerText.split(", ").filter(w => w);

		// 기존 hidden input 제거
		form.find('input[name="words"]').remove();

		// 단어마다 hidden input 추가
		words.forEach(word => {
			form.append('<input type="hidden" name="words" value="' + word + '">');
		});

		// 🔥 로딩 모달 표시
		$('#loadingModal').show();

		// serialize()로 form 데이터 전송
		$.ajax({
			url: '/make/makeFairytaleRequest',
			type: 'POST',
			data: form.serialize(),
			success: function(url) {
				// 서버에서 결과 반환 후 JSP 페이지로 이동
				// DTO 데이터를 session이나 model에 담아서 이동 가능
				window.location.href = url;
			},
			error: function(err) {
				console.error(err);
				$('#loadingModal').hide(); // 오류 시 로딩 숨기기
			}
		});
	});
</script>
<script src="${pageContext.request.contextPath}/js/headerLogout.js"></script>
</body>
</html>