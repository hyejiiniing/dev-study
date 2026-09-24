<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>DevStudy | 함께 만드는 성장</title>

<style>
    :root {
        --ink: #171717;
        --muted: #686868;
        --line: #e5e5e5;
        --paper: #fafafa;
    }

    * {
        box-sizing: border-box;
    }

    body {
        margin: 0;
        background: var(--paper);
        color: var(--ink);
        font-family: -apple-system, BlinkMacSystemFont,
                     "Apple SD Gothic Neo", sans-serif;
        -webkit-font-smoothing: antialiased;
    }

    a {
        color: inherit;
        text-decoration: none;
    }

    .container {
        width: min(1120px, calc(100% - 48px));
        margin: 0 auto;
    }

    .header {
        border-bottom: 1px solid var(--line);
        background: #fff;
    }

    .header-inner {
        min-height: 80px;
        display: flex;
        align-items: center;
        gap: 44px;
    }

    .logo {
        display: inline-flex;
        align-items: center;
        gap: 10px;
        flex-shrink: 0;
        font-size: 22px;
        font-weight: 800;
        letter-spacing: -1px;
    }

    .logo-mark {
        display: grid;
        place-items: center;
        width: 34px;
        height: 34px;
        border-radius: 10px;
        background: var(--ink);
        color: #fff;
        font-family: monospace;
        font-size: 15px;
    }

    .nav {
        display: flex;
        gap: 28px;
        font-size: 14px;
        font-weight: 600;
    }

    .nav a {
        color: #626262;
    }

    .nav a:hover {
        color: #000;
        text-decoration: underline;
        text-underline-offset: 6px;
    }

    .account {
        margin-left: auto;
        display: flex;
        align-items: center;
        gap: 16px;
        font-size: 13px;
    }

    .account-name {
        max-width: 180px;
        overflow-wrap: anywhere;
    }

    .small-button {
        padding: 11px 16px;
        border-radius: 8px;
        background: var(--ink);
        color: #fff;
        font-weight: 600;
    }

    .notice {
        margin-top: 24px;
        padding: 16px 20px;
        border: 1px solid var(--ink);
        border-radius: 10px;
        background: #fff;
        font-size: 14px;
    }

    .hero {
        display: grid;
        grid-template-columns: 1.25fr .85fr;
        align-items: center;
        gap: 70px;
        padding: 88px 0 76px;
    }

    .eyebrow {
        display: flex;
        align-items: center;
        gap: 9px;
        margin: 0 0 26px;
        font-size: 10px;
        font-weight: 700;
        letter-spacing: 2.5px;
    }

    .status-dot {
        width: 6px;
        height: 6px;
        border-radius: 50%;
        background: var(--ink);
    }

    h1 {
        margin: 0;
        font-size: clamp(40px, 4.8vw, 62px);
        font-weight: 800;
        line-height: 1.2;
        letter-spacing: -3.5px;
        word-break: keep-all;
    }

    .hero-description {
        margin: 26px 0 30px;
        color: var(--muted);
        font-size: 15px;
        line-height: 1.9;
        word-break: keep-all;
    }

    .hero-actions {
        display: flex;
        flex-wrap: wrap;
        gap: 10px;
    }

    .button {
        min-height: 48px;
        padding: 14px 20px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 22px;
        border: 1px solid var(--ink);
        border-radius: 9px;
        font-size: 13px;
        font-weight: 600;
        transition: background .15s;
    }

    .button-dark {
        color: #fff;
        background: var(--ink);
    }

    .button-dark:hover,
    .small-button:hover {
        background: #383838;
    }

    .button-light {
        background: #fff;
        border-color: #d7d7d7;
    }

    .button-light:hover {
        background: #f0f0f0;
    }

    .member-count {
        margin-top: 23px;
        color: var(--muted);
        font-size: 12px;
    }

    .member-count strong {
        color: var(--ink);
    }

    /* 홈의 장식용 코드 카드 */
    .terminal {
        overflow: hidden;
        border: 1px solid #333;
        border-radius: 18px;
        background: #171717;
        color: #f5f5f5;
        box-shadow: 12px 16px 0 #e9e9e9;
        transform: rotate(2deg);
    }

    .terminal-top {
        display: flex;
        align-items: center;
        gap: 6px;
        padding: 18px 20px;
        border-bottom: 1px solid #353535;
    }

    .terminal-dot {
        width: 7px;
        height: 7px;
        border-radius: 50%;
        background: #737373;
    }

    .terminal-title {
        margin-left: auto;
        color: #b6b6b6;
        font-family: monospace;
        font-size: 11px;
    }

    .terminal pre {
        margin: 0;
        padding: 28px 24px 18px;
        white-space: pre-wrap;
        font-family: "SFMono-Regular", Consolas, monospace;
        font-size: 13px;
        line-height: 2;
    }

    .code-muted {
        color: #aaa;
    }

    .terminal-bottom {
        margin: 0 24px 24px;
        padding-top: 18px;
        border-top: 1px solid #353535;
        color: #c7c7c7;
        font-family: monospace;
        font-size: 11px;
    }

    .topic-strip {
        display: flex;
        align-items: center;
        flex-wrap: wrap;
        gap: 10px;
        padding: 22px 0;
        border-top: 1px solid var(--line);
        border-bottom: 1px solid var(--line);
    }

    .topic-label {
        margin-right: auto;
        font-size: 10px;
        font-weight: 700;
        letter-spacing: 2px;
    }

    .tag {
        padding: 7px 12px;
        border: 1px solid #dedede;
        border-radius: 30px;
        color: #555;
        background: #fff;
        font-size: 11px;
    }

    .section {
        padding: 58px 0 0;
        scroll-margin-top: 24px;
    }

    .section-heading {
        display: flex;
        align-items: flex-end;
        justify-content: space-between;
        gap: 20px;
        margin-bottom: 24px;
    }

    .section-kicker {
        margin: 0 0 9px;
        font-size: 10px;
        font-weight: 700;
        letter-spacing: 2px;
        color: var(--muted);
    }

    h2 {
        margin: 0;
        font-size: 27px;
        letter-spacing: -1px;
    }

    .section-description {
        margin: 10px 0 0;
        color: var(--muted);
        font-size: 13px;
        line-height: 1.7;
    }

    .badge {
        flex-shrink: 0;
        padding: 6px 10px;
        border: 1px solid #d7d7d7;
        border-radius: 6px;
        color: #626262;
        font-size: 10px;
        font-weight: 600;
    }

    .empty-study {
        min-height: 225px;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        padding: 36px 24px;
        border: 1px dashed #c8c8c8;
        border-radius: 16px;
        background: #fff;
        text-align: center;
    }

    .empty-icon {
        width: 46px;
        height: 46px;
        margin-bottom: 18px;
        display: grid;
        place-items: center;
        border: 1px solid var(--line);
        border-radius: 12px;
        font-family: monospace;
        font-size: 19px;
    }

    .empty-study h3 {
        margin: 0 0 10px;
        font-size: 17px;
        letter-spacing: -.5px;
    }

    .empty-study p {
        margin: 0;
        color: var(--muted);
        font-size: 13px;
        line-height: 1.8;
        word-break: keep-all;
    }

    .board-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 24px;
        padding: 28px 0 60px;
    }

    .board-card {
        padding: 28px;
        border: 1px solid var(--line);
        border-radius: 16px;
        background: #fff;
        scroll-margin-top: 24px;
    }

    .board-top {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 16px;
    }

    .board-card h2 {
        font-size: 21px;
    }

    .board-card .section-description {
        min-height: 44px;
        margin-bottom: 24px;
    }

    .board-placeholder {
        padding: 24px 0 4px;
        border-top: 1px solid #ededed;
        color: #707070;
        font-size: 13px;
        line-height: 1.8;
    }

    .closing {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 24px;
        margin-bottom: 64px;
        padding: 34px;
        border-radius: 16px;
        background: #ededed;
    }

    .closing h2 {
        font-size: 23px;
        line-height: 1.5;
        word-break: keep-all;
    }

    .closing p {
        margin: 8px 0 0;
        color: #626262;
        font-size: 13px;
        line-height: 1.7;
    }

    .closing .button {
        flex-shrink: 0;
    }

    footer {
        border-top: 1px solid var(--line);
        background: #fff;
    }

    .footer-inner {
        min-height: 90px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 20px;
    }

    .footer-name {
        font-size: 16px;
        font-weight: 800;
        letter-spacing: -.5px;
    }

    .footer-note {
        color: #707070;
        font-size: 11px;
        line-height: 1.8;
    }

    a:focus-visible {
        outline: 2px solid var(--ink);
        outline-offset: 5px;
    }

    @media (max-width: 900px) {
        .header-inner {
            flex-wrap: wrap;
            gap: 18px;
            padding: 18px 0;
        }

        .nav {
            order: 3;
            width: 100%;
            gap: 24px;
            padding-top: 12px;
            border-top: 1px solid #eee;
            font-size: 13px;
        }

        .hero {
            gap: 35px;
            padding: 60px 0;
        }

        .terminal pre {
            font-size: 11px;
            padding: 22px 18px;
        }
    }

    @media (max-width: 680px) {
        .container {
            width: calc(100% - 40px);
        }

        .hero {
            grid-template-columns: 1fr;
            padding: 48px 0;
        }

        h1 {
            font-size: 43px;
            letter-spacing: -2.5px;
        }

        .terminal {
            width: calc(100% - 12px);
            max-width: 420px;
            margin: 8px auto 12px;
            transform: none;
        }

        .terminal pre {
            font-size: 12px;
        }

        .topic-label {
            width: 100%;
            margin-bottom: 6px;
        }

        .board-grid {
            grid-template-columns: 1fr;
            gap: 16px;
            padding-bottom: 36px;
        }

        .section {
            padding-top: 38px;
        }

        .closing {
            align-items: flex-start;
            flex-direction: column;
            padding: 26px;
            margin-bottom: 36px;
        }

        .footer-inner {
            padding: 24px 0;
            align-items: flex-start;
            flex-direction: column;
            gap: 10px;
        }

        .account {
            gap: 10px;
            font-size: 12px;
        }

        .account-name {
            max-width: 130px;
        }

        .small-button {
            padding: 10px 12px;
        }
    }
