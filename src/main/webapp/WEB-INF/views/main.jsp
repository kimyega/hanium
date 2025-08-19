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
    <link rel="stylesheet" href="/css/table.css" />

    <style>
        :root{
            --peach:#fca08c;
            --peach-border:#f59c8b;
            --shadow:0 8px 12px rgba(0,0,0,.10);
        }
        html,body{height:100%; margin:0; font-family:'Cute Font',sans-serif; background:#fff;}

        /* ===== 메인 Hero ===== */
        .hero-wrap{
            display:flex;
            align-items:center;
            justify-content:center;
            height:calc(100vh - 72px); /* 상단바 제외 전체 높이 */
            padding:0 40px;
        }
        .hero-content{
            display:flex;
            align-items:center;
            justify-content:space-between;
            width:100%;
            max-width:1600px;
            gap:60px;
        }

        /* 왼쪽 버튼 */
        .menu-col{
            display:flex;
            flex-direction:column;
            gap:44px;
            flex:0 0 340px; /* 버튼 영역 고정 */
        }
        .menu-btn{
            display:flex;
            align-items:center;
            justify-content:center;
            width:100%; height:118px;
            border-radius:60px;
            border:6px solid var(--peach-border);
            background:#fff;
            font-size:38px; cursor:pointer;
            box-shadow:var(--shadow);
            transition:transform .1s ease, box-shadow .2s ease, background .2s ease;
        }
        .menu-btn:hover{
            transform:translateY(-2px);
            box-shadow:0 12px 18px rgba(0,0,0,.16);
            background:#fffdfb;
        }
        .menu-btn i{ margin-right:14px; }

        /* 오른쪽 성 그림 */
        .hero-image{
            flex:1;
            display:flex;
            justify-content:center;
            align-items:center;
        }
        .hero-image img{
            width:100%;
            height:95vh;      /* ✅ 기존 85vh → 92vh 로 확대 */
            object-fit:contain; /* 비율 유지 (그림 안 찌그러짐) */
        }


        /* 반응형 */
        @media (max-width: 960px){
            .hero-wrap{ height:auto; min-height:100vh; }
            .hero-content{ flex-direction:column; gap:40px; }
            .menu-col{ flex:unset; width:100%; align-items:center; }
            .menu-btn{ width:min(88vw, 360px); }
            .hero-image img{ height:auto; max-width:100%; }
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
<main class="hero-wrap">
    <div class="hero-content">
        <!-- 왼쪽 버튼 -->
        <div class="menu-col">
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

        <!-- 오른쪽 성 그림 -->
        <div class="hero-image">
            <img src="/images/index.png" alt="성 그림" />
        </div>
    </div>
</main>

<script>
    // 드롭다운
    const toggle = document.getElementById('headerDropdownToggle');
    const menu = document.getElementById('headerDropdownMenu');
    if (toggle && menu){
        toggle.addEventListener('click', e => {
            e.stopPropagation();
            menu.style.display = (menu.style.display === 'block') ? 'none' : 'block';
        });
        document.addEventListener('click', () => menu.style.display = 'none');
    }
</script>
</body>
</html>
