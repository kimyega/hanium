<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8" />
	<title>Märchand</title>

	<!-- 공통 폰트/아이콘/스타일 -->
	<link href="https://fonts.googleapis.com/css2?family=Kavoon&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Cute+Font&display=swap" rel="stylesheet">

	<!-- Font Awesome -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

	<!-- CSS -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
	<link rel="stylesheet" href="/css/table.css" />

	<style>
		:root{
			--peach:#fca08c;
			--peach-border:#f59c8b;
			--shadow:0 8px 12px rgba(0,0,0,.10);
		}
		html,body{height:100%; margin:0; font-family:'Cute Font',sans-serif;}

		/* ===== 메인 Hero ===== */
		.hero-wrap{
			position:relative;
			height:calc(100vh - 72px); /* 상단바 높이에 맞춰 필요시 조정 */
			min-height:640px;
			overflow:hidden;
			isolation:isolate;
		}
		/* 전체 배경 이미지 */
		.hero-bg{
			position:absolute; inset:0;
			background: url('/images/index.png') center center / cover no-repeat; /* 이미지 경로만 맞춰주세요 */
			z-index:0;
			transform:scale(1.02); /* 가장자리 빈틈 방지용 살짝 확대 */
		}
		/* 가독성 오버레이 (좌측 밝게) */
		.hero-overlay{
			position:absolute; inset:0; z-index:1;
			background:linear-gradient(90deg, rgba(255,255,255,.85) 0%, rgba(255,255,255,.55) 35%, rgba(255,255,255,.15) 70%, rgba(255,255,255,0) 100%);
		}

		/* 왼쪽 버튼 스택 */
		.menu-stack{
			position:relative; z-index:2;
			height:100%; display:flex; align-items:center;
			padding-left:48px;
		}
		.menu-col{ display:flex; flex-direction:column; gap:44px; }
		.menu-btn{
			display:flex; align-items:center; justify-content:center;
			width:340px; height:118px; border-radius:60px;
			border:6px solid var(--peach-border); background:#fff;
			font-size:38px; cursor:pointer; box-shadow:var(--shadow);
			transition:transform .1s ease, box-shadow .2s ease, background .2s ease;
		}
		.menu-btn:hover{ transform:translateY(-2px); box-shadow:0 12px 18px rgba(0,0,0,.16); background:#fffdfb; }
		.menu-btn i{ margin-right:14px; }

		/* 반응형 */
		@media (max-width: 960px){
			.hero-wrap{ height:auto; min-height:100vh; }
			.hero-overlay{ background:rgba(255,255,255,.78); }
			.menu-stack{ justify-content:center; padding:40px 20px; }
			.menu-btn{ width:min(88vw, 360px); }
		}
	</style>
</head>
<body>

<!-- ===== 상단바 (table.css 구조 사용) ===== -->
<header>
	<div class="header-icon-stack">
		<i class="fa-solid fa-book-open book"></i>
		<i class="fa-solid fa-hands-holding hands"></i>
	</div>
	<div class="header-logo" onclick="location.href='/'">Märchand</div>
	<div class="header-user-area">
		<div class="header-user-icon"><i class="fa-solid fa-circle-user fa-2xl"></i></div>
		<div class="header-dropdown">
			<button class="header-dropdown-toggle" id="headerDropdownToggle">
				<%
					String uname = (String)session.getAttribute("SS_USER_NAME");
					if (uname == null || uname.trim().isEmpty()) { uname = "메뉴"; }
				%>
				<%= uname %> ▼
			</button>
			<ul class="header-dropdown-menu" id="headerDropdownMenu">
				<li onclick="location.href='/user/mypage'">내 정보</li>
				<li onclick="location.href='/user/login'">로그인</li>
				<li onclick="location.href='/user/register'">회원가입</li>
				<li onclick="location.href='/'">로그아웃</li>
			</ul>
		</div>
	</div>
</header>

<!-- ===== 메인 ===== -->
<main>
	<div class="start-container">
		<img src="/images/start.png" alt="동물 그림" class="start-image" />
		<div class="start-buttons">
			<!-- ✅ 회원가입 / 로그인 버튼 경로 수정 -->
			<!-- index.jsp 내 최종 수정 -->
			<button class="start-button" onclick="location.href='/user/register'" type="button">회원 가입</button>
			<button class="start-button" onclick="location.href='/user/login'" type="button">로그인</button>


	<section class="hero-wrap">
		<div class="hero-bg"></div>
		<div class="hero-overlay"></div>

		<div class="menu-stack">
			<div class="menu-col">
				<!-- 왼쪽 3버튼 -->
				<!-- 왼쪽 3버튼 -->
				<button class="menu-btn" onclick="location.href='/contents/fairytaleList'">
					<i class="fa-solid fa-book-open-reader"></i> 동화 읽기
				</button>
				<button class="menu-btn" onclick="location.href='/contents/makeFairytale'">
					<i class="fa-solid fa-wand-magic-sparkles"></i> 동화 만들기
				</button>
				<button class="menu-btn" onclick="location.href='/contents/quizList'">
					<i class="fa-solid fa-spell-check"></i> 단어 퀴즈
				</button>

			</div>
		</div>
	</section>
</main>

<script>
	// 간단 드롭다운 (table.js 쓰면 생략 가능)
	const toggle = document.getElementById('headerDropdownToggle');
	const menu = document.getElementById('headerDropdownMenu');
	if (toggle && menu){
		toggle.addEventListener('click', e => {
			e.stopPropagation();
			menu.style.display = (menu.style.display === 'block') ? 'none' : 'block';
		});
		document.addEventListener('click', () => menu.style.display = 'none');

		// 로그인 여부에 따라 메뉴 항목 토글
		const nameText = toggle.textContent.trim();
		const loggedIn = !(nameText === '메뉴' || nameText === '로그인');
		[...menu.querySelectorAll('li')].forEach(li=>{
			if (loggedIn && (li.textContent.includes('로그인') || li.textContent.includes('회원가입'))) li.style.display='none';
			if (!loggedIn && (li.textContent.includes('내 정보') || li.textContent.includes('로그아웃'))) li.style.display='none';
		});
	}
</script>
</body>
</html>
