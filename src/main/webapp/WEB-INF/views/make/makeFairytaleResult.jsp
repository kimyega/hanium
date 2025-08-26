<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>동화 생성 결과</title>
    <!-- Google Fonts: Kavoon, Cute Font -->
    <link href="https://fonts.googleapis.com/css2?family=Kavoon&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Cute+Font&family=Kavoon&display=swap" rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <link rel="stylesheet" href="/css/table.css"/>

    <%-- 모달창 css --%>
    <link rel="stylesheet" href="/css/headerLogout.css"/>

    <%-- Jquery --%>
    <script type="text/javascript" src="/js/jquery-3.6.0.min.js"></script>
    <style>
        .made {
            background-color: #fff;
            padding: 20px;
            flex: none;
            display: flex;
            flex-direction: column;
            align-items: center;
            border: 15px solid #fca08c;
            width: 50%;
            height: 600px;
            font-size: 55px;
        }

        .made.contents {
            text-align: center;
            overflow-y: auto;
        }

        .made.contents::-webkit-scrollbar {
            width: 15px; /* 스크롤바 너비 */
            height: 20px;
        }

        .made.contents::-webkit-scrollbar-track {
            background: #ffe5de; /* 스크롤 트랙 배경 */
            width: 2px;
        }

        .made.contents::-webkit-scrollbar-thumb {
            background-color: #fca08c; /* 스크롤바 색상 */
            border-radius: 10px;
            border: 3px solid #ffe5de; /* thumb 테두리 색상 (트랙과 같게 하면 패딩처럼 보임) */
        }

        .made-card-wrapper {
            width: 60%;
            display: flex;
            gap: 0;
            margin: 15px auto 0 auto;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.05);
            border-radius: 10px;
            border: 15px solid #fca08c;
            position: relative; /* 버튼을 내부 절대 위치로 배치하려면 필요 */
            justify-content: center; /* 카드 안 이미지/텍스트 중앙 배치 */
        }

        .make-wrapper-two {
            display: flex;
            justify-content: space-between; /* 버튼을 양쪽 끝으로 정렬 */
            align-items: center;
            margin-top: 10px;
            width: 100%; /* 전체 너비 사용 */
            padding: 0 30px; /* 좌우 여백 조절 (원하면 조정 가능) */
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

        .page-number {
            margin-top: 40px;
            text-decoration: none;
        }

        .page-control-left,
        .page-control-right {
            position: absolute;
            top: 50%; /* 세로 중앙 */
        }

        .page-control-right {
            right: 30px;
        }

        .page-control-left {
            left: 30px;
        }

        /* 저장 모달 내용 */
        .save-modal-content {
            text-align: center;
            padding: 30px;
        }

        /* 제목 입력 input */
        .fairy-tale-title-input {
            width: 80%;
            margin-top: 70px;
            font-size: 20px;
            border: none;
            border-bottom: 3px solid #fca08c;
            outline: none;
            text-align: center;
            padding: 5px;
        }

        /* 저장 버튼 */
        .save-btn {
            margin-top: 20px;
        }


        /* 공통 모달 배경 */
        .modal {
            display: none; /* 기본은 숨김 */
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.5);
        }

        /* 모달 내용 박스 */
        .modal-content {
            background: #fff;
            margin: 10% auto; /* 화면 중앙 정렬 */
            padding: 40px; /* 여백 넉넉하게 */
            border-radius: 15px;
            width: 600px; /* 가로 크기 늘림 */
            max-width: 80%; /* 화면이 작을 때는 자동 줄어듦 */
            height: 600px;
            text-align: center;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.25);

        }

        /* 저장 모달 전용 크기 조정 */
        .save-modal-content {
            padding: 50px;
            width: 600px;
            max-width: 85%;
        }
        /* 입력창 스타일 */
        .fairy-tale-title-input {
            width: 100%;
            font-size: 36px;             /* 글씨 크기 */
            padding: 16px 12px;          /* 위아래 여백 넉넉하게 */
            margin: 0 0 8px;
            border: none;                /* 전체 테두리 제거 */
            border-bottom: 4px solid #fca08c; /* 아래쪽 테두리만 강조 */
            border-radius: 0;            /* 모서리 없애기 */
            outline: none;
            text-align: center;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        .fairy-tale-title-input:focus {
            border-bottom-color: #f78c6f;
        }

        .fairy-tale-title-input.input-error {
            border-bottom-color: red;
        }

        /* 모달 버튼 기본 */
        .modal__actions .btn {
            flex: 1;
            padding: 14px 0;
            font-size: 22px;
            border-radius: 12px;
            border: 3px solid #fca08c; /* 테두리 굵게 */
            cursor: pointer;
            transition: 0.2s;
        }

        /* 저장 버튼 스타일 */
        #saveFairyTaleBtn {
            background-color: #fff;
            color: #000;
            border: 3px solid #fca08c;
        }

        #saveFairyTaleBtn:hover {
            background-color: #fca08c;
            color: #fff;
        }

        /* 취소 버튼 스타일 */
        #cancelSaveBtn {
            background-color: #fff; /* 연한 붉은 계열 */
            color: #222;               /* 진한 글씨 */
            border: 3px solid #fca08c;
        }

        #cancelSaveBtn:hover {
            background-color: #fca08c; /* 호버 시 강조 */
            color: #fff;
        }

        /**** 이전 버튼 ****/
        .top-back-button {
            display: flex;
            flex-direction: column;   /* 아이콘 위, 텍스트 아래 */
            align-items: center;      /* 가운데 정렬 */
            justify-content: center;  /* 세로로도 가운데 정렬 */
            gap: 8px;                 /* 아이콘-텍스트 간격 */
            padding-top: 20px; /* top을 크게 줘서 아래로 내림 */
        }

        .top-back-button i {
            font-size: 24px;  /* 화살표 크기 */
        }

        .top-back-button span {
            font-size: 12px;  /* 글자 작게 */
            color: #333;      /* 텍스트 색 */
        }

        .top-back-button:hover {
            background-color: #fca08c;
            color: white;
        }

    </style>
