<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="kopo.poly.hanium.dto.QuizzesDTO" %>
<%@ page import="kopo.poly.hanium.util.CmmUtil" %>
<%
    List<QuizzesDTO> rList = (List<QuizzesDTO>) request.getAttribute("rList");
%>
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

    <%-- 모달창 css --%>
    <link rel="stylesheet" href="/css/headerLogout.css" />

    <%-- Jquery --%>
    <script type="text/javascript" src="/js/jquery-3.6.0.min.js"></script>

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
<%@ include file="../includes/header.jsp"%>

<main class="mypage-main">
    <h2>마이페이지</h2>

    <button class="mypage-btn" onclick="location.href='/user/changePw'">
        <i class="fa-solid fa-book"></i>
        <span>내가 만든 동화</span>
        <i class="fa-solid fa-chevron-right"></i>
    </button>

    <button class="mypage-btn" onclick="location.href='/user/changePw'">
        <i class="fa-solid fa-lock"></i>
        <span>비밀번호 변경</span>
        <i class="fa-solid fa-chevron-right"></i>
    </button>

    <button class="mypage-btn" onclick="location.href='/user/withdraw'">
        <i class="fa-solid fa-user-xmark"></i>
        <span>회원 탈퇴</span>
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
            <tbody id="quizTableBody">

            </tbody>
        </table>
    </section>
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
    $(document).ready(function () {
        $.ajax({
            url: '/user/quizHistory',
            method: 'GET',
            dataType: 'json',
            success: function (data) {
                const tbody = $('#quizTableBody');
                tbody.empty();
                console.log(data)

                if (data.length === 0) {
                    tbody.append('<tr><td colspan="4">퀴즈 기록이 없습니다.</td></tr>');
                } else {
                    data.forEach(q => {
                        if (q.score !== null) {
                            const date = q.takenAt ? q.takenAt.split('T')[0] : '-';
                            const score = q.score !== null && q.total !== null && q.total !== 0
                                ? Math.round((q.score / q.total) * 100) + '점'
                                : '-';

                            const tr = $('<tr></tr>');
                            tr.append($('<td></td>').text(q.title));
                            tr.append($('<td></td>').text(score));
                            tr.append($('<td></td>').text(q.total));
                            tr.append($('<td></td>').text(date));
                            tr.css('cursor', 'pointer');  // 마우스 포인터가 클릭 가능한 모양으로 변경
                            tr.on('click', function () {
                                window.location.href = '/quiz/quizInfo?nSeq=' + q.quizId;
                            })
                            tr.on('mouseenter', function () {
                                $(this).css('background-color', '#cce4ff');
                            }).on('mouseleave', function () {
                                $(this).css('background-color', '');
                            });
                            $('#quizTableBody').append(tr);
                        }
                    });

                }
            },
            error: function (xhr, status, error) {
                console.error('퀴즈 데이터 로딩 실패:', error);
                $('#quizTableBody').append('<tr><td colspan="4">데이터 불러오기 실패</td></tr>');
            }
        });
    });
</script>

<script src="${pageContext.request.contextPath}/js/headerLogout.js"></script>

</body>
</html>