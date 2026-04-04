<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    Integer score = (Integer) session.getAttribute("score");
    List<Map<String, String>> questions = (List<Map<String, String>>) session.getAttribute("questions");
    List<String> answers = (List<String>) session.getAttribute("answers");

    if (score == null || questions == null) {
        response.sendRedirect("dashboard.jsp");
        return;
    }

    int total = questions.size();
    int percentage = (int)(((double) score / total) * 100);
    String grade, gradeColor, gradeMsg;
    if (percentage >= 90) { grade = "A+"; gradeColor = "#43e97b"; gradeMsg = "Outstanding! 🏆"; }
    else if (percentage >= 75) { grade = "A"; gradeColor = "#43e97b"; gradeMsg = "Excellent Work! 🎉"; }
    else if (percentage >= 60) { grade = "B"; gradeColor = "#6c63ff"; gradeMsg = "Good Job! 👍"; }
    else if (percentage >= 40) { grade = "C"; gradeColor = "#f7971e"; gradeMsg = "Keep Practicing! 💪"; }
    else { grade = "D"; gradeColor = "#ff4d6d"; gradeMsg = "Don't Give Up! 🔥"; }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Results – FunQuiz</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .result-wrap { width: 100%; max-width: 680px; }

        .score-hero {
            text-align: center; padding: 40px 32px;
            background: var(--surface); border: 1px solid var(--border);
            border-radius: 24px; margin-bottom: 24px; position: relative; overflow: hidden;
        }
        .score-hero::before {
            content: ''; position: absolute; inset: 0;
            background: radial-gradient(ellipse 60% 50% at 50% 0%, rgba(108,99,255,0.1) 0%, transparent 70%);
        }

        .grade-circle {
            width: 100px; height: 100px; border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            margin: 0 auto 20px;
            font-family: 'Syne', sans-serif; font-size: 2.4rem; font-weight: 800;
            position: relative; z-index: 1;
        }

        .score-number {
            font-family: 'Syne', sans-serif; font-size: 3.5rem; font-weight: 800;
            line-height: 1; margin-bottom: 8px; position: relative; z-index: 1;
        }
        .score-number span { font-size: 1.5rem; color: var(--text-muted); }

        .score-msg {
            font-size: 1.2rem; font-weight: 600; margin-bottom: 6px;
            position: relative; z-index: 1;
        }
        .score-sub { color: var(--text-muted); font-size: 0.9rem; position: relative; z-index: 1; }

        .stats-row {
            display: grid; grid-template-columns: repeat(3, 1fr);
            gap: 12px; margin: 24px 0; position: relative; z-index: 1;
        }
        .stat-box {
            background: var(--surface2); border: 1px solid var(--border);
            border-radius: 12px; padding: 14px; text-align: center;
        }
        .stat-box .val {
            font-family: 'Syne', sans-serif; font-size: 1.4rem; font-weight: 800;
            display: block; margin-bottom: 4px;
        }
        .stat-box .lbl { font-size: 0.75rem; color: var(--text-muted); }

        /* Review section */
        .review-header {
            display: flex; justify-content: space-between; align-items: center;
            margin-bottom: 16px;
        }
        .review-header h3 {
            font-family: 'Syne', sans-serif; font-weight: 700; font-size: 1rem;
        }

        .review-item {
            background: var(--surface); border: 1px solid var(--border);
            border-radius: 14px; padding: 16px 20px; margin-bottom: 10px;
            border-left: 4px solid var(--border);
        }
        .review-item.correct-item { border-left-color: var(--accent3); }
        .review-item.wrong-item { border-left-color: var(--red); }
        .review-item.skip-item { border-left-color: var(--text-muted); }

        .review-q {
            font-weight: 600; font-size: 0.9rem; margin-bottom: 10px; line-height: 1.4;
        }
        .review-answers {
            display: flex; gap: 16px; flex-wrap: wrap; font-size: 0.82rem;
        }
        .r-answer { display: flex; align-items: center; gap: 6px; }
        .r-dot { width: 8px; height: 8px; border-radius: 50%; flex-shrink: 0; }

        .result-actions {
            display: flex; gap: 12px; margin-top: 24px; flex-wrap: wrap;
        }

        @media (max-width: 500px) {
            .stats-row { grid-template-columns: repeat(3, 1fr); }
            .result-actions { flex-direction: column; }
            .result-actions .btn { width: 100%; justify-content: center; }
        }
    </style>
