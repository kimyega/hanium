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
</head>

<style>
    /* 마이페이지 main 컨테이너 */
    main.mypage-main {
        max-width: 900px;
        margin: 30px auto 0px;
        padding: 30px;
        background-color: #fff8e8;
        /* 부드러운 크림톤 배경 */
        border-radius: 25px;
        box-shadow: 0 0 25px rgba(252, 160, 140, 0.3);
        font-family: 'Cute Font', sans-serif;
        color: #6b4f2d;
        /* 부드러운 브라운 계열 글씨 */
    }

    /* 제목 */
    .mypage-main h2 {
        font-size: 60px;
        text-align: center;
        margin-top: 0;
        margin-bottom: 40px;
        color: black;
    }

    /* 버튼 공통 */
    .mypage-btn {
        width: 100%;
        max-width: 400px;
        margin: 0 auto 25px;
        background-color: #fca08c;
        color: white;
        font-size: 32px;
        padding: 18px 30px;
        border: none;
        border-radius: 40px;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: space-between;
        box-shadow: 0 6px 12px rgba(252, 160, 140, 0.5);
        transition: background-color 0.3s ease, transform 0.2s ease;
    }

    .mypage-btn i {
        font-size: 36px;
        margin-left: 20px;
    }

    .mypage-btn:hover {
        background-color: #ffb799;
        transform: translateY(-3px);
    }

    /* 퀴즈 기록 섹션 */
    .quiz-history {
        background-color: #fff5d2;
        border-radius: 20px;
        padding: 20px 30px;
        box-shadow: 0 6px 15px rgba(252, 160, 140, 0.3);
        max-width: 900px;
        margin: 30px auto 0;
    }

    .quiz-history h3 {
        font-size: 38px;
        color: black;
        margin-top: 0px;
        margin-bottom: 25px;
        text-align: center;
    }

    /* 퀴즈 기록 테이블 */
    .quiz-history table {
        width: 100%;
        border-collapse: collapse;
        font-size: 26px;
        color: #6b4f2d;
    }

    .quiz-history th,
    .quiz-history td {
        padding: 16px 12px;
        border-bottom: 2px solid #fca08c;
        text-align: center;
    }

    .quiz-history th {
        background-color: #fce1d7;
        font-weight: bold;
    }

    /* 반응형 (간단히) */
    @media screen and (max-width: 600px) {
        main.mypage-main {
            padding: 20px;
            margin: 80px 10px 40px;
        }

        .mypage-btn {
            font-size: 24px;
            padding: 15px 20px;
        }

        .quiz-history h3 {
            font-size: 28px;
        }

        .quiz-history table {
            font-size: 18px;
        }
    }
</style>

<body>
<header>
    <div class="header-icon-stack">
        <i class="fa-solid fa-book-open book"></i>
        <i class="fa-solid fa-hands-holding hands"></i>
    </div>
    <div class="header-logo" onclick="location.href='/home.html'">Märchand</div>
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

<main class="mypage-main">
    <h2>마이페이지</h2>

    <button class="mypage-btn" onclick="location.href='/user/changePw'">
        <span><i class="fa-solid fa-lock"></i> 비밀번호 변경</span>
        <i class="fa-solid fa-chevron-right"></i>
    </button>

    <button class="mypage-btn" onclick="location.href='/user/withdraw'">
        <span><i class="fa-solid fa-user-xmark"></i> 회원 탈퇴</span>
        <i class="fa-solid fa-chevron-right"></i>
    </button>

    <section class="quiz-history">
        <h3>📋 나의 퀴즈 기록</h3>
        <table>
            <thead>
            <tr>
                <th>퀴즈 제목</th>
                <th>점수</th>
                <th>전체 문항</th>
                <th>응시 날짜</th>
            </tr>
            </thead>
            <tbody>
            <tbody id="quizTableBody">
            <!-- 자바스크립트로 동적으로 추가될 예정 -->
            </tbody>
            </tbody>
        </table>
    </section>
</main>

<script>
    const toggle = document.getElementById('headerDropdownToggle');
    const menu = document.getElementById('headerDropdownMenu');

    toggle.addEventListener('click', function (e) {
        e.stopPropagation();
        menu.style.display = menu.style.display === 'block' ? 'none' : 'block';
    });

    document.addEventListener('click', function () {
        menu.style.display = 'none';
    });

    // 🔽 퀴즈 데이터 배열
    const quizData = [
        { title: '기초 수어 단어', score: 8, total: 10, date: '2025-07-20' },
        { title: '동물 관련 수어', score: 6, total: 10, date: '2025-07-22' },
        { title: '색깔 수어 표현', score: 9, total: 10, date: '2025-07-23' },
        { title: '감정 표현 수어', score: 10, total: 10, date: '2025-07-24' }
    ];

    // 🔽 렌더링 함수
    const quizTableBody = document.getElementById('quizTableBody');

    quizData.forEach(q => {
        const row = document.createElement('tr');

        row.innerHTML = `
      <td>${q.title}</td>
      <td>${q.score}</td>
      <td>${q.total}</td>
      <td>${q.date}</td>
    `;

        quizTableBody.appendChild(row);
    });
</script>

</body>

</html>