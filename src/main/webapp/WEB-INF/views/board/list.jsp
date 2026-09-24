<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><c:out value="${boardName}"/> | DevStudy</title>

<style>
    * { box-sizing: border-box; }

    body {
        margin: 0;
        background: #fafafa;
        color: #171717;
        font-family: -apple-system, BlinkMacSystemFont,
                     "Apple SD Gothic Neo", sans-serif;
    }

    a { color: inherit; text-decoration: none; }

    .container {
        width: min(1080px, calc(100% - 40px));
        margin: 0 auto;
    }

    header {
        background: #fff;
        border-bottom: 1px solid #e5e5e5;
    }

    .header-inner {
        min-height: 76px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 20px;
    }

    .logo {
        font-size: 23px;
        font-weight: 800;
        letter-spacing: -1px;
    }

    .account {
        font-size: 13px;
        overflow-wrap: anywhere;
    }

    .intro { padding: 56px 0 28px; }

    .eyebrow {
        margin: 0 0 16px;
        font-size: 10px;
        font-weight: 700;
        letter-spacing: 3px;
        color: #666;
    }

    h1 {
        margin: 0;
        font-size: 40px;
        letter-spacing: -2px;
    }

    .description {
        margin: 14px 0 0;
        color: #666;
        font-size: 14px;
        line-height: 1.8;
    }

    .tabs {
        display: flex;
        gap: 8px;
        flex-wrap: wrap;
        margin-bottom: 30px;
    }

    .tab {
        padding: 11px 17px;
        border: 1px solid #ddd;
        border-radius: 8px;
        background: #fff;
        font-size: 13px;
    }

    .tab:hover { background: #eee; }

    .tab.active {
        background: #171717;
        border-color: #171717;
        color: #fff;
    }

    .board {
        overflow: hidden;
        border: 1px solid #e3e3e3;
        border-radius: 16px;
        background: #fff;
    }

    .board-heading {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 16px;
        padding: 24px;
        border-bottom: 1px solid #eee;
    }

    .board-heading h2 {
        margin: 0;
        font-size: 16px;
    }

    .board-heading span {
        color: #707070;
        font-size: 12px;
    }

    .table-wrap { overflow-x: auto; }

    table {
        width: 100%;
        border-collapse: collapse;
        text-align: left;
        font-size: 13px;
    }

    th {
        padding: 15px 20px;
        color: #666;
        background: #fcfcfc;
        font-size: 12px;
        font-weight: 500;
        white-space: nowrap;
    }

    td {
        padding: 20px;
        border-top: 1px solid #eee;
    }

    .number, .views {
        width: 80px;
        color: #777;
    }

    .category {
        display: inline-block;
        margin-right: 8px;
        padding: 4px 7px;
        border: 1px solid #e3e3e3;
        border-radius: 5px;
        color: #666;
        font-size: 10px;
    }

    .post-title {
        font-weight: 600;
        overflow-wrap: anywhere;
    }

    .empty {
        padding: 76px 24px;
        text-align: center;
    }

    .empty-mark {
        display: grid;
        place-items: center;
        width: 52px;
        height: 52px;
        margin: 0 auto 20px;
        border: 1px solid #e3e3e3;
        border-radius: 14px;
        font-family: monospace;
        font-size: 20px;
    }

    .empty h3 {
        margin: 0 0 10px;
        font-size: 17px;
    }

    .empty p {
        margin: 0;
        color: #707070;
        font-size: 13px;
        line-height: 1.8;
    }

    .back-link {
        display: inline-block;
        margin: 24px 0 64px;
        color: #666;
        font-size: 13px;
    }

    footer {
        padding: 26px 20px;
        border-top: 1px solid #e5e5e5;
        color: #707070;
        text-align: center;
        font-size: 11px;
        letter-spacing: 1px;
    }

    a:focus-visible {
        outline: 2px solid #171717;
        outline-offset: 4px;
    }

    @media (max-width: 600px) {
        .intro { padding-top: 36px; }
        h1 { font-size: 32px; }
        .tab { padding: 10px 13px; }
        th, td { padding: 14px 12px; }
        .number { display: none; }
    }
</style>
</head>

<body>
<header>
    <div class="container header-inner">
        <a class="logo"
           href="${pageContext.request.contextPath}/home">
            DevStudy.
        </a>

        <div class="account">
            <c:choose>
                <c:when test="${not empty sessionScope.loginMemberIdx}">
                    <strong>
                        <c:out value="${sessionScope.loginNickname}"/>
                    </strong>님
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/member/signin">
                        로그인 ↗
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>

<main class="container">
    <section class="intro">
        <p class="eyebrow">DEVSTUDY / BOARD</p>
        <h1><c:out value="${boardName}"/></h1>
        <p class="description">
            <c:choose>
                <c:when test="${boardType == 1}">
                    공부 기록부터 개발 일상까지, 편하게 이야기 나눠요.
                </c:when>
                <c:when test="${boardType == 2}">
                    직접 써본 AI 활용법과 새로운 시도를 공유해요.
                </c:when>
                <c:when test="${boardType == 3}">
                    자격증 준비 과정과 학습 노하우를 함께 나눠요.
                </c:when>
                <c:when test="${boardType == 4}">
                    같은 목표를 가진 스터디원과 프로젝트 팀원을 만나세요.
                </c:when>
                <c:when test="${boardType == 5}">
                    막히는 부분이 있다면 질문하고 함께 해결해요.
                </c:when>
                <c:otherwise>
                    DevStudy의 운영 안내와 새로운 소식을 확인하세요.
                </c:otherwise>
            </c:choose>
        </p>
    </section>

    <nav class="tabs" aria-label="게시판 선택">
        <a class="tab ${boardType == 1 ? 'active' : ''}"
           href="${pageContext.request.contextPath}/board/list?boardType=1">
            커뮤니티
        </a>
        <a class="tab ${boardType == 2 ? 'active' : ''}"
           href="${pageContext.request.contextPath}/board/list?boardType=2">
            AI
        </a>
        <a class="tab ${boardType == 3 ? 'active' : ''}"
           href="${pageContext.request.contextPath}/board/list?boardType=3">
            자격증
        </a>
        <a class="tab ${boardType == 4 ? 'active' : ''}"
           href="${pageContext.request.contextPath}/board/list?boardType=4">
            모임
        </a>
        <a class="tab ${boardType == 5 ? 'active' : ''}"
           href="${pageContext.request.contextPath}/board/list?boardType=5">
            Q&amp;A
        </a>
        <a class="tab ${boardType == 6 ? 'active' : ''}"
           href="${pageContext.request.contextPath}/board/list?boardType=6">
            공지사항
        </a>
    </nav>
    
    <c:if test="${not empty successMessage}">
	    <p role="status">
	        <c:out value="${successMessage}"/>
	    </p>
	</c:if>
	
	<c:if test="${not empty sessionScope.loginMemberIdx
	             and (boardType != 6 or sessionScope.loginRole == 'ADMIN')}">
	    <div style="display: flex; justify-content: flex-end; margin-bottom: 16px;">
	        <a class="tab active"
	           href="${pageContext.request.contextPath}/board/write?boardType=${boardType}">
	            글쓰기 ↗
	        </a>
	    </div>
	</c:if>

    <section class="board" aria-labelledby="list-title">
        <div class="board-heading">
            <h2 id="list-title">최근 게시글</h2>
            <span>최신 20개 기준</span>
        </div>

        <c:choose>
            <c:when test="${empty boardList}">
                <div class="empty">
                    <div class="empty-mark" aria-hidden="true">{ }</div>
                    <h3>아직 등록된 글이 없어요.</h3>
                    <p>새로운 이야기와 기록이 채워질 공간입니다.</p>
                </div>
            </c:when>

            <c:otherwise>
                <div class="table-wrap">
                    <table aria-label="${boardName} 게시글 목록">
                        <thead>
                            <tr>
                                <th class="number" scope="col">번호</th>
                                <th scope="col">제목</th>
                                <th class="views" scope="col">조회</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="board" items="${boardList}">
                                <tr>
                                    <td class="number">
                                        <c:out value="${board.boardIdx}"/>
                                    </td>
                                    <td>
                                        <c:if test="${not empty board.category}">
                                            <span class="category">
                                                <c:out value="${board.category}"/>
                                            </span>
                                        </c:if>
                                        <span class="post-title">
                                            <c:out value="${board.title}"/>
                                        </span>
                                    </td>
                                    <td class="views">
                                        <c:out value="${board.viewCount}"/>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </section>

    <a class="back-link"
       href="${pageContext.request.contextPath}/home">
        ← 홈으로 돌아가기
    </a>
</main>

<footer>DEVSTUDY · LEARN. BUILD. TOGETHER.</footer>
</body>
</html>