</head>
<body>
<div class="page-bg"></div>
<div class="page-grid"></div>

<nav class="qm-nav">
    <a href="index.jsp" class="qm-logo">FunQuiz</a>
    <div class="qm-nav-right">
        <a href="dashboard.jsp" class="btn btn-outline btn-sm">Dashboard</a>
    </div>
</nav>

<div class="page-wrap" style="align-items: flex-start; padding-top: 90px;">
<div class="result-wrap">

    <!-- Score Hero -->
    <div class="score-hero anim-up">
        <div class="grade-circle"
             style="background: <%= gradeColor %>22; border: 3px solid <%= gradeColor %>; color: <%= gradeColor %>;">
            <%= grade %>
        </div>
        <div class="score-number" style="color: <%= gradeColor %>">
            <%= score %><span> / <%= total %></span>
        </div>
        <div class="score-msg"><%= gradeMsg %></div>
        <div class="score-sub">You scored <%= percentage %>% on this quiz</div>

        <div class="stats-row">
            <div class="stat-box">
                <span class="val" style="color: var(--accent3)"><%= score %></span>
                <span class="lbl">Correct</span>
            </div>
            <div class="stat-box">
                <span class="val" style="color: var(--red)"><%= total - score %></span>
                <span class="lbl">Wrong / Skipped</span>
            </div>
            <div class="stat-box">
                <span class="val" style="color: var(--accent)"><%= percentage %>%</span>
                <span class="lbl">Accuracy</span>
            </div>
        </div>
    </div>

    <!-- Question Review -->
    <div class="anim-up-2">
        <div class="review-header">
            <h3>📋 Question Review</h3>
            <span class="badge badge-accent"><%= total %> questions</span>
        </div>

        <%
        for (int i = 0; i < questions.size(); i++) {
            Map<String, String> qItem = questions.get(i);
            String userAnswer = (answers != null && i < answers.size()) ? answers.get(i) : "";
            String correctAns = qItem.get("correct");
            boolean isCorrect = userAnswer != null && !userAnswer.isEmpty() && userAnswer.trim().equalsIgnoreCase(correctAns != null ? correctAns.trim() : "");
            boolean isSkipped = userAnswer == null || userAnswer.isEmpty();
            String itemClass = isCorrect ? "correct-item" : (isSkipped ? "skip-item" : "wrong-item");
            String icon = isCorrect ? "✅" : (isSkipped ? "⏭️" : "❌");
        %>
        <div class="review-item <%= itemClass %>">
            <div class="review-q"><%= icon %> Q<%= i+1 %>. <%= qItem.get("question") %></div>
            <div class="review-answers">
                <div class="r-answer">
                    <div class="r-dot" style="background: <%= isCorrect ? "var(--accent3)" : "var(--red)" %>"></div>
                    <span style="color: var(--text-muted)">Your answer:</span>
                    <strong style="color: <%= isCorrect ? "var(--accent3)" : (isSkipped ? "var(--text-muted)" : "var(--red)") %>">
                        <%= isSkipped ? "Skipped" : userAnswer %>
                    </strong>
                </div>
                <% if (!isCorrect) { %>
                <div class="r-answer">
                    <div class="r-dot" style="background: var(--accent3)"></div>
                    <span style="color: var(--text-muted)">Correct:</span>
                    <strong style="color: var(--accent3)"><%= correctAns %></strong>
                </div>
                <% } %>
            </div>
        </div>
        <% } %>
    </div>

    <!-- Actions -->
    <div class="result-actions anim-up-3">
        <a href="feedback.jsp" class="btn btn-primary btn-lg" style="flex:1; justify-content:center;">
            Continue to Feedback →
        </a>
        <a href="dashboard.jsp" class="btn btn-outline btn-lg">
            🏠 Dashboard
        </a>
    </div>

</div>
</div>
</body>
</html>