</head>

<body>
<!-- 상단바 -->
<%@ include file="../includes/header.jsp" %>

<form id="f">
    <main>
        <div class="top-bar">
            <button type="button" class="button top-home-button" onclick="location.href='/user/main'">
                <i class="fa-solid fa-house fa-2xl"></i>
            </button>

            <!-- 이전 페이지 버튼 -->
            <button type="button" class="button top-back-button" onclick="history.back()">
                <i class="fa-solid fa-arrow-left fa-2xl"></i>
                <span class="">이전</span>
            </button>
        </div>

        <div class="container">
            <div class="make-wrapper-one">
                <button id="prevPage" class="page-control-left button page-btn">
                    <i class="fa-solid fa-arrow-left fa-2xl"></i>
                </button>
                <div class="made-card-wrapper">
                    <div id="gptResultImage" class="made card card-img"></div>
                    <div id="gptResultBox" class="made contents"></div>
                </div>
                <button id="nextPage" class="page-control-right button page-btn">
                    <i class="fa-solid fa-arrow-right fa-2xl"></i>
                </button>
            </div>
            <div class="make-wrapper-two">
                    <button type="button" id="remakeFairytale" class="button make">다시 만들기</button>
                <div class="page-number">
                    <span id="pageNumber">1</span> / <span id="totalPages">?</span>
                </div>
                <button type="button" id="saveFairytale" class="button make">동화 저장하기</button>
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

<!-- 동화 저장 모달 -->
<div id="saveModal" class="modal">
    <div class="modal-content save-modal-content">
        <h2>동화 제목을 입력해 주세요</h2>
        <label for="fairyTaleTitle"></label>
        <p id="titleError" style="color:red; margin-top:10px; visibility:hidden;">제목을 입력해 주세요</p>
        <input type="text" id="fairyTaleTitle" placeholder="제목 입력" class="fairy-tale-title-input">
        <br><br>
        <button id="saveFairyTaleBtn" class="modal-btn save-btn">저장하기</button>
        <button id="cancelSaveBtn" class="modal-btn save-btn cancel-action">취소</button>
    </div>
</div>

