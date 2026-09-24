<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>DevStudy</title>
</head>
<body>
<c:choose>
    <c:when test="${not empty sessionScope.loginMemberIdx}">
        <p>
            <strong>
                <c:out value="${sessionScope.loginNickname}"/>
            </strong>님, 반가워요!
        </p>
    </c:when>

    <c:otherwise>
        <a href="${pageContext.request.contextPath}/member/signin">
            로그인
        </a>
    </c:otherwise>
</c:choose>
<c:if test="${not empty successMessage}">
    <p role="status">
        <c:out value="${successMessage}"/>
    </p>
</c:if>
    <h1>DevStudy</h1>
    <p>Spring MVC 연결 성공!</p>
    <p>개발자들이 함께 공부하는 커뮤니티입니다.</p>
</body>
</html>