</style>
</head>

<body>
<header class="header">
    <div class="container header-inner">
        <a class="logo"
           href="${pageContext.request.contextPath}/home">
            <span class="logo-mark" aria-hidden="true">&lt;/&gt;</span>
            DevStudy
        </a>

        <nav class="nav" aria-label="메뉴">
            <a href="${pageContext.request.contextPath}/board/list?boardType=1">커뮤니티</a>
			<a href="${pageContext.request.contextPath}/board/list?boardType=2">AI</a>
			<a href="${pageContext.request.contextPath}/board/list?boardType=3">자격증</a>
			<a href="${pageContext.request.contextPath}/board/list?boardType=4">모임</a>
			<a href="${pageContext.request.contextPath}/board/list?boardType=5">Q&amp;A</a>
			<a href="${pageContext.request.contextPath}/board/list?boardType=6">공지사항</a>
        </nav>

        <div class="account">
            <c:choose>
                <c:when test="${not empty sessionScope.loginMemberIdx}">
                    <span class="account-name">
                        <strong>
                            <c:out value="${sessionScope.loginNickname}"/>
                        </strong>님
                    </span>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/member/signin">
                        로그인
                    </a>
                    <a class="small-button"
                       href="${pageContext.request.contextPath}/member/signup">
                        회원가입 ↗
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>

<main class="container">
    <c:if test="${not empty successMessage}">
        <div class="notice" role="status">
            <c:out value="${successMessage}"/>
        </div>
    </c:if>

    <section class="hero" aria-labelledby="hero-title">
        <div>
            <p class="eyebrow">
                <span class="status-dot" aria-hidden="true"></span>
                A SPACE FOR DEVELOPERS
            </p>

            <h1 id="hero-title">
                혼자 공부하던 코드,<br>
                함께 만드는 성장.
            </h1>

            <p class="hero-description">
                같은 목표를 가진 개발자를 만나세요.<br>
                함께 공부하고, 기록을 나누고,<br>
                서로의 다음 단계를 만들어갑니다.
            </p>

            <div class="hero-actions">
                <a class="button button-dark" href="#studies">
                    스터디 둘러보기 <span aria-hidden="true">↗</span>
                </a>

                <a class="button button-light" href="#resources">
                    자료 구경하기 <span aria-hidden="true">→</span>
                </a>
            </div>

            <c:if test="${not empty memberCount}">
                <p class="member-count">
                    함께하는 개발자
                    <strong><c:out value="${memberCount}"/>명</strong>
                </p>
            </c:if>
        </div>

        <div class="terminal" aria-label="DevStudy를 소개하는 코드 일러스트">
            <div class="terminal-top">
                <span class="terminal-dot"></span>
                <span class="terminal-dot"></span>
                <span class="terminal-dot"></span>
                <span class="terminal-title">our-next-chapter.js</span>
            </div>

            <pre><span class="code-muted">// 오늘도 한 걸음 더.</span>