<script>
    $(document).ready(function () {
        let currentPage = 1;
        let totalPages = Number('${not empty sessionScope.STORY_TOTAL_PAGES ? sessionScope.STORY_TOTAL_PAGES : 1}');

        // totalPages 표시
        $("#totalPages").text(totalPages);

        function loadPage(page) {
            $.ajax({
                url: '/make/makeFairytaleResultByPage',
                type: 'GET',
                data: {pageNumber: page},
                dataType: 'json',
                success: function (data) {
                    const gptResultBox = $("#gptResultBox");
                    const gptResultImage = $("#gptResultImage");

                    if (data) {
                        let html = "";
                        let imageHtml = "";
                        let imgPath;

                        if (data.contentText) {
                            html += "<p>" + data.contentText + "</p>";
                        }

                        if (data.aiImageData) {
                            imgPath = "data:image/png;base64," + data.aiImageData;
                        } else {
                            imgPath = "/images/castle.png"; // 기본 이미지
                        }

                        imageHtml += '<img src="' + imgPath + '" alt="기본 이미지" style="max-width:100%;">';

                        console.log("이미지 Html : ", imageHtml);
                        console.log("텍스트 Html : ", html);

                        gptResultBox.html(html || "내용이 없습니다.");
                        gptResultImage.html(imageHtml);

                        // 현재 페이지 업데이트
                        $("#pageNumber").text(page);

                        console.log("페이지 로드 완료 :", page);
                    }
                },
                error: function (err) {
                    console.error("페이지 요청 실패:", err);
                }
            });
        }

        // 초기 페이지 로드
        loadPage(currentPage);

        // 이전 버튼
        $("#prevPage").click(function (e) {
            e.preventDefault();
            if (currentPage > 1) {
                currentPage--;
                loadPage(currentPage);
                console.log("현재 페이지 : ", currentPage);
            }

        });
        // 다음 버튼
        $("#nextPage").click(function (e) {
            e.preventDefault();
            if (currentPage < totalPages) {
                currentPage++;
                loadPage(currentPage);
                console.log("현재 페이지 : ", currentPage);
            }
        });


        // 버튼 선택자 변수에 저장 (중복 선택 방지)
        const $remakeBtn = $("#remakeFairytale");
        const $saveBtn = $("#saveFairytale");

        // 기본 숨김
        $remakeBtn.hide();
        $saveBtn.hide();

        // HTTP Referer 가져오기 (서버에서 JSP EL로 넘겨줌)
        const referer = "<%= request.getHeader("referer") != null ? request.getHeader("referer") : "" %>";

        console.log("리퍼러 : ", referer);

        // referer 체크 후 버튼 표시
        if (referer.endsWith("/make/makeFairytale")) {
            $remakeBtn.show();
            $saveBtn.show();
        }


        // "동화 저장하기" 버튼 눌렀을 때 모달 열기
        $saveBtn.click(function () {
            $("#saveModal").css("display", "flex");
        });

        // 모달 저장 버튼 클릭
        $("#saveFairyTaleBtn").click(function () {
            const title = $("#fairyTaleTitle").val().trim();

            if (!title) {
                $("#titleError").css("visibility", "visible");
                $("#fairyTaleTitle").addClass("input-error").focus();
                return;
            }

            $("#titleError").css("visibility", "hidden");
            $("#fairyTaleTitle").removeClass("input-error");

            $.ajax({
                url: '/make/updateFairyTaleTitle',
                type: 'POST',
                data: {title: title},
                success: function (res) {
                    if (res === 1) {
                        window.location.href = '/make/makeFairytaleList';
                    } else {
                        console.error("동화 제목 저장 실패!");
                    }
                },
                error: function (err) {
                    console.error("AJAX 요청 실패:", err);
                }
            });
        });

        // 모달 취소 버튼 클릭 시
        $("#cancelSaveBtn").click(function() {
            $("#saveModal").css("display", "none");
            $("#fairyTaleTitle").val(""); // 입력창 초기화
            $("#titleError").css("visibility", "hidden"); // 오류 메시지 숨김
            $("#fairyTaleTitle").removeClass("input-error");
        });

        // "다시 만들기" 버튼 클릭시 삭제 후 페이지 이동
        $remakeBtn.click(function (e) {
            e.preventDefault();
            $.ajax({
                url: '/make/deleteAiGeneratedStories',
                type: 'GET',
                success: function (res) {
                    if (res === 1) {
                        console.log("삭제 성공");
                        window.location.href = '/make/makeFairytale';
                    } else {
                        alert("삭제 실패");
                    }
                },
                error: function (err) {
                    console.error("삭제 요청 실패", err);
                }
            });
        });
    });

</script>

<script src="${pageContext.request.contextPath}/js/headerLogout.js"></script>
</body>
</html>