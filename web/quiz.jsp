<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    List<Map<String, String>> questions = (List<Map<String, String>>) session.getAttribute("questions");
    Integer index = (Integer) session.getAttribute("index");
    if (questions == null || index == null) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
    if (index >= questions.size()) {
        response.sendRedirect("saveScore");
        return;
    }
    Map<String, String> q = questions.get(index);
    int total = questions.size();
    int progress = (int)(((double) index / total) * 100);
    int questionNum = index + 1;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz – Question <%= questionNum %> of <%= total %></title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .quiz-wrap { width: 100%; max-width: 600px; }

        .quiz-meta {
            display: flex; justify-content: space-between; align-items: center;
            margin-bottom: 10px;
        }
        .q-counter {
            font-size: 0.82rem; color: var(--text-muted); font-weight: 500;
        }
        .timer-badge {
            display: flex; align-items: center; gap: 6px;
            background: var(--surface2); border: 1px solid var(--border);
            padding: 6px 14px; border-radius: 100px;
            font-family: 'Syne', sans-serif; font-weight: 700; font-size: 0.95rem;
        }
        .timer-badge.warning { border-color: var(--accent4); color: var(--accent4); background: rgba(247,151,30,0.1); }
        .timer-badge.danger { border-color: var(--red); color: var(--red); background: rgba(255,77,109,0.1); animation: timerPulse 0.5s infinite alternate; }
        @keyframes timerPulse { from { opacity: 1; } to { opacity: 0.6; } }

        .progress-label {
            font-size: 0.72rem; color: var(--text-muted); text-align: right; margin-bottom: 16px;
        }

        .question-card {
            background: var(--surface); border: 1px solid var(--border);
            border-radius: 20px; padding: 32px; margin-bottom: 16px;
        }

        .question-text {
            font-family: 'Syne', sans-serif; font-size: 1.2rem; font-weight: 700;
            line-height: 1.5; margin-bottom: 24px; color: var(--text);
        }

        .options-grid { display: flex; flex-direction: column; gap: 0; }

        .skip-hint {
            text-align: center; margin-top: 12px;
            font-size: 0.78rem; color: var(--text-muted);
        }

        .quiz-footer {
            display: flex; justify-content: space-between; align-items: center;
            margin-top: 16px;
        }
    </style>
</head>
<body>
<div class="page-bg"></div>
<div class="page-grid"></div>

<nav class="qm-nav">
    <a href="index.jsp" class="qm-logo">FunQuiz</a>
    <div class="qm-nav-right">
        <a href="dashboard.jsp" class="btn btn-ghost btn-sm">✕ Exit Quiz</a>
    </div>
</nav>

<div class="page-wrap">
<div class="quiz-wrap">

    <div class="quiz-meta anim-up">
        <span class="q-counter">Question <strong><%= questionNum %></strong> of <strong><%= total %></strong></span>
        <div class="timer-badge" id="timerBadge">
            ⏱ <span id="timer">60</span>s
        </div>
    </div>

    <div class="progress-wrap anim-up">
        <div class="progress-fill" style="width: <%= progress %>%"></div>
    </div>
    <div class="progress-label anim-up"><%= progress %>% complete</div>

    <div class="question-card anim-up-2">
        <p class="question-text"><%= q.get("question") %></p>

        <form action="quiz" method="post" id="quizForm">
            <div class="options-grid">
                <label class="option-btn" onclick="selectOption(this)">
                    <span class="option-letter">A</span>
                    <input type="radio" name="answer" value="<%= q.get("option1") %>" style="display:none">
                    <%= q.get("option1") %>
                </label>
                <label class="option-btn" onclick="selectOption(this)">
                    <span class="option-letter">B</span>
                    <input type="radio" name="answer" value="<%= q.get("option2") %>" style="display:none">
                    <%= q.get("option2") %>
                </label>
                <label class="option-btn" onclick="selectOption(this)">
                    <span class="option-letter">C</span>
                    <input type="radio" name="answer" value="<%= q.get("option3") %>" style="display:none">
                    <%= q.get("option3") %>
                </label>
                <label class="option-btn" onclick="selectOption(this)">
                    <span class="option-letter">D</span>
                    <input type="radio" name="answer" value="<%= q.get("option4") %>" style="display:none">
                    <%= q.get("option4") %>
                </label>
            </div>

            <div class="quiz-footer">
                <span class="skip-hint">No answer = skipped question</span>
                <button type="submit" class="btn btn-primary" id="nextBtn">
                    <%= (questionNum == total) ? "Finish Quiz 🏁" : "Next →" %>
                </button>
            </div>
        </form>
    </div>

</div>
</div>

<script>
let time = 60;
const timerEl = document.getElementById('timer');
const badgeEl = document.getElementById('timerBadge');

const t = setInterval(function() {
    time--;
    timerEl.textContent = time;
    if (time <= 10) badgeEl.className = 'timer-badge danger';
    else if (time <= 20) badgeEl.className = 'timer-badge warning';
    if (time <= 0) { clearInterval(t); document.getElementById('quizForm').submit(); }
}, 1000);

function selectOption(el) {
    document.querySelectorAll('.option-btn').forEach(o => {
        o.classList.remove('selected');
        o.querySelector('.option-letter').style.background = '';
    });
    el.classList.add('selected');
    el.querySelector('.option-letter').style.background = 'var(--accent)';
    el.querySelector('.option-letter').style.color = 'white';
    el.querySelector('input[type=radio]').checked = true;
}
</script>
</body>
</html>
