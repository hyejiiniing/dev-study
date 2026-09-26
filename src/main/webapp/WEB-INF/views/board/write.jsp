<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/header.css">

<title>글쓰기 | DevStudy</title>

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

    header {
        padding: 24px max(24px, calc((100% - 1080px) / 2));
        background: #fff;
        border-bottom: 1px solid #e5e5e5;
    }

    .logo {
        font-size: 23px;
        font-weight: 800;
        letter-spacing: -1px;
    }

    main {
        max-width: 840px;
        margin: 0 auto;
        padding: 48px 20px 72px;
    }

    .eyebrow {
        margin: 0 0 14px;
        color: #666;
        font-size: 10px;
        font-weight: 700;
        letter-spacing: 2px;
    }

    h1 {
        margin: 0;
        font-size: 34px;
        letter-spacing: -1.5px;
    }

    .description {
        margin: 14px 0 28px;
        color: #666;
        font-size: 14px;
        line-height: 1.8;
    }

    form {
        padding: 32px;
        border: 1px solid #e2e2e2;
        border-radius: 18px;
        background: #fff;
    }

    .field { margin-bottom: 24px; }

    label {
        display: block;
        margin-bottom: 10px;
        font-size: 13px;
        font-weight: 600;
    }

    input:not([type="hidden"]), textarea {
        width: 100%;
        padding: 14px;
        border: 1px solid #d9d9d9;
        border-radius: 9px;
        background: #fff;
        color: #171717;
        font: inherit;
        font-size: 14px;
    }

    textarea {
        min-height: 300px;
        resize: vertical;
        line-height: 1.8;
    }

    input:focus, textarea:focus {
        outline: none;
        border-color: #171717;
        box-shadow: 0 0 0 3px rgba(0, 0, 0, .06);
    }

    .hint {
        margin: 8px 0 0;
        color: #707070;
        font-size: 12px;
        line-height: 1.6;
    }

    .error {
        margin-bottom: 24px;
        padding: 14px;
        border: 1px solid #171717;
        border-left-width: 4px;
        border-radius: 8px;
        font-size: 13px;
        line-height: 1.7;
    }

    .actions {
        display: flex;
        justify-content: flex-end;
        gap: 10px;
        padding-top: 24px;
        border-top: 1px solid #eee;
    }

    .button {
        padding: 13px 20px;
        border: 1px solid #ddd;
        border-radius: 8px;
        background: #fff;
        font: inherit;
        font-size: 13px;
        cursor: pointer;
    }

    .button-dark {
        background: #171717;
        border-color: #171717;
        color: #fff;
    }

    .button-dark:hover { background: #383838; }

    a:focus-visible, button:focus-visible {
        outline: 2px solid #171717;
        outline-offset: 4px;
    }

    @media (max-width: 600px) {
        main { padding-top: 32px; }
        form { padding: 22px 18px; }
        h1 { font-size: 29px; }
    }
</style>
</head>

<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<main>
    <p class="eyebrow">
        DEVSTUDY / <c:out value="${boardName}"/>
    </p>

    <h1>당신의 이야기를 들려주세요.</h1>
    <p class="description">작은 질문도, 새로운 발견도 좋은 시작이 됩니다.</p>

    <c:if test="${not empty errorMessage}">
        <div class="error" role="alert">
            <c:out value="${errorMessage}"/>
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/board/write"
          method="post" enctype="multipart/form-data">

        <input type="hidden" name="boardType" value="${boardType}">
        <input type="hidden" name="writeToken"
               value="${sessionScope.boardWriteToken}">

        <div class="field">
            <label for="category">분류 · 선택</label>
            <input type="text" id="category" name="category"
                   maxlength="256"
                   value="<c:out value='${form.category}'/>"
                   placeholder="예: 공부 인증, SQLD, Java">
        </div>

        <div class="field">
            <label for="title">제목</label>
            <input type="text" id="title" name="title"
                   maxlength="256" required
                   value="<c:out value='${form.title}'/>"
                   placeholder="어떤 이야기를 나누고 싶나요?">
        </div>
        
        <div class="field">
		    <label for="content">내용</label>
		    <textarea id="content"
		              name="content"
		              rows="12"
		              placeholder="내용을 자유롭게 작성해주세요."
		              required><c:out value="${form.content}"/></textarea>
		</div>

        <div class="field">
		    <label for="files">첨부파일 · 선택</label>
		
		    <input type="file"
		           id="files"
		           name="files"
		           multiple
		           accept=".png,.jpg,.jpeg,.pdf,.txt"
		           aria-describedby="files-hint">
		
		    <p class="hint" id="files-hint">
		        PNG, JPG, PDF, UTF-8 TXT · 최대 5개 · 파일당 10MB<br>
		        등록 오류 후에는 파일을 다시 선택해주세요.
		    </p>
		</div>

        <div class="actions">
            <a class="button"
               href="${pageContext.request.contextPath}/board/list?boardType=${boardType}">
                취소
            </a>
            <button class="button button-dark" type="submit">
                등록하기 ↗
            </button>
        </div>
    </form>
</main>
</body>
</html>