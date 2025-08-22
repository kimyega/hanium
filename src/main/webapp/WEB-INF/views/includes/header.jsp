<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<header>
    <div class="header-icon-stack">
        <i class="fa-solid fa-book-open book"></i>
        <i class="fa-solid fa-hands-holding hands"></i>
    </div>
    <div class="header-logo" onclick="location.href='/user/main'">Märchand</div>
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

