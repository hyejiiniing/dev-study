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

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            background: #fff;
            color: #171717;
            font-family: -apple-system, BlinkMacSystemFont,
                         "Segoe UI", sans-serif;
            -webkit-font-smoothing: antialiased;
        }

        a {
            color: inherit;
            text-decoration: none;
        }

        button {
            font: inherit;
        }

        .header {
            height: 76px;
            border-bottom: 1px solid #ededed;
        }

        .header-inner {
            max-width: 1080px;
            height: 100%;
            margin: 0 auto;
            padding: 0 24px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .logo {
            font-size: 22px;
            font-weight: 800;
            letter-spacing: -1px;
        }

        .home-link {
            font-size: 13px;
            color: #666;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
            padding: 76px 24px 100px;
        }

        .eyebrow {
            margin: 0 0 14px;
            color: #777;
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 3px;
        }

        h1 {
            margin: 0;
            font-size: 48px;
            letter-spacing: -2px;
        }

        .intro {
            margin: 18px 0 40px;
            color: #777;
            font-size: 15px;
            line-height: 1.8;
        }

        .tabs {
            display: flex;
            gap: 28px;
            margin-bottom: 36px;
            border-bottom: 1px solid #e8e8e8;
        }

        .tab {
            padding: 16px 0;
            border: 0;
            border-bottom: 2px solid transparent;
            background: transparent;
            color: #888;
            font-size: 14px;
            cursor: pointer;
        }

        .tab.active {
            border-bottom-color: #171717;
            color: #171717;
            font-weight: 700;
        }

        .section-title {
            margin: 0 0 18px;
            font-size: 16px;
        }

        .faq-list {
            border-top: 1px solid #171717;
        }

        .faq-item {
            border-bottom: 1px solid #e8e8e8;
        }

        .faq-question {
            display: flex;
            align-items: center;
            gap: 18px;
            padding: 25px 8px;
            cursor: pointer;
            list-style: none;
        }

        .faq-question::-webkit-details-marker {
            display: none;
        }

        .question-label {
            flex-shrink: 0;
            font-size: 16px;
            font-weight: 800;
        }

        .question-title {
            flex: 1;
            min-width: 0;
            font-size: 15px;
            font-weight: 600;
            line-height: 1.6;
            overflow-wrap: anywhere;
        }

        .toggle-icon {
            position: relative;
            flex-shrink: 0;
            width: 16px;
            height: 16px;
            margin-left: 10px;
        }

        .toggle-icon::before,
        .toggle-icon::after {
            content: "";
            position: absolute;
            background: #555;
        }

        .toggle-icon::before {
            top: 7px;
            left: 1px;
            width: 14px;
            height: 2px;
        }

        .toggle-icon::after {
            top: 1px;
            left: 7px;
            width: 2px;
            height: 14px;
        }

        .faq-item[open] .toggle-icon::after {
            display: none;
        }

        .faq-item[open] .faq-question {
            padding-bottom: 20px;
        }

        .faq-answer {
            display: flex;
            gap: 18px;
            padding: 24px;
            margin-bottom: 20px;
            border-radius: 12px;
            background: #f7f7f7;
        }

        .answer-label {
            flex-shrink: 0;
            padding-top: 2px;
            color: #888;
            font-size: 15px;
            font-weight: 700;
        }

        .answer-content {
            min-width: 0;
            margin: 0;
            color: #555;
            font-size: 14px;
            line-height: 1.9;
            white-space: pre-wrap;
            overflow-wrap: anywhere;
        }

        .empty {
            padding: 72px 20px;
            text-align: center;
        }

        .empty-title {
            margin: 0 0 10px;
            font-size: 16px;
            font-weight: 600;
        }

        .empty-description {
            margin: 0;
            color: #888;
            font-size: 14px;
        }

        .help-box {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 24px;
            margin-top: 40px;
            padding: 28px;
            border: 1px solid #e8e8e8;
            border-radius: 14px;
        }

        .help-title {
            margin: 0 0 8px;
            font-size: 14px;
            font-weight: 700;
        }

        .help-description {
            margin: 0;
            color: #888;
            font-size: 13px;
            line-height: 1.7;
        }

        .inquiry-button {
            flex-shrink: 0;
            padding: 12px 20px;
            border: 1px solid #171717;
            border-radius: 8px;
            background: #171717;
            color: #fff;
            font-size: 13px;
            cursor: pointer;
        }

        a:focus-visible,
        button:focus-visible,
        summary:focus-visible {
            outline: 2px solid #171717;
            outline-offset: 5px;
        }

        @media (max-width: 600px) {
            .container {
                padding-top: 48px;
            }

            h1 {
                font-size: 38px;
            }

            .faq-question {
                gap: 12px;
            }

            .faq-answer {
                padding: 20px 16px;
                gap: 12px;
            }

            .help-box {
                align-items: flex-start;
                flex-direction: column;
            }
        }
    </style>
</head>

<body>
    <header class="header">
        <div class="header-inner">
            <a class="logo"
               href="${pageContext.request.contextPath}/">
                DevStudy<span>.</span>
            </a>

            <a class="home-link"
               href="${pageContext.request.contextPath}/">
                홈으로 돌아가기 &rarr;
            </a>
        </div>
    </header>

    <main class="container">
        <p class="eyebrow">HELP CENTER</p>
        <h1>Q&amp;A</h1>
        <p class="intro">
            궁금한 점이 있으신가요?<br>
            자주 묻는 질문에서 먼저 확인해보세요.
        </p>

        <nav class="tabs" aria-label="Q&A 메뉴">
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
                                        <c:out value="${faq.title}"/>
                                    </span>

                                    <span class="toggle-icon"
                                          aria-hidden="true"></span>
                                </summary>

                                <div class="faq-answer">
                                    <span class="answer-label"
                                          aria-hidden="true">A.</span>
                                    <p class="answer-content"><c:out value="${faq.content}"/></p>
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