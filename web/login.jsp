<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login – FunQuiz</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .login-wrap {
            width: 100%; max-width: 420px;
        }
        .login-header { text-align: center; margin-bottom: 36px; }
        .login-header .section-title { font-size: 2.2rem; }
        .login-header p { color: var(--text-muted); margin-top: 8px; font-size: 0.95rem; }

        .divider {
            display: flex; align-items: center; gap: 12px;
            margin: 20px 0; color: var(--text-muted); font-size: 0.8rem;
        }
        .divider::before, .divider::after {
            content: ''; flex: 1; height: 1px; background: var(--border);
        }

        .login-footer {
            text-align: center; margin-top: 24px;
            color: var(--text-muted); font-size: 0.88rem;
        }
        .login-footer a { color: var(--accent); text-decoration: none; font-weight: 600; }
        .login-footer a:hover { text-decoration: underline; }

        .error-box {
            background: rgba(255,77,109,0.1); border: 1px solid rgba(255,77,109,0.3);
            border-radius: 10px; padding: 12px 16px;
            color: var(--red); font-size: 0.88rem; margin-bottom: 20px;
            display: flex; align-items: center; gap: 8px;
        }

        .input-icon-wrap { position: relative; }
        .input-icon-wrap .input-field { padding-left: 44px; }
        .input-icon {
            position: absolute; left: 14px; top: 50%; transform: translateY(-50%);
            font-size: 1rem; color: var(--text-muted);
        }

        .show-password {
            position: absolute; right: 14px; top: 50%; transform: translateY(-50%);
            cursor: pointer; color: var(--text-muted); font-size: 0.8rem;
            background: none; border: none; color: var(--accent); font-weight: 600;
        }
    </style>
</head>
<body>
<div class="page-bg"></div>
<div class="page-grid"></div>

<nav class="qm-nav">
    <a href="index.jsp" class="qm-logo">FunQuiz</a>
    <div class="qm-nav-right">
        <a href="register.jsp" class="btn btn-outline btn-sm">Register</a>
    </div>
</nav>

<div class="page-wrap">
    <div class="login-wrap">

        <div class="login-header anim-up">
            <span class="section-label">Welcome Back</span>
            <h1 class="section-title">Login to Play</h1>
            <p>Pick up where you left off and climb the leaderboard.</p>
        </div>

        <div class="card anim-up-2">

            <% String error = request.getParameter("error"); %>
            <% if ("invalid".equals(error)) { %>
            <div class="error-box">⚠️ Invalid email or password. Please try again.</div>
            <% } %>

            <form action="login" method="post">
                <div class="input-group">
                    <label class="input-label">Email Address</label>
                    <div class="input-icon-wrap">
                        <span class="input-icon">✉️</span>
                        <input type="email" name="email" class="input-field"
                               placeholder="you@example.com" required autocomplete="email">
                    </div>
                </div>

                <div class="input-group">
                    <label class="input-label">Password</label>
                    <div class="input-icon-wrap">
                        <span class="input-icon">🔒</span>
                        <input type="password" name="password" id="passwordField"
                               class="input-field" placeholder="Enter your password"
                               required autocomplete="current-password">
                        <button type="button" class="show-password" onclick="togglePassword()">Show</button>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary btn-full btn-lg" style="margin-top: 8px;">
                    Login →
                </button>
            </form>

            <div class="divider">or</div>

            <a href="register.jsp" class="btn btn-outline btn-full">
                Create a New Account
            </a>
        </div>

        <div class="login-footer anim-up-3">
            Don't have an account? <a href="register.jsp">Register free</a>
        </div>

    </div>
</div>

<script>
function togglePassword() {
    const f = document.getElementById('passwordField');
    const btn = f.nextElementSibling;
    if (f.type === 'password') { f.type = 'text'; btn.textContent = 'Hide'; }
    else { f.type = 'password'; btn.textContent = 'Show'; }
}
</script>
</body>
</html>
