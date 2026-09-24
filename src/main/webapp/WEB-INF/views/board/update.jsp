<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>글 수정 | DevStudy</title>
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

    <h1>이야기를 다듬어보세요.</h1>

    <c:if test="${not empty errorMessage}">
        <div class="message" role="alert">
            <c:out value="${errorMessage}"/>
        </div>
    </c:if>

    <form class="card"
          action="${pageContext.request.contextPath}/board/update"
          method="post">

        <input type="hidden" name="boardIdx" value="${board.boardIdx}">
        <input type="hidden" name="actionToken"
               value="${sessionScope.boardActionToken}">

        <div class="field">
            <label for="category">분류 · 선택</label>
            <input type="text" id="category" name="category"
                   maxlength="256"
                   value="<c:out value='${board.category}'/>">
        </div>

        <div class="field">
            <label for="title">제목</label>
            <input type="text" id="title" name="title"
                   maxlength="256" required
                   value="<c:out value='${board.title}'/>">
        </div>

        <div class="field">
            <label for="content">내용</label>
            <textarea id="content" name="content"
                      required><c:out value="${board.content}"/></textarea>
        </div>

        <div class="actions">
            <a class="button"
               href="${pageContext.request.contextPath}/board/detail?boardIdx=${board.boardIdx}">
                취소
            </a>
            <button class="button button-dark" type="submit">
                수정 완료 ↗
            </button>
        </div>
    </form>
</main>
</body>
</html>