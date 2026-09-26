<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Q&amp;A | DevStudy</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/faq.css?v=2">
</head>

<body class="faq-screen">
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>

    <main class="faq-page">
        <p class="eyebrow">HELP CENTER</p>
        <h1>Q&amp;A</h1>
        <p class="intro">
            궁금한 점이 있으신가요?<br>
            자주 묻는 질문에서 먼저 확인해보세요.
        </p>

        <nav class="tabs" aria-label="Q&amp;A 메뉴">
            <a class="tab active"
               aria-current="page"
               href="${pageContext.request.contextPath}/board/list?boardType=5">
                자주 묻는 질문
            </a>

            <button class="tab"
                    type="button"
                    onclick="showInquiryNotice()">
                문의하기
            </button>
        </nav>

        <section aria-labelledby="faq-heading">
            <h2 class="section-title" id="faq-heading">
                자주 묻는 질문
            </h2>

            <div class="faq-list">
                <c:choose>
                    <c:when test="${empty faqList}">
                        <div class="empty">
                            <p class="empty-title">
                                등록된 질문이 없습니다.
                            </p>
                            <p class="empty-description">
                                자주 묻는 질문을 준비하고 있어요.
                            </p>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <c:forEach var="faq" items="${faqList}">
                            <details class="faq-item">
                                <summary class="faq-question">
                                    <span class="question-label"
                                          aria-hidden="true">Q.</span>

                                    <span class="question-title">
                                        <c:out value="${faq.question}"/>
                                    </span>

                                    <span class="toggle-icon"
                                          aria-hidden="true"></span>
                                </summary>

                                <div class="faq-answer">
                                    <span class="answer-label"
                                          aria-hidden="true">A.</span>
                                    <p class="answer-content"><c:out value="${faq.answer}"/></p>
                                </div>
                            </details>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>

        <aside class="help-box">
            <div>
                <p class="help-title">
                    찾으시는 답변이 없나요?
                </p>
                <p class="help-description">
                    문의를 남겨주시면 확인 후 답변드릴게요.
                </p>
            </div>

            <button class="inquiry-button"
                    type="button"
                    onclick="showInquiryNotice()">
                문의하기 &rarr;
            </button>
        </aside>
    </main>

    <script>
        function showInquiryNotice() {
            alert("문의하기 기능은 준비 중입니다.");
        }
    </script>
</body>
</html>