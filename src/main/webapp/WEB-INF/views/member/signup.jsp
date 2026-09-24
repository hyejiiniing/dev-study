<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>회원가입 | DevStudy</title>

<style>
    * {
        box-sizing: border-box;
    }

    body {
        margin: 0;
        color: #171717;
        background: #fafafa;
        font-family: -apple-system, BlinkMacSystemFont,
                     "Apple SD Gothic Neo", "Noto Sans KR", sans-serif;
        -webkit-font-smoothing: antialiased;
    }

    a {
        color: inherit;
        text-decoration: none;
    }

    .header {
        height: 80px;
        padding: 0 6%;
        display: flex;
        align-items: center;
        justify-content: space-between;
        border-bottom: 1px solid #e5e5e5;
        background: #fff;
    }

    .logo {
        display: inline-flex;
        align-items: center;
        gap: 10px;
        font-size: 21px;
        font-weight: 800;
        letter-spacing: -1px;
    }

    .logo-mark {
        display: grid;
        place-items: center;
        width: 32px;
        height: 32px;
        border-radius: 9px;
        color: #fff;
        background: #171717;
        font-family: monospace;
        font-size: 14px;
        letter-spacing: -2px;
    }

    .home-link {
        font-size: 13px;
        color: #595959;
    }

    .home-link:hover {
        color: #171717;
        text-decoration: underline;
    }

    main {
        max-width: 1060px;
        margin: 0 auto;
        padding: 72px 32px;
        display: grid;
        grid-template-columns: 1fr 1fr;
        align-items: center;
        gap: 80px;
    }

    .eyebrow {
        margin: 0 0 24px;
        font-size: 11px;
        font-weight: 700;
        letter-spacing: 3px;
    }

    .intro h1 {
        margin: 0;
        font-size: clamp(38px, 4.5vw, 56px);
        line-height: 1.22;
        font-weight: 800;
        letter-spacing: -3px;
        word-break: keep-all;
    }

    .intro-text {
        margin: 24px 0 36px;
        color: #626262;
        font-size: 15px;
        line-height: 1.9;
        word-break: keep-all;
    }

    .code-card {
        padding: 24px;
        border: 1px solid #dedede;
        border-radius: 16px;
        background: #fff;
        box-shadow: 0 12px 30px rgba(0, 0, 0, .025);
    }

    .code-header {
        display: flex;
        align-items: center;
        gap: 6px;
        padding-bottom: 20px;
    }

    .dot {
        width: 7px;
        height: 7px;
        border-radius: 50%;
        background: #d4d4d4;
    }

    .code-label {
        margin-left: auto;
        color: #737373;
        font-family: monospace;
        font-size: 11px;
    }

    .code-card pre {
        margin: 0;
        white-space: pre-wrap;
        font-family: "SFMono-Regular", Consolas, monospace;
        font-size: 13px;
        line-height: 1.9;
    }

    .code-comment {
        color: #737373;
    }

    .intro-note {
        margin: 18px 0 0;
        color: #707070;
        font-size: 12px;
        letter-spacing: .2px;
    }

    .signup-card {
        padding: 38px;
        background: #fff;
        border: 1px solid #e5e5e5;
        border-radius: 22px;
        box-shadow: 0 20px 60px rgba(0, 0, 0, .04);
    }

    .step-label {
        display: inline-block;
        margin-bottom: 16px;
        padding: 6px 10px;
        border: 1px solid #dedede;
        border-radius: 6px;
        font-size: 10px;
        font-weight: 700;
        letter-spacing: 1.5px;
    }

    .signup-card h2 {
        margin: 0 0 10px;
        font-size: 28px;
        letter-spacing: -1px;
    }

    .description {
        margin: 0 0 30px;
        color: #666;
        font-size: 13px;
        line-height: 1.7;
    }

    .error-message {
        margin-bottom: 24px;
        padding: 14px 16px;
        border: 1px solid #171717;
        border-left-width: 4px;
        border-radius: 8px;
        background: #f5f5f5;
        font-size: 13px;
        line-height: 1.6;
        overflow-wrap: anywhere;
    }

    .field {
        margin-bottom: 20px;
    }

    label {
        display: block;
        margin-bottom: 9px;
        font-size: 13px;
        font-weight: 600;
    }

    input:not([type="hidden"]) {
        width: 100%;
        height: 49px;
        padding: 0 14px;
        border: 1px solid #d9d9d9;
        border-radius: 9px;
        background: #fff;
        color: #171717;
        font: inherit;
        font-size: 14px;
        transition: border-color .15s, box-shadow .15s;
    }

    input::placeholder {
        color: #858585;
    }

    input:not([type="hidden"]):focus {
        outline: none;
        border-color: #171717;
        box-shadow: 0 0 0 3px rgba(0, 0, 0, .07);
    }

    .hint {
        margin: 7px 0 0;
        color: #707070;
        font-size: 11px;
        line-height: 1.6;
    }

    .submit-button {
        width: 100%;
        min-height: 50px;
        margin-top: 8px;
        padding: 14px 18px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        border: 1px solid #171717;
        border-radius: 9px;
        color: #fff;
        background: #171717;
        font: inherit;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        transition: background .15s;
    }

    .submit-button:hover {
        background: #353535;
    }

    a:focus-visible,
    button:focus-visible {
        outline: 2px solid #171717;
        outline-offset: 4px;
    }

    .form-note {
        margin: 20px 0 0;
        text-align: center;
        color: #707070;
        font-size: 12px;
        line-height: 1.6;
    }

    footer {
        padding: 24px;
        border-top: 1px solid #e5e5e5;
        text-align: center;
        color: #707070;
        font-size: 11px;
        letter-spacing: 1px;
    }

    @media (max-width: 800px) {
        main {
            max-width: 520px;
            grid-template-columns: 1fr;
            gap: 32px;
            padding: 40px 20px;
        }

        .intro h1 {
            font-size: 38px;
            letter-spacing: -2px;
        }

        .intro-text {
            margin: 18px 0 0;
        }

        .code-card,
        .intro-note {
            display: none;
        }

        .signup-card {
            padding: 28px 24px;
        }

        .header {
            height: 68px;
            padding: 0 24px;
        }

        .eyebrow {
            margin-bottom: 16px;
        }
    }
</style>
</head>

<body>
    <header class="header">
        <a class="logo"
           href="${pageContext.request.contextPath}/home">
            <span class="logo-mark" aria-hidden="true">&lt;/&gt;</span>
            DevStudy
        </a>

        <a class="home-link"
           href="${pageContext.request.contextPath}/home">
            홈으로 돌아가기 ↗
        </a>
    </header>

    <main>
        <section class="intro" aria-labelledby="intro-title">
            <p class="eyebrow">LEARN. BUILD. TOGETHER.</p>

            <h1 id="intro-title">
                함께 배우고,<br>
                더 멀리 만들다.
            </h1>

            <p class="intro-text">
                혼자 풀리지 않던 문제도 함께라면.<br>
                스터디를 찾고, 배운 것을 나누고,<br>
                다음 프로젝트를 시작해보세요.
            </p>

            <div class="code-card">
                <div class="code-header">
                    <span class="dot"></span>
                    <span class="dot"></span>
                    <span class="dot"></span>
                    <span class="code-label">hello-devstudy.js</span>
                </div>
                <pre><span class="code-comment">// 성장은 함께할 때 더 즐거우니까</span>
const developer = {
  curiosity: true,
  community: "DevStudy"
};</pre>
            </div>

            <p class="intro-note">개발자를 위한 작은 시작, DevStudy.</p>
        </section>

        <section class="signup-card" aria-labelledby="signup-title">
            <span class="step-label">JOIN THE COMMUNITY</span>

            <h2 id="signup-title">회원가입</h2>
            <p class="description">
                나의 다음 성장을 함께할 공간을 만나보세요.
            </p>

            <c:if test="${not empty errorMessage}">
                <div class="error-message" role="alert">
                    <c:out value="${errorMessage}"/>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/member/signup"
                  method="post">

                <input type="hidden" name="signupToken"
                       value="${sessionScope.signupToken}">

                <div class="field">
                    <label for="email">이메일</label>
                    <input type="email" id="email" name="email"
                           placeholder="you@example.com"
                           maxlength="254"
                           autocomplete="email" required>
                </div>

                <div class="field">
                    <label for="nickname">닉네임</label>
                    <input type="text" id="nickname" name="nickname"
                           placeholder="함께 부를 이름을 알려주세요"
                           minlength="2" maxlength="10"
                           aria-describedby="nickname-hint" required>
                    <p class="hint" id="nickname-hint">
                        2~10자로 입력해주세요.
                    </p>
                </div>

                <div class="field">
                    <label for="password">비밀번호</label>
                    <input type="password" id="password" name="password"
                           placeholder="10자 이상 입력해주세요"
                           minlength="10"
                           autocomplete="new-password"
                           aria-describedby="password-hint" required>
                    <p class="hint" id="password-hint">
                        10자 이상, 영문·숫자·기호 조합을 권장해요.
                        한글 포함 시 최대 길이가 달라질 수 있어요.
                    </p>
                </div>

                <div class="field">
                    <label for="passwordConfirm">비밀번호 확인</label>
                    <input type="password" id="passwordConfirm"
                           name="passwordConfirm"
                           placeholder="비밀번호를 한 번 더 입력해주세요"
                           minlength="10"
                           autocomplete="new-password" required>
                </div>

                <button class="submit-button" type="submit">
                    <span>DevStudy 시작하기</span>
                    <span aria-hidden="true">→</span>
                </button>

                <p class="form-note">
                    첫 스터디, 첫 질문, 첫 번째 성장.
                </p>
            </form>
        </section>
    </main>

    <footer>DEVSTUDY · BUILT TO LEARN TOGETHER</footer>
</body>
</html>