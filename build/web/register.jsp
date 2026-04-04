<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register – FunQuiz</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .register-wrap { width: 100%; max-width: 440px; }
        .register-header { text-align: center; margin-bottom: 36px; }
        .register-header .section-title { font-size: 2.2rem; }
        .register-header p { color: var(--text-muted); margin-top: 8px; font-size: 0.95rem; }

        .register-footer {
            text-align: center; margin-top: 24px;
            color: var(--text-muted); font-size: 0.88rem;
        }
        .register-footer a { color: var(--accent); text-decoration: none; font-weight: 600; }

        .input-icon-wrap { position: relative; }
        .input-icon-wrap .input-field { padding-left: 44px; }
        .input-icon {
            position: absolute; left: 14px; top: 50%; transform: translateY(-50%);
            font-size: 1rem; color: var(--text-muted);
        }

        .perks {
            display: flex; gap: 8px; justify-content: center;
            flex-wrap: wrap; margin-top: 20px;
        }
        .perk {
            display: flex; align-items: center; gap: 6px;
            font-size: 0.78rem; color: var(--text-muted);
        }
        .perk .dot { color: var(--accent3); }
    </style>
</head>
<body>
<div class="page-bg"></div>
<div class="page-grid"></div>

<nav class="qm-nav">
    <a href="index.jsp" class="qm-logo">FunQuiz</a>
    <div class="qm-nav-right">
        <a href="login.jsp" class="btn btn-outline btn-sm">Login</a>
    </div>
</nav>

<div class="page-wrap">
    <div class="register-wrap">

        <div class="register-header anim-up">
            <span class="section-label">Join Free</span>
            <h1 class="section-title">Create Account</h1>
            <p>Start your quiz journey in seconds. No credit card needed.</p>
        </div>

        <div class="card anim-up-2">
            <form action="register" method="post">

                <div class="input-group">
                    <label class="input-label">Full Name</label>
                    <div class="input-icon-wrap">
                        <span class="input-icon">👤</span>
                        <input type="text" name="name" class="input-field"
                               placeholder="Your full name" required>
                    </div>
                </div>

                <div class="input-group">
                    <label class="input-label">Email Address</label>
                    <div class="input-icon-wrap">
                        <span class="input-icon">✉️</span>
                        <input type="email" name="email" class="input-field"
                               placeholder="you@example.com" required>
                    </div>
                </div>

                <div class="input-group">
                    <label class="input-label">Password</label>
                    <div class="input-icon-wrap">
                        <span class="input-icon">🔒</span>
                        <input type="password" name="password" id="pwField"
                               class="input-field" placeholder="Create a password" required>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary btn-full btn-lg" style="margin-top: 8px;">
                    Create Account →
                </button>
            </form>
        </div>

        <div class="perks anim-up-3">
            <span class="perk"><span class="dot">✓</span> 100% Free</span>
            <span class="perk"><span class="dot">✓</span> No spam</span>
            <span class="perk"><span class="dot">✓</span> Instant access</span>
        </div>

        <div class="register-footer anim-up-4" style="margin-top: 16px;">
            Already have an account? <a href="login.jsp">Login here</a>
        </div>

    </div>
</div>
</body>
</html>
