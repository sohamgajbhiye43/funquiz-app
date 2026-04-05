<%@ page import="java.util.*, com.quiz.dao.ScoreDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    Integer userId = (Integer) session.getAttribute("userId");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Attempts – FunQuiz</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .attempts-wrap { width: 100%; max-width: 720px; }

        .attempts-header { margin-bottom: 32px; }
        .attempts-header .section-title { font-size: 2rem; }
        .attempts-header p { color: var(--text-muted); margin-top: 8px; }

        .summary-cards {
            display: grid; grid-template-columns: repeat(3, 1fr);
            gap: 14px; margin-bottom: 32px;
        }
        .sum-card {
            background: var(--surface); border: 1px solid var(--border);
            border-radius: 16px; padding: 18px 20px; text-align: center;
        }
        .sum-card .val {
            font-family: 'Syne', sans-serif; font-size: 1.8rem; font-weight: 800;
            display: block; margin-bottom: 4px;
        }
        .sum-card .lbl { font-size: 0.78rem; color: var(--text-muted); }

        .table-wrap {
            background: var(--surface); border: 1px solid var(--border);
            border-radius: 20px; overflow: hidden;
        }
        .table-header-row {
            padding: 16px 24px;
            background: var(--surface2); border-bottom: 1px solid var(--border);
            display: flex; justify-content: space-between; align-items: center;
        }
        .table-header-row h3 {
            font-family: 'Syne', sans-serif; font-weight: 700; font-size: 0.95rem;
        }

        .attempt-row {
            display: grid; grid-template-columns: 40px 1fr 100px 100px 120px;
            padding: 14px 24px; align-items: center;
            border-bottom: 1px solid var(--border); transition: background 0.2s;
        }
        .attempt-row:hover { background: var(--surface2); }
        .attempt-row:last-child { border-bottom: none; }
        .attempt-row.header {
            font-size: 0.72rem; font-weight: 700; letter-spacing: 1.5px;
            text-transform: uppercase; color: var(--text-muted);
            background: var(--surface2);
        }

        .attempt-num { font-family: 'Syne', sans-serif; font-weight: 700; color: var(--text-muted); }
        .attempt-score {
            font-family: 'Syne', sans-serif; font-weight: 700; font-size: 1rem;
        }
        .attempt-total { color: var(--text-muted); font-size: 0.88rem; }
        .attempt-date { color: var(--text-muted); font-size: 0.82rem; }

        .empty-state {
            text-align: center; padding: 60px 24px;
            color: var(--text-muted);
        }
        .empty-state .emoji { font-size: 3rem; margin-bottom: 16px; display: block; }
        .empty-state h3 { font-family: 'Syne', sans-serif; margin-bottom: 8px; }

        @media (max-width: 600px) {
            .summary-cards { grid-template-columns: repeat(3, 1fr); gap: 8px; }
            .attempt-row { grid-template-columns: 30px 1fr 70px 80px; }
            .attempt-row > *:nth-child(4) { display: none; }
        }
    </style>
</head>
<body>
<div class="page-bg"></div>
<div class="page-grid"></div>

<nav class="qm-nav">
    <a href="index.jsp" class="qm-logo">FunQuiz</a>
    <div class="qm-nav-right">
        <a href="dashboard.jsp" class="btn btn-outline btn-sm">← Dashboard</a>
        <a href="logout" class="btn btn-ghost btn-sm">Logout</a>
    </div>
</nav>

<div class="page-wrap" style="align-items: flex-start; padding-top: 90px;">
<div class="attempts-wrap">

    <div class="attempts-header anim-up">
        <span class="section-label">Your History</span>
        <h1 class="section-title">Previous Attempts</h1>
        <p>Track your progress and see how you've improved over time.</p>
    </div>

    <%
    // Fetch scores for this user
    List<Map<String,String>> myScores = new ArrayList<>();
    try {
        com.quiz.util.DBConnection dbConn = null;
        java.sql.Connection con = com.quiz.util.DBConnection.getConnection();
        if (con != null) {
            java.sql.PreparedStatement ps = con.prepareStatement(
                "SELECT score, total_questions, date FROM scores WHERE user_id=? ORDER BY date DESC"
            );
            ps.setInt(1, userId);
            java.sql.ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String,String> row = new HashMap<>();
                row.put("score", rs.getString("score"));
                row.put("total", rs.getString("total_questions"));
                row.put("date", rs.getString("date"));
                myScores.add(row);
            }
        }
    } catch (Exception e) {
        out.println("<!-- DB error: " + e.getMessage() + " -->");
    }

    int totalAttempts = myScores.size();
    int totalCorrect = 0;
    int bestScore = 0;
    for (Map<String,String> s : myScores) {
        int sc = Integer.parseInt(s.get("score") != null ? s.get("score") : "0");
        totalCorrect += sc;
        if (sc > bestScore) bestScore = sc;
    }
    int avgScore = totalAttempts > 0 ? totalCorrect / totalAttempts : 0;
    %>

    <!-- Summary Cards -->
    <div class="summary-cards anim-up-2">
        <div class="sum-card">
            <span class="val" style="color: var(--accent)"><%= totalAttempts %></span>
            <span class="lbl">Total Attempts</span>
        </div>
        <div class="sum-card">
            <span class="val" style="color: var(--accent3)"><%= bestScore %></span>
            <span class="lbl">Best Score</span>
        </div>
        <div class="sum-card">
            <span class="val" style="color: var(--accent4)"><%= avgScore %></span>
            <span class="lbl">Avg Score</span>
        </div>
    </div>

    <!-- Table -->
    <div class="table-wrap anim-up-3">
        <div class="table-header-row">
            <h3>All Attempts</h3>
            <span class="badge badge-accent"><%= totalAttempts %> total</span>
        </div>

        <% if (myScores.isEmpty()) { %>
        <div class="empty-state">
            <span class="emoji">🎯</span>
            <h3>No attempts yet</h3>
            <p style="margin-bottom: 20px;">Take your first quiz to see your history here!</p>
            <a href="dashboard.jsp" class="btn btn-primary">Start a Quiz →</a>
        </div>

        <% } else { %>
        <div class="attempt-row header">
            <span>#</span>
            <span>Score</span>
            <span>Accuracy</span>
            <span>Total Qs</span>
            <span>Date</span>
        </div>

        <% for (int i = 0; i < myScores.size(); i++) {
            Map<String,String> s = myScores.get(i);
            int sc = Integer.parseInt(s.get("score") != null ? s.get("score") : "0");
            int tot = Integer.parseInt(s.get("total") != null ? s.get("total") : "1");
            int pct = (int)(((double)sc / tot) * 100);
            String pctColor = pct >= 75 ? "var(--accent3)" : pct >= 50 ? "var(--accent)" : "var(--red)";
        %>
        <div class="attempt-row">
            <span class="attempt-num"><%= totalAttempts - i %></span>
            <div>
                <span class="attempt-score" style="color: <%= pctColor %>"><%= sc %> / <%= tot %></span>
                <div style="margin-top: 4px;">
                    <div class="progress-wrap" style="height:4px; background: var(--surface3);">
                        <div class="progress-fill" style="width:<%= pct %>%; background: <%= pctColor %>;"></div>
                    </div>
                </div>
            </div>
            <span style="color: <%= pctColor %>; font-weight: 600; font-size: 0.88rem;"><%= pct %>%</span>
            <span class="attempt-total"><%= tot %> questions</span>
            <span class="attempt-date"><%= s.get("date") != null ? s.get("date").substring(0, 16) : "-" %></span>
        </div>
        <% } %>
        <% } %>
    </div>

    <div style="margin-top: 24px;" class="anim-up-4">
        <a href="dashboard.jsp" class="btn btn-primary btn-lg">
            Play Another Quiz →
        </a>
    </div>

</div>
</div>
</body>
</html>