const study = {
  goal: "grow together",
  members: ["you", "me"],
  questions: Infinity
};

<span class="code-muted">// 작은 질문이, 큰 시작이 된다.</span>
study.members.push("next developer");</pre>

            <div class="terminal-bottom">
                &gt; Ready to build something together _
            </div>
        </div>
    </section>

    <div class="topic-strip" aria-label="함께 공부할 주제">
        <span class="topic-label">WHAT WE LEARN</span>
        <span class="tag">Java</span>
        <span class="tag">Spring</span>
        <span class="tag">JavaScript</span>
        <span class="tag">SQL</span>
        <span class="tag">알고리즘</span>
        <span class="tag">프로젝트</span>
    </div>

    <section class="section" id="studies" aria-labelledby="studies-title">
        <div class="section-heading">
            <div>
                <p class="section-kicker">FIND YOUR PEOPLE</p>
                <h2 id="studies-title">함께할 스터디</h2>
                <p class="section-description">
                    혼자보다 꾸준하게, 같은 목표를 향해.
                </p>
            </div>
            <span class="badge">준비 중</span>
        </div>

        <div class="empty-study">
            <div class="empty-icon" aria-hidden="true">{ }</div>
            <h3>새로운 만남을 준비하고 있어요.</h3>
            <p>
                배우고 싶은 기술과 함께하고 싶은 목표.<br>
                곧 이곳에서 스터디를 모집하고 찾아볼 수 있어요.
            </p>
        </div>
    </section>

    <div class="board-grid">
        <section class="board-card" id="resources"
                 aria-labelledby="resources-title">
            <p class="section-kicker">SHARE YOUR KNOWLEDGE</p>

            <div class="board-top">
                <h2 id="resources-title">자료 공유</h2>
                <span class="badge">준비 중</span>
            </div>

            <p class="section-description">
                나에게 도움이 된 기록이<br>
                누군가에게는 좋은 출발점이 됩니다.
            </p>

            <div class="board-placeholder">
                공부 노트, 참고 링크, 프로젝트 자료를<br>
                함께 나눌 공간을 만들고 있어요.
            </div>
        </section>

        <section class="board-card" id="community"
                 aria-labelledby="community-title">
            <p class="section-kicker">TALK WITH DEVELOPERS</p>

            <div class="board-top">
                <h2 id="community-title">자유게시판</h2>
                <span class="badge">준비 중</span>
            </div>

            <p class="section-description">
                막혔던 코드부터 소소한 개발 일상까지.<br>
                편하게 이야기 나눠요.
            </p>

            <div class="board-placeholder">
                질문과 경험이 모여<br>
                새로운 아이디어가 되는 공간입니다.
            </div>
        </section>
    </div>

    <section class="closing" aria-labelledby="closing-title">
        <div>
            <h2 id="closing-title">오늘의 작은 배움이, 내일의 실력으로.</h2>
            <p>완벽하지 않아도 괜찮아요. 함께 시작해요.</p>
        </div>

        <c:choose>
            <c:when test="${not empty sessionScope.loginMemberIdx}">
                <a class="button button-dark" href="#studies">
                    커뮤니티 둘러보기 <span aria-hidden="true">↗</span>
                </a>
            </c:when>
            <c:otherwise>
                <a class="button button-dark"
                   href="${pageContext.request.contextPath}/member/signup">
                    DevStudy 시작하기 <span aria-hidden="true">↗</span>
                </a>
            </c:otherwise>
        </c:choose>
    </section>
</main>

<footer>
    <div class="container footer-inner">
        <span class="footer-name">DevStudy.</span>
        <span class="footer-note">
            개발자를 위한 배움과 연결의 공간.<br>
            LEARN. BUILD. TOGETHER.
        </span>
    </div>
</footer>
</body>
</html>