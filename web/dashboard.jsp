<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String userEmail = (String) session.getAttribute("user");
    String userName = userEmail != null ? userEmail.split("@")[0] : "Player";
    // Capitalize first letter
    userName = Character.toUpperCase(userName.charAt(0)) + userName.substring(1);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard – FunQuiz</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .dashboard-wrap {
            width: 100%; max-width: 800px; padding-top: 40px;
        }

        .welcome-banner {
            background: linear-gradient(135deg, rgba(108,99,255,0.15), rgba(255,101,132,0.08));
            border: 1px solid var(--border); border-radius: 20px;
            padding: 28px 32px; margin-bottom: 36px;
            display: flex; justify-content: space-between; align-items: center;
        }
        .welcome-banner h2 {
            font-family: 'Syne', sans-serif; font-size: 1.6rem; font-weight: 800;
            margin-bottom: 6px;
        }
        .welcome-banner p { color: var(--text-muted); font-size: 0.9rem; }
        .welcome-emoji { font-size: 3rem; }

        .categories-section h3 {
            font-family: 'Syne', sans-serif; font-weight: 700;
            font-size: 1rem; margin-bottom: 20px;
            color: var(--text-muted); text-transform: uppercase;
            letter-spacing: 2px; font-size: 0.75rem;
        }

        .cat-grid {
            display: grid; grid-template-columns: repeat(2, 1fr);
            gap: 16px; margin-bottom: 32px;
        }

        .cat-card {
            background: var(--surface); border: 1px solid var(--border);
            border-radius: 16px; padding: 20px 22px;
            transition: all 0.3s;
        }
        .cat-card:hover { border-color: var(--accent); transform: translateY(-3px); box-shadow: 0 12px 40px rgba(108,99,255,0.12); }

        .cat-card-header {
            display: flex; align-items: center; gap: 12px; margin-bottom: 14px;
        }
        .cat-icon-box {
            width: 42px; height: 42px; border-radius: 12px;
            display: flex; align-items: center; justify-content: center; font-size: 1.3rem;
        }
        .cat-name {
            font-family: 'Syne', sans-serif; font-weight: 700; font-size: 1rem;
        }

        .diff-buttons { display: flex; gap: 8px; }
        .diff-btn {
            flex: 1; padding: 8px 6px; border-radius: 8px;
            font-size: 0.78rem; font-weight: 600; text-decoration: none;
            text-align: center; border: 1px solid var(--border);
            color: var(--text-muted); background: var(--surface2);
            transition: all 0.2s;
        }
        .diff-btn:hover { border-color: var(--accent); color: var(--accent); background: rgba(108,99,255,0.1); }
        .diff-easy:hover { border-color: var(--accent3); color: var(--accent3); background: rgba(67,233,123,0.1); }
        .diff-hard:hover { border-color: var(--accent4); color: var(--accent4); background: rgba(247,151,30,0.1); }
        .diff-advanced:hover { border-color: var(--accent2); color: var(--accent2); background: rgba(255,101,132,0.1); }

        .bottom-actions {
            display: flex; gap: 12px; margin-top: 8px;
        }

        @media (max-width: 600px) {
            .cat-grid { grid-template-columns: 1fr; }
            .welcome-banner { flex-direction: column; gap: 16px; text-align: center; }
            .bottom-actions { flex-direction: column; }
        }
    </style>
</head>
<body>
<div class="page-bg"></div>
<div class="page-grid"></div>

<nav class="qm-nav">
    <a href="index.jsp" class="qm-logo">FunQuiz</a>
    <div class="qm-nav-right">
        <!-- <a href="" class="btn btn-ghost btn-sm">ON/off</a> comment --> 
        <a href="logout" class="btn btn-outline btn-sm">Logout</a>
    </div>
</nav>

<div class="page-wrap" style="align-items: flex-start; justify-content: center;">
<div class="dashboard-wrap">

    <div class="welcome-banner anim-up">
        <div>
            <h2>Welcome back, <%= userName %>! 👋</h2>
            <p>Ready to test your knowledge? Pick a category and difficulty to begin.</p>
        </div>
        <div class="welcome-emoji">🧠</div>
    </div>

    <div class="categories-section anim-up-2">
        <h3>Choose Your Category</h3>
        <div class="cat-grid">

            <div class="cat-card">
                <div class="cat-card-header">
                    <div class="cat-icon-box" style="background: rgba(108,99,255,0.15);">🎭</div>
                    <span class="cat-name">Pop Culture</span>
                </div>
                <div class="diff-buttons">
                    <a href="quiz?category=Pop Culture&difficulty=Easy" class="diff-btn diff-easy">Easy</a>
                    <a href="quiz?category=Pop Culture&difficulty=Hard" class="diff-btn diff-hard">Hard</a>
                    <a href="quiz?category=Pop Culture&difficulty=Advanced" class="diff-btn diff-advanced">Advanced</a>
                </div>
            </div>

            <div class="cat-card">
                <div class="cat-card-header">
                    <div class="cat-icon-box" style="background: rgba(67,233,123,0.15);">⚽</div>
                    <span class="cat-name">Sports</span>
                </div>
                <div class="diff-buttons">
                    <a href="quiz?category=Sports&difficulty=Easy" class="diff-btn diff-easy">Easy</a>
                    <a href="quiz?category=Sports&difficulty=Hard" class="diff-btn diff-hard">Hard</a>
                    <a href="quiz?category=Sports&difficulty=Advanced" class="diff-btn diff-advanced">Advanced</a>
                </div>
            </div>

            <div class="cat-card">
                <div class="cat-card-header">
                    <div class="cat-icon-box" style="background: rgba(255,101,132,0.15);">🎬</div>
                    <span class="cat-name">Entertainment</span>
                </div>
                <div class="diff-buttons">
                    <a href="quiz?category=Entertainment&difficulty=Easy" class="diff-btn diff-easy">Easy</a>
                    <a href="quiz?category=Entertainment&difficulty=Hard" class="diff-btn diff-hard">Hard</a>
                    <a href="quiz?category=Entertainment&difficulty=Advanced" class="diff-btn diff-advanced">Advanced</a>
                </div>
            </div>

            <div class="cat-card">
                <div class="cat-card-header">
                    <div class="cat-icon-box" style="background: rgba(247,151,30,0.15);">🌍</div>
                    <span class="cat-name">Geography</span>
                </div>
                <div class="diff-buttons">
                    <a href="quiz?category=Geography&difficulty=Easy" class="diff-btn diff-easy">Easy</a>
                    <a href="quiz?category=Geography&difficulty=Hard" class="diff-btn diff-hard">Hard</a>
                    <a href="quiz?category=Geography&difficulty=Advanced" class="diff-btn diff-advanced">Advanced</a>
                </div>
            </div>

        </div>
    </div>

    <div class="bottom-actions anim-up-3">
        <a href="history.jsp" class="btn btn-outline" style="flex:1; justify-content:center;">
            📊 View Previous Attempts
        </a>
        <a href="logout" class="btn btn-danger" style="flex:0;">
            Logout
        </a>
    </div>

</div>
</div>
</body>
</html>
