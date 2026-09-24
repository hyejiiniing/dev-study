<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>DevStudy 회원가입</title>
</head>
<body>
    <h1>회원가입</h1>
    
    <c:if test="${not empty errorMessage}">
	    <p role="alert" style="color: red;">
	        <c:out value="${errorMessage}"/>
	    </p>
	</c:if>

    <form action="${pageContext.request.contextPath}/member/signup"
          method="post">
    <input type="hidden" name="signupToken"
       value="${sessionScope.signupToken}">

        <p>
            <label for="email">이메일</label><br>
            <input type="email" id="email" name="email"
                   maxlength="254" autocomplete="email" required>
        </p>

        <p>
            <label for="nickname">닉네임</label><br>
            <input type="text" id="nickname" name="nickname"
                   minlength="2" maxlength="30" required>
        </p>

        <p>
            <label for="password">비밀번호</label><br>
            <input type="password" id="password" name="password"
                   minlength="12" autocomplete="new-password" required>
        </p>

        <p>
            <label for="passwordConfirm">비밀번호 확인</label><br>
            <input type="password" id="passwordConfirm"
                   name="passwordConfirm"
                   minlength="12" autocomplete="new-password" required>
        </p>

        <button type="submit">가입하기</button>
    </form>

    <p>
        <a href="${pageContext.request.contextPath}/home">홈으로</a>
    </p>
</body>
</html>