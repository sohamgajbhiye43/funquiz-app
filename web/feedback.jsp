<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Feedback – FunQuiz</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .feedback-wrap { width: 100%; max-width: 500px; }

        .feedback-header { text-align: center; margin-bottom: 32px; }
        .feedback-header .section-title { font-size: 2rem; }
        .feedback-header p { color: var(--text-muted); margin-top: 8px; }

        .rating-item {
            background: var(--surface); border: 1px solid var(--border);
            border-radius: 16px; padding: 20px 24px; margin-bottom: 12px;
            transition: border-color 0.2s;
        }
        .rating-item:hover { border-color: var(--border); }
        .rating-item.rated { border-color: rgba(108,99,255,0.3); }

        .rating-label {
            font-weight: 600; font-size: 0.9rem; margin-bottom: 12px;
            display: flex; align-items: center; gap: 8px;
        }
        .rating-num {
            width: 24px; height: 24px; border-radius: 8px;
            background: rgba(108,99,255,0.15); color: var(--accent);
            display: inline-flex; align-items: center; justify-content: center;
            font-size: 0.75rem; font-weight: 700; font-family: 'Syne', sans-serif;
        }

        .stars { display: flex; gap: 8px; }
        .star {
            font-size: 1.6rem; cursor: pointer;
            filter: grayscale(1) opacity(0.4);
            transition: filter 0.15s, transform 0.15s;
        }
        .star.active { filter: grayscale(0) opacity(1); }
        .star:hover { transform: scale(1.15); }

        .success-box {
            background: rgba(67,233,123,0.1); border: 1px solid rgba(67,233,123,0.3);
            border-radius: 12px; padding: 16px; text-align: center;
            color: var(--accent3); font-weight: 600; display: none;
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

<div class="page-wrap">
<div class="feedback-wrap">

    <div class="feedback-header anim-up">
        <span class="section-label">Share Your Thoughts</span>
        <h1 class="section-title">Rate Your Experience</h1>
        <p>Help us improve FunQuiz with your honest feedback.</p>
    </div>

    <form action="submitFeedback" method="post" id="feedbackForm">

        <div class="rating-item anim-up" id="item1">
            <div class="rating-label"><span class="rating-num">1</span> Quiz Difficulty</div>
            <div class="stars" data-q="1">
                <span class="star" data-val="1">⭐</span>
                <span class="star" data-val="2">⭐</span>
                <span class="star" data-val="3">⭐</span>
                <span class="star" data-val="4">⭐</span>
                <span class="star" data-val="5">⭐</span>
            </div>
            <input type="hidden" name="q1" id="q1" value="0">
        </div>

        <div class="rating-item anim-up-2" id="item2">
            <div class="rating-label"><span class="rating-num">2</span> Quiz Engagement</div>
            <div class="stars" data-q="2">
                <span class="star" data-val="1">⭐</span>
                <span class="star" data-val="2">⭐</span>
                <span class="star" data-val="3">⭐</span>
                <span class="star" data-val="4">⭐</span>
                <span class="star" data-val="5">⭐</span>
            </div>
            <input type="hidden" name="q2" id="q2" value="0">
        </div>

        <div class="rating-item anim-up-2" id="item3">
            <div class="rating-label"><span class="rating-num">3</span> UI Experience</div>
            <div class="stars" data-q="3">
                <span class="star" data-val="1">⭐</span>
                <span class="star" data-val="2">⭐</span>
                <span class="star" data-val="3">⭐</span>
                <span class="star" data-val="4">⭐</span>
                <span class="star" data-val="5">⭐</span>
            </div>
            <input type="hidden" name="q3" id="q3" value="0">
        </div>

        <div class="rating-item anim-up-3" id="item4">
            <div class="rating-label"><span class="rating-num">4</span> Question Quality</div>
            <div class="stars" data-q="4">
                <span class="star" data-val="1">⭐</span>
                <span class="star" data-val="2">⭐</span>
                <span class="star" data-val="3">⭐</span>
                <span class="star" data-val="4">⭐</span>
                <span class="star" data-val="5">⭐</span>
            </div>
            <input type="hidden" name="q4" id="q4" value="0">
        </div>

        <div class="rating-item anim-up-3" id="item5">
            <div class="rating-label"><span class="rating-num">5</span> Overall Experience</div>
            <div class="stars" data-q="5">
                <span class="star" data-val="1">⭐</span>
                <span class="star" data-val="2">⭐</span>
                <span class="star" data-val="3">⭐</span>
                <span class="star" data-val="4">⭐</span>
                <span class="star" data-val="5">⭐</span>
            </div>
            <input type="hidden" name="q5" id="q5" value="0">
        </div>

        <div style="margin-top: 24px; display: flex; gap: 12px;">
            <button type="submit" class="btn btn-primary btn-full btn-lg">
                Submit Feedback ✓
            </button>
            <a href="dashboard.jsp" class="btn btn-outline btn-lg">Skip</a>
        </div>
    </form>

</div>
</div>

<script>
document.querySelectorAll('.stars').forEach(starGroup => {
    const qNum = starGroup.dataset.q;
    const stars = starGroup.querySelectorAll('.star');
    const input = document.getElementById('q' + qNum);
    const item = document.getElementById('item' + qNum);

    stars.forEach(star => {
        star.addEventListener('mouseover', () => {
            const val = parseInt(star.dataset.val);
            stars.forEach((s, i) => s.classList.toggle('active', i < val));
        });
        star.addEventListener('mouseleave', () => {
            const current = parseInt(input.value);
            stars.forEach((s, i) => s.classList.toggle('active', i < current));
        });
        star.addEventListener('click', () => {
            const val = parseInt(star.dataset.val);
            input.value = val;
            stars.forEach((s, i) => s.classList.toggle('active', i < val));
            item.classList.add('rated');
        });
    });
});
</script>
</body>
</html>
