<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><c:out value="${board.title}"/> | DevStudy</title>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/css/board.css">
</head>
<body>
<header>
    <a class="logo" href="${pageContext.request.contextPath}/home">
        DevStudy.
    </a>
</header>

<main>
    <p class="eyebrow">
        DEVSTUDY / <c:out value="${boardName}"/>
    </p>

    <c:if test="${not empty successMessage}">
        <div class="message" role="status">
            <c:out value="${successMessage}"/>
        </div>
    </c:if>

    <article class="card">
        <h1><c:out value="${board.title}"/></h1>

        <div class="meta">
            <span>글 번호 <c:out value="${board.boardIdx}"/></span>
            <c:if test="${not empty board.category}">
                <span><c:out value="${board.category}"/></span>
            </c:if>
        </div>

        <div class="content"><c:out value="${board.content}"/></div>
    </article>

    <div class="actions">
        <a class="button"
           href="${pageContext.request.contextPath}/board/list?boardType=${board.boardType}">
            ← 목록
        </a>

        <c:if test="${not empty sessionScope.loginMemberIdx
                     and sessionScope.loginMemberIdx == board.memberIdx
                     and (board.boardType != 6 or sessionScope.loginRole == 'ADMIN')}">
            <div class="owner-actions">
                <a class="button"
                   href="${pageContext.request.contextPath}/board/update?boardIdx=${board.boardIdx}">
                    수정
                </a>

                <form action="${pageContext.request.contextPath}/board/delete"
                      method="post"
                      onsubmit="return confirm('게시글을 삭제할까요? 삭제 후에는 복구할 수 없습니다.');">

                    <input type="hidden" name="boardIdx"
                           value="${board.boardIdx}">
                    <input type="hidden" name="actionToken"
                           value="${sessionScope.boardActionToken}">

                    <button class="button button-dark" type="submit">
                        삭제
                    </button>
                </form>
            </div>
        </c:if>
    </div>
</main>
</body>
</html>