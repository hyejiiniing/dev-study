<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>로그인 | DevStudy</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            background: #fafafa;
            color: #171717;
            font-family: -apple-system, BlinkMacSystemFont,
                         "Apple SD Gothic Neo", sans-serif;
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
            background: #171717;
            color: #fff;
            font-family: monospace;
            font-size: 14px;
        }

        .home-link {
            font-size: 13px;
            color: #595959;
        }

        main {
            min-height: calc(100svh - 140px);
            padding: 64px 20px;
            display: grid;
            place-items: center;
        }

        .signin-card {
            width: 100%;
            max-width: 440px;
            padding: 40px;
            border: 1px solid #e5e5e5;
            border-radius: 22px;
            background: #fff;
            box-shadow: 0 20px 60px rgba(0, 0, 0, .04);
        }

        .eyebrow {
            margin: 0 0 18px;
            font-size: 10px;
            font-weight: 700;
            letter-spacing: 2px;
        }

        h1 {
            margin: 0 0 12px;
            font-size: 30px;
            letter-spacing: -1.5px;
        }

        .description {
            margin: 0 0 32px;
            color: #666;
            font-size: 14px;
            line-height: 1.8;
        }

        .field {
            margin-bottom: 22px;
        }

        label {
            display: block;
            margin-bottom: 9px;
            font-size: 13px;
            font-weight: 600;
        }

        input {
            width: 100%;
            height: 50px;
            padding: 0 14px;
            border: 1px solid #d9d9d9;
            border-radius: 9px;
            background: #fff;
            color: #171717;
            font: inherit;
            font-size: 14px;
        }

        input::placeholder {
            color: #858585;
        }

        input:focus {
            outline: none;
            border-color: #171717;
            box-shadow: 0 0 0 3px rgba(0, 0, 0, .07);
        }

        .submit-button {
            width: 100%;
            min-height: 50px;
            margin-top: 6px;
            padding: 14px 18px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border: 1px solid #171717;
            border-radius: 9px;
            background: #171717;
            color: #fff;
            font: inherit;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
        }

        .submit-button:hover {
            background: #353535;
        }

        a:focus-visible,
        button:focus-visible {
            outline: 2px solid #171717;
            outline-offset: 4px;
        }

        .error-message {
            margin-bottom: 24px;
            padding: 14px;
            border: 1px solid #171717;
            border-left-width: 4px;
            border-radius: 8px;
            background: #f5f5f5;
            font-size: 13px;
            line-height: 1.6;
        }

        .signup-link {
            margin: 28px 0 0;
            padding-top: 24px;
            border-top: 1px solid #ededed;
            text-align: center;
            color: #666;
            font-size: 13px;
            line-height: 1.8;
        }

        .signup-link a {
            margin-left: 6px;
            color: #171717;
            font-weight: 700;
            text-decoration: underline;
            text-underline-offset: 4px;
        }

        footer {
            padding: 22px;
            border-top: 1px solid #e5e5e5;
            text-align: center;
            color: #707070;
            font-size: 11px;
            letter-spacing: 1px;
        }

        @media (max-width: 480px) {
            .header {
                height: 68px;
                padding: 0 24px;
            }

            main {
                padding: 36px 20px;
            }

            .signin-card {
                padding: 32px 24px;
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
        <section class="signin-card" aria-labelledby="signin-title">
            <p class="eyebrow">WELCOME BACK</p>

            <h1 id="signin-title">다시 만나 반가워요.</h1>
            <p class="description">
                오늘의 배움도 DevStudy와 함께 시작해요.
            </p>

            <c:if test="${not empty errorMessage}">
                <div class="error-message" role="alert">
                    <c:out value="${errorMessage}"/>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/member/signin"
                  method="post">
            <input type="hidden" name="signinToken"
       			   value="${sessionScope.signinToken}">

                <div class="field">
                    <label for="email">이메일</label>
                    <input type="email" id="email" name="email"
                           placeholder="you@example.com"
                           maxlength="254"
                           autocomplete="username" required>
                </div>

                <div class="field">
                    <label for="password">비밀번호</label>
                    <input type="password" id="password" name="password"
                           placeholder="비밀번호를 입력해주세요"
                           autocomplete="current-password" required>
                </div>

                <button class="submit-button" type="submit">
                    <span>로그인</span>
                    <span aria-hidden="true">→</span>
                </button>
            </form>

            <p class="signup-link">
                아직 계정이 없나요?
                <a href="${pageContext.request.contextPath}/member/signup">
                    회원가입
                </a>
            </p>
        </section>
    </main>

    <footer>DEVSTUDY · BUILT TO LEARN TOGETHER</footer>
</body>
</html>