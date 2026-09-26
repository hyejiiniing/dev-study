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
    <link rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/header.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

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
          method="post" enctype="multipart/form-data">

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
        
        <div class="field">
		    <h2 class="file-section-title">기존 첨부파일</h2>
		
		    <c:choose>
		        <c:when test="${empty fileList}">
		            <p class="file-hint">등록된 첨부파일이 없습니다.</p>
		        </c:when>
		
		        <c:otherwise>
		            <p class="file-hint">
		                삭제할 파일을 선택해주세요.
		                수정 완료를 눌러야 삭제됩니다.
		            </p>
		
		            <ul class="existing-files">
		                <c:forEach var="file" items="${fileList}">
		                    <li>
		                        <label class="file-delete-option">
		                            <input type="checkbox"
		                                   name="deleteFileIdxs"
		                                   value="${file.fileIdx}">
		
		                            <span class="file-original-name">
		                                <c:out value="${file.originalName}"/>
		                            </span>
		
		                            <span class="delete-label">삭제 선택</span>
		                        </label>
		                    </li>
		                </c:forEach>
		            </ul>
		        </c:otherwise>
		    </c:choose>
		</div>

<div class="field">
    <label for="files">새 파일 추가</label>

    <input type="file"
           id="files"
           name="files"
           multiple
           accept=".png,.jpg,.jpeg,.pdf,.txt"
           aria-describedby="upload-hint">

    <p class="file-hint" id="upload-hint">
        PNG, JPG, PDF, UTF-8 TXT · 파일당 최대 10MB<br>
        삭제 후 남는 기존 파일과 새 파일을 합쳐 최대 5개입니다.<br>
        수정 오류 후에는 삭제할 파일과 새 파일을 다시 선택해주세요.
    </p>
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