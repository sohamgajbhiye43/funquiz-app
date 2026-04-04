<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> FunQuiz – Test Your Knowledge</title>
    <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:ital,wght@0,300;0,400;0,500;1,300&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg: #0a0a0f;
            --surface: #12121a;
            --surface2: #1a1a26;
            --accent: #6c63ff;
            --accent2: #ff6584;
            --accent3: #43e97b;
            --accent4: #f7971e;
            --text: #f0f0ff;
            --text-muted: #8888aa;
            --border: rgba(108,99,255,0.2);
            --glow: rgba(108,99,255,0.4);
        }

        *, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }

        html { scroll-behavior: smooth; }

        body {
            background: var(--bg);
            color: var(--text);
            font-family: 'DM Sans', sans-serif;
            overflow-x: hidden;
            cursor: none;
        }

        /* Custom Cursor */
        .cursor {
            width: 12px; height: 12px;
            background: var(--accent);
            border-radius: 50%;
            position: fixed; top: 0; left: 0;
            pointer-events: none; z-index: 9999;
            transform: translate(-50%, -50%);
            transition: transform 0.1s, width 0.2s, height 0.2s, background 0.2s;
        }
        .cursor-ring {
            width: 36px; height: 36px;
            border: 2px solid var(--accent);
            border-radius: 50%;
            position: fixed; top: 0; left: 0;
            pointer-events: none; z-index: 9998;
            transform: translate(-50%, -50%);
            transition: transform 0.15s ease-out, width 0.2s, height 0.2s, opacity 0.2s;
            opacity: 0.5;
        }
        body:hover .cursor { opacity: 1; }

        /* Scrollbar */
        ::-webkit-scrollbar { width: 4px; }
        ::-webkit-scrollbar-track { background: var(--bg); }
        ::-webkit-scrollbar-thumb { background: var(--accent); border-radius: 2px; }

        /* NAV */
        nav {
            position: fixed; top: 0; left: 0; right: 0;
            z-index: 100;
            padding: 20px 60px;
            display: flex; align-items: center; justify-content: space-between;
            backdrop-filter: blur(20px);
            background: rgba(10,10,15,0.8);
            border-bottom: 1px solid var(--border);
            transition: padding 0.3s;
        }
        nav.scrolled { padding: 12px 60px; }

        .nav-logo {
            font-family: 'Syne', sans-serif;
            font-weight: 800; font-size: 1.6rem;
            background: linear-gradient(135deg, var(--accent), var(--accent2));
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
            letter-spacing: -1px;
        }
        .nav-logo span { color: var(--accent2); -webkit-text-fill-color: unset; }

        .nav-links { display: flex; gap: 36px; list-style: none; }
        .nav-links a {
            color: var(--text-muted); text-decoration: none;
            font-size: 0.9rem; font-weight: 500; letter-spacing: 0.5px;
            transition: color 0.2s; position: relative;
        }
        .nav-links a::after {
            content: ''; position: absolute; bottom: -4px; left: 0; right: 0;
            height: 2px; background: var(--accent);
            transform: scaleX(0); transition: transform 0.2s;
        }
        .nav-links a:hover { color: var(--text); }
        .nav-links a:hover::after { transform: scaleX(1); }

        .nav-cta {
            display: flex; gap: 12px; align-items: center;
        }
        .btn-outline {
            padding: 9px 22px; border: 1px solid var(--border);
            background: transparent; color: var(--text-muted);
            border-radius: 8px; font-size: 0.88rem; font-weight: 500;
            cursor: none; transition: all 0.2s; text-decoration: none;
            font-family: 'DM Sans', sans-serif;
        }
        .btn-outline:hover { border-color: var(--accent); color: var(--text); background: rgba(108,99,255,0.1); }

        .btn-primary {
            padding: 9px 22px;
            background: var(--accent);
            color: white; border: none;
            border-radius: 8px; font-size: 0.88rem; font-weight: 600;
            cursor: none; transition: all 0.2s; text-decoration: none;
            font-family: 'DM Sans', sans-serif;
            box-shadow: 0 0 20px rgba(108,99,255,0.4);
        }
        .btn-primary:hover { transform: translateY(-1px); box-shadow: 0 0 30px rgba(108,99,255,0.6); }

        /* HERO */
        .hero {
            min-height: 100vh;
            display: flex; align-items: center; justify-content: center;
            position: relative; overflow: hidden;
            padding: 120px 60px 80px;
        }

        .hero-bg {
            position: absolute; inset: 0; z-index: 0;
            background:
                radial-gradient(ellipse 60% 50% at 50% -10%, rgba(108,99,255,0.3) 0%, transparent 70%),
                radial-gradient(ellipse 40% 40% at 80% 80%, rgba(255,101,132,0.15) 0%, transparent 60%),
                radial-gradient(ellipse 30% 30% at 10% 70%, rgba(67,233,123,0.1) 0%, transparent 50%);
        }

        .hero-grid {
            position: absolute; inset: 0;
            background-image:
                linear-gradient(rgba(108,99,255,0.05) 1px, transparent 1px),
                linear-gradient(90deg, rgba(108,99,255,0.05) 1px, transparent 1px);
            background-size: 60px 60px;
            mask-image: radial-gradient(ellipse at center, black 30%, transparent 70%);
        }

        .hero-content {
            position: relative; z-index: 1;
            text-align: center; max-width: 820px;
        }

        .hero-badge {
            display: inline-flex; align-items: center; gap: 8px;
            background: rgba(108,99,255,0.15); border: 1px solid var(--border);
            padding: 6px 16px; border-radius: 100px;
            font-size: 0.8rem; color: var(--accent); font-weight: 500;
            margin-bottom: 28px;
            animation: fadeDown 0.6s ease both;
        }
        .hero-badge .dot {
            width: 6px; height: 6px; background: var(--accent3);
            border-radius: 50%; animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% { opacity: 1; transform: scale(1); }
            50% { opacity: 0.5; transform: scale(1.4); }
        }

        .hero h1 {
            font-family: 'Syne', sans-serif;
            font-size: clamp(3rem, 7vw, 5.5rem);
            font-weight: 800; line-height: 1.05;
            letter-spacing: -2px;
            margin-bottom: 24px;
            animation: fadeUp 0.7s 0.1s ease both;
        }

        .hero h1 .line2 {
            background: linear-gradient(135deg, var(--accent) 0%, var(--accent2) 50%, var(--accent4) 100%);
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
        }

        .hero-sub {
            font-size: 1.15rem; color: var(--text-muted); line-height: 1.7;
            max-width: 560px; margin: 0 auto 40px;
            animation: fadeUp 0.7s 0.2s ease both;
        }

        .hero-actions {
            display: flex; gap: 16px; justify-content: center; flex-wrap: wrap;
            animation: fadeUp 0.7s 0.3s ease both;
        }

        .btn-hero {
            padding: 14px 32px; border-radius: 10px;
            font-size: 1rem; font-weight: 600;
            cursor: none; text-decoration: none;
            font-family: 'DM Sans', sans-serif;
            transition: all 0.25s;
        }
        .btn-hero-main {
            background: linear-gradient(135deg, var(--accent), #8b83ff);
            color: white; border: none;
            box-shadow: 0 8px 32px rgba(108,99,255,0.4);
        }
        .btn-hero-main:hover { transform: translateY(-2px); box-shadow: 0 12px 40px rgba(108,99,255,0.6); }
        .btn-hero-sec {
            background: transparent;
            border: 1px solid var(--border); color: var(--text);
        }
        .btn-hero-sec:hover { background: var(--surface2); border-color: var(--accent); }

        .hero-stats {
            display: flex; gap: 48px; justify-content: center;
            margin-top: 64px;
            animation: fadeUp 0.7s 0.4s ease both;
        }
        .hero-stat { text-align: center; }
        .hero-stat .num {
            font-family: 'Syne', sans-serif;
            font-size: 2.2rem; font-weight: 800;
            background: linear-gradient(135deg, var(--text), var(--accent));
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
        }
        .hero-stat .label { font-size: 0.8rem; color: var(--text-muted); margin-top: 4px; }

        /* FLOATING CARDS */
        .hero-float {
            position: absolute;
            background: var(--surface2); border: 1px solid var(--border);
            border-radius: 16px; padding: 16px 20px;
            font-size: 0.85rem; backdrop-filter: blur(10px);
            animation: float 6s ease-in-out infinite;
            z-index: 1;
        }
        .hero-float:nth-child(1) { top: 22%; left: 5%; animation-delay: 0s; }
        .hero-float:nth-child(2) { top: 30%; right: 5%; animation-delay: 2s; }
        .hero-float:nth-child(3) { bottom: 20%; left: 8%; animation-delay: 4s; }
        .hero-float:nth-child(4) { bottom: 25%; right: 7%; animation-delay: 1s; }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-12px); }
        }

        .hero-float .float-icon { font-size: 1.5rem; margin-bottom: 6px; }
        .hero-float .float-title { font-weight: 600; color: var(--text); margin-bottom: 2px; }
        .hero-float .float-sub { color: var(--text-muted); font-size: 0.78rem; }

        /* SECTIONS */
        section { padding: 100px 60px; }

        .section-label {
            display: inline-block;
            font-size: 0.75rem; font-weight: 600; letter-spacing: 3px;
            text-transform: uppercase; color: var(--accent);
            margin-bottom: 16px;
        }

        .section-title {
            font-family: 'Syne', sans-serif;
            font-size: clamp(2rem, 4vw, 3rem);
            font-weight: 800; letter-spacing: -1px;
            line-height: 1.1; margin-bottom: 16px;
        }

        .section-sub {
            color: var(--text-muted); font-size: 1rem;
            line-height: 1.7; max-width: 520px;
        }

        /* HOW IT WORKS */
        .how { background: var(--surface); }

        .steps {
            display: grid; grid-template-columns: repeat(4, 1fr);
            gap: 24px; margin-top: 64px; position: relative;
        }

        .steps::before {
            content: '';
            position: absolute; top: 36px; left: 12%; right: 12%;
            height: 1px; background: linear-gradient(90deg, transparent, var(--border), var(--accent), var(--border), transparent);
        }

        .step {
            text-align: center; padding: 32px 20px;
            background: var(--surface2); border: 1px solid var(--border);
            border-radius: 20px; position: relative;
            transition: transform 0.3s, border-color 0.3s, box-shadow 0.3s;
        }
        .step:hover {
            transform: translateY(-6px);
            border-color: var(--accent);
            box-shadow: 0 20px 60px rgba(108,99,255,0.15);
        }

        .step-num {
            width: 56px; height: 56px;
            background: linear-gradient(135deg, var(--accent), #8b83ff);
            border-radius: 16px; display: flex; align-items: center; justify-content: center;
            font-family: 'Syne', sans-serif; font-size: 1.3rem; font-weight: 800;
            margin: 0 auto 20px; box-shadow: 0 8px 24px rgba(108,99,255,0.3);
        }

        .step h3 {
            font-family: 'Syne', sans-serif;
            font-size: 1.05rem; font-weight: 700; margin-bottom: 10px;
        }
        .step p { color: var(--text-muted); font-size: 0.88rem; line-height: 1.6; }

        /* CATEGORIES */
        .categories-grid {
            display: grid; grid-template-columns: repeat(4, 1fr);
            gap: 20px; margin-top: 64px;
        }

        .cat-card {
            background: var(--surface); border: 1px solid var(--border);
            border-radius: 20px; padding: 28px 24px;
            transition: all 0.3s; cursor: none; position: relative; overflow: hidden;
        }
        .cat-card::before {
            content: '';
            position: absolute; inset: 0;
            background: linear-gradient(135deg, var(--card-color, var(--accent)), transparent);
            opacity: 0; transition: opacity 0.3s;
        }
        .cat-card:hover { transform: translateY(-6px); border-color: var(--card-color, var(--accent)); }
        .cat-card:hover::before { opacity: 0.08; }

        .cat-icon { font-size: 2.4rem; margin-bottom: 14px; }
        .cat-card h3 {
            font-family: 'Syne', sans-serif; font-size: 1rem; font-weight: 700; margin-bottom: 6px;
        }
        .cat-card p { color: var(--text-muted); font-size: 0.82rem; line-height: 1.5; }
        .cat-count {
            display: inline-block; margin-top: 14px;
            background: rgba(255,255,255,0.05); border: 1px solid var(--border);
            padding: 3px 10px; border-radius: 100px;
            font-size: 0.75rem; color: var(--text-muted);
        }

        /* FEATURES */
        .features { background: var(--surface); }

        .features-grid {
            display: grid; grid-template-columns: 1fr 1fr;
            gap: 60px; align-items: center; margin-top: 64px;
        }

        .features-list { display: flex; flex-direction: column; gap: 28px; }

        .feature-item {
            display: flex; gap: 18px; align-items: flex-start;
            padding: 24px; border-radius: 16px;
            border: 1px solid transparent;
            transition: all 0.3s; cursor: none;
        }
        .feature-item:hover {
            background: var(--surface2); border-color: var(--border);
        }

        .feature-icon {
            width: 44px; height: 44px; flex-shrink: 0;
            border-radius: 12px; display: flex; align-items: center; justify-content: center;
            font-size: 1.2rem;
        }
        .feature-item h4 {
            font-family: 'Syne', sans-serif; font-weight: 700; margin-bottom: 6px; font-size: 1rem;
        }
        .feature-item p { color: var(--text-muted); font-size: 0.88rem; line-height: 1.6; }

        .features-visual {
            position: relative; height: 520px;
        }

        .mock-quiz {
            background: var(--surface2); border: 1px solid var(--border);
            border-radius: 24px; padding: 32px;
            position: absolute; top: 0; left: 0; right: 0;
            box-shadow: 0 40px 80px rgba(0,0,0,0.4);
        }

        .mock-quiz-header {
            display: flex; justify-content: space-between; align-items: center;
            margin-bottom: 24px;
        }
        .mock-quiz-header .title { font-family: 'Syne', sans-serif; font-weight: 700; }
        .mock-timer {
            background: rgba(108,99,255,0.15); color: var(--accent);
            padding: 4px 12px; border-radius: 100px; font-size: 0.85rem; font-weight: 600;
        }

        .mock-progress {
            height: 6px; background: var(--surface);
            border-radius: 3px; margin-bottom: 28px; overflow: hidden;
        }
        .mock-progress-bar {
            height: 100%; width: 60%;
            background: linear-gradient(90deg, var(--accent), var(--accent2));
            border-radius: 3px; animation: progress-anim 3s ease-in-out infinite alternate;
        }
        @keyframes progress-anim { from { width: 40%; } to { width: 75%; } }

        .mock-question {
            font-size: 1rem; font-weight: 500; margin-bottom: 20px; line-height: 1.5;
        }

        .mock-options { display: flex; flex-direction: column; gap: 10px; }
        .mock-option {
            padding: 12px 16px; border-radius: 10px;
            border: 1px solid var(--border); font-size: 0.88rem;
            transition: all 0.2s; cursor: none;
        }
        .mock-option.selected {
            background: rgba(108,99,255,0.15); border-color: var(--accent); color: var(--accent);
        }
        .mock-option.correct {
            background: rgba(67,233,123,0.1); border-color: var(--accent3); color: var(--accent3);
        }

        .mock-floating {
            position: absolute; bottom: -20px; right: -20px;
            background: var(--surface2); border: 1px solid var(--border);
            border-radius: 16px; padding: 16px 20px;
            display: flex; align-items: center; gap: 12px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.3);
        }
        .mock-floating .score-circle {
            width: 48px; height: 48px;
            background: linear-gradient(135deg, var(--accent3), #00b09b);
            border-radius: 50%; display: flex; align-items: center; justify-content: center;
            font-family: 'Syne', sans-serif; font-weight: 800; font-size: 0.9rem;
        }

        /* LEADERBOARD */
        .leaderboard { background: var(--bg); }

        .leaderboard-table {
            background: var(--surface); border: 1px solid var(--border);
            border-radius: 24px; overflow: hidden; margin-top: 64px;
        }

        .lb-header {
            display: grid; grid-template-columns: 60px 1fr 120px 120px 100px;
            padding: 16px 28px; background: var(--surface2);
            font-size: 0.75rem; font-weight: 600; letter-spacing: 1px;
            text-transform: uppercase; color: var(--text-muted);
            border-bottom: 1px solid var(--border);
        }

        .lb-row {
            display: grid; grid-template-columns: 60px 1fr 120px 120px 100px;
            padding: 18px 28px; align-items: center;
            border-bottom: 1px solid var(--border);
            transition: background 0.2s;
        }
        .lb-row:hover { background: var(--surface2); }
        .lb-row:last-child { border-bottom: none; }

        .lb-rank {
            font-family: 'Syne', sans-serif; font-weight: 800;
            font-size: 1.1rem;
        }
        .lb-rank.gold { color: #ffd700; }
        .lb-rank.silver { color: #c0c0c0; }
        .lb-rank.bronze { color: #cd7f32; }

        .lb-user { display: flex; align-items: center; gap: 12px; }
        .lb-avatar {
            width: 36px; height: 36px; border-radius: 10px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1rem; font-weight: 700; font-family: 'Syne', sans-serif;
        }
        .lb-name { font-weight: 500; font-size: 0.95rem; }
        .lb-badge {
            font-size: 0.7rem; padding: 2px 8px; border-radius: 100px;
            background: rgba(108,99,255,0.15); color: var(--accent);
            margin-left: 8px;
        }

        .lb-score {
            font-family: 'Syne', sans-serif; font-weight: 700;
            color: var(--accent);
        }
        .lb-quizzes { color: var(--text-muted); font-size: 0.88rem; }

        .lb-accuracy {
            display: flex; align-items: center; gap: 8px;
        }
        .acc-bar {
            flex: 1; height: 6px; background: var(--surface2);
            border-radius: 3px; overflow: hidden;
        }
        .acc-fill {
            height: 100%; border-radius: 3px;
            background: linear-gradient(90deg, var(--accent3), #00b09b);
        }
        .acc-text { font-size: 0.8rem; color: var(--text-muted); }

        /* TESTIMONIALS */
        .testimonials { background: var(--surface); overflow: hidden; }

        .testimonials-track {
            display: flex; gap: 24px; margin-top: 64px;
            animation: scroll-left 30s linear infinite;
            width: max-content;
        }
        .testimonials-track:hover { animation-play-state: paused; }

        @keyframes scroll-left {
            from { transform: translateX(0); }
            to { transform: translateX(-50%); }
        }

        .testimonial-card {
            background: var(--surface2); border: 1px solid var(--border);
            border-radius: 20px; padding: 28px; width: 320px; flex-shrink: 0;
        }

        .test-stars { color: var(--accent4); font-size: 1rem; margin-bottom: 14px; }
        .test-text { color: var(--text-muted); font-size: 0.9rem; line-height: 1.65; margin-bottom: 20px; font-style: italic; }
        .test-user { display: flex; align-items: center; gap: 12px; }
        .test-avatar {
            width: 40px; height: 40px; border-radius: 10px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.1rem; font-weight: 700;
            font-family: 'Syne', sans-serif;
        }
        .test-name { font-weight: 600; font-size: 0.9rem; }
        .test-role { color: var(--text-muted); font-size: 0.78rem; }

        /* QUIZ PREVIEW */
        .quiz-preview { background: var(--bg); }

        .quiz-cards-grid {
            display: grid; grid-template-columns: repeat(3, 1fr);
            gap: 24px; margin-top: 64px;
        }

        .quiz-card {
            background: var(--surface); border: 1px solid var(--border);
            border-radius: 20px; overflow: hidden;
            transition: all 0.3s; cursor: none;
        }
        .quiz-card:hover { transform: translateY(-6px); border-color: var(--accent); box-shadow: 0 20px 60px rgba(108,99,255,0.15); }

        .quiz-card-banner {
            height: 120px; display: flex; align-items: center; justify-content: center;
            font-size: 3rem; position: relative; overflow: hidden;
        }
        .quiz-card-banner::after {
            content: ''; position: absolute; inset: 0;
            background: linear-gradient(to bottom, transparent 50%, var(--surface));
        }

        .quiz-card-body { padding: 20px 24px 24px; }
        .quiz-card-meta {
            display: flex; gap: 8px; margin-bottom: 10px;
        }
        .quiz-tag {
            font-size: 0.72rem; padding: 3px 9px; border-radius: 100px;
            background: rgba(108,99,255,0.1); color: var(--accent); border: 1px solid var(--border);
        }
        .quiz-card h3 {
            font-family: 'Syne', sans-serif; font-weight: 700;
            font-size: 1rem; margin-bottom: 8px; line-height: 1.3;
        }
        .quiz-card p { color: var(--text-muted); font-size: 0.83rem; line-height: 1.5; margin-bottom: 16px; }

        .quiz-card-footer {
            display: flex; justify-content: space-between; align-items: center;
            padding-top: 16px; border-top: 1px solid var(--border);
        }
        .quiz-card-stats { display: flex; gap: 16px; }
        .qstat { font-size: 0.78rem; color: var(--text-muted); display: flex; align-items: center; gap: 4px; }

        .btn-quiz {
            padding: 7px 16px; border-radius: 8px;
            background: rgba(108,99,255,0.15); color: var(--accent);
            border: 1px solid var(--border); font-size: 0.8rem; font-weight: 600;
            cursor: none; text-decoration: none; font-family: 'DM Sans', sans-serif;
            transition: all 0.2s;
        }
        .btn-quiz:hover { background: var(--accent); color: white; }

        /* COUNTER SECTION */
        .counters {
            background: linear-gradient(135deg, rgba(108,99,255,0.1), rgba(255,101,132,0.05));
            border-top: 1px solid var(--border);
            border-bottom: 1px solid var(--border);
            padding: 80px 60px;
        }

        .counters-grid {
            display: grid; grid-template-columns: repeat(4, 1fr);
            gap: 40px; text-align: center;
        }

        .counter-item .counter-num {
            font-family: 'Syne', sans-serif;
            font-size: 3rem; font-weight: 800;
            background: linear-gradient(135deg, var(--accent), var(--accent2));
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
            display: block; margin-bottom: 8px;
        }
        .counter-item .counter-label { color: var(--text-muted); font-size: 0.9rem; }

        /* FAQ */
        .faq { background: var(--surface); }

        .faq-grid {
            display: grid; grid-template-columns: 1fr 1fr;
            gap: 16px; margin-top: 64px;
        }

        .faq-item {
            background: var(--surface2); border: 1px solid var(--border);
            border-radius: 16px; overflow: hidden;
        }

        .faq-question {
            padding: 20px 24px; display: flex; justify-content: space-between;
            align-items: center; cursor: none; font-weight: 500; font-size: 0.95rem;
            transition: color 0.2s;
        }
        .faq-question:hover { color: var(--accent); }

        .faq-icon {
            width: 28px; height: 28px; flex-shrink: 0;
            background: rgba(108,99,255,0.1); border-radius: 8px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1rem; transition: transform 0.3s;
            color: var(--accent);
        }
        .faq-item.open .faq-icon { transform: rotate(45deg); }

        .faq-answer {
            padding: 0 24px; max-height: 0; overflow: hidden;
            transition: max-height 0.35s ease, padding 0.35s ease;
            color: var(--text-muted); font-size: 0.9rem; line-height: 1.7;
        }
        .faq-item.open .faq-answer {
            max-height: 200px; padding: 0 24px 20px;
        }

        /* CTA SECTION */
        .cta-section {
            padding: 120px 60px;
            text-align: center; position: relative; overflow: hidden;
        }

        .cta-section::before {
            content: '';
            position: absolute; inset: 0;
            background: radial-gradient(ellipse 70% 60% at 50% 50%, rgba(108,99,255,0.2) 0%, transparent 70%);
        }

        .cta-section .section-title { font-size: clamp(2.5rem, 5vw, 4rem); margin-bottom: 20px; }
        .cta-section p { color: var(--text-muted); max-width: 480px; margin: 0 auto 40px; line-height: 1.7; }

        .cta-actions { display: flex; gap: 16px; justify-content: center; flex-wrap: wrap; }

        /* FOOTER */
        footer {
            background: var(--surface); border-top: 1px solid var(--border);
            padding: 80px 60px 40px;
        }

        .footer-grid {
            display: grid; grid-template-columns: 2fr 1fr 1fr 1fr;
            gap: 60px; margin-bottom: 60px;
        }

        .footer-brand .nav-logo { font-size: 1.4rem; display: block; margin-bottom: 14px; }
        .footer-brand p { color: var(--text-muted); font-size: 0.88rem; line-height: 1.7; max-width: 260px; }

        .footer-social { display: flex; gap: 10px; margin-top: 20px; }
        .social-btn {
            width: 36px; height: 36px;
            background: var(--surface2); border: 1px solid var(--border);
            border-radius: 8px; display: flex; align-items: center; justify-content: center;
            font-size: 1rem; text-decoration: none;
            transition: all 0.2s; cursor: none;
        }
        .social-btn:hover { background: var(--accent); border-color: var(--accent); }

        .footer-col h4 {
            font-family: 'Syne', sans-serif; font-weight: 700;
            font-size: 0.9rem; margin-bottom: 18px; color: var(--text);
        }
        .footer-col ul { list-style: none; display: flex; flex-direction: column; gap: 10px; }
        .footer-col a {
            color: var(--text-muted); text-decoration: none; font-size: 0.88rem;
            transition: color 0.2s;
        }
        .footer-col a:hover { color: var(--accent); }

        .footer-bottom {
            padding-top: 32px; border-top: 1px solid var(--border);
            display: flex; justify-content: space-between; align-items: center;
        }
        .footer-bottom p { color: var(--text-muted); font-size: 0.82rem; }

        /* ANIMATIONS */
        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(24px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes fadeDown {
            from { opacity: 0; transform: translateY(-12px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .reveal {
            opacity: 0; transform: translateY(32px);
            transition: opacity 0.7s ease, transform 0.7s ease;
        }
        .reveal.visible { opacity: 1; transform: translateY(0); }

        /* RESPONSIVE */
        @media (max-width: 1100px) {
            .categories-grid { grid-template-columns: repeat(2, 1fr); }
            .steps { grid-template-columns: repeat(2, 1fr); }
            .steps::before { display: none; }
            .quiz-cards-grid { grid-template-columns: repeat(2, 1fr); }
            .footer-grid { grid-template-columns: 1fr 1fr; gap: 40px; }
        }

        @media (max-width: 768px) {
            nav { padding: 16px 24px; }
            nav.scrolled { padding: 12px 24px; }
            .nav-links { display: none; }
            section { padding: 70px 24px; }
            .hero { padding: 100px 24px 60px; }
            .hero-float { display: none; }
            .hero-stats { gap: 24px; }
            .features-grid { grid-template-columns: 1fr; }
            .features-visual { height: 360px; }
            .faq-grid { grid-template-columns: 1fr; }
            .counters-grid { grid-template-columns: repeat(2, 1fr); }
            .lb-header, .lb-row { grid-template-columns: 40px 1fr 80px; }
            .lb-header > *:nth-child(4), .lb-row > *:nth-child(4),
            .lb-header > *:nth-child(5), .lb-row > *:nth-child(5) { display: none; }
            .quiz-cards-grid { grid-template-columns: 1fr; }
            .footer-grid { grid-template-columns: 1fr; gap: 32px; }
            .footer-bottom { flex-direction: column; gap: 12px; text-align: center; }
            .counters { padding: 60px 24px; }
            .cta-section { padding: 80px 24px; }
        }
    </style>
</head>
<body>

<!-- Custom Cursor -->
<div class="cursor" id="cursor"></div>
<div class="cursor-ring" id="cursorRing"></div>

<!-- NAV -->
<nav id="navbar">
    <div class="nav-logo">Fun<span style="-webkit-text-fill-color: unset; color: var(--accent2)">Quiz</span></div>
    <ul class="nav-links">
        <li><a href="#categories">Categories</a></li>
        <li><a href="#faq">FAQ</a></li>
    </ul>
    <div class="nav-cta">
        <a href="login.jsp" class="btn-outline">Login</a>
        <a href="register.jsp" class="btn-primary">Get Started</a>
    </div>
</nav>

<!-- HERO -->
<section class="hero" id="home">
    <div class="hero-bg"></div>
    <div class="hero-grid"></div>

    <!-- Floating Cards -->
    <div>
            <h1>
            Challenge Your Mind.<br>
            <span class="line2">Master Every Quiz.</span>
        </h1>
        <p class="hero-sub">
            The smartest way to test your knowledge. Compete with thousands, climb the leaderboard, and prove you're the ultimate quiz champion.
        </p>
        <div class="hero-actions">
            <a href="register.jsp" class="btn-hero btn-hero-main">Start Quizzing Free →</a>
        </div>
        </div>
    
</section>

<!-- HOW IT WORKS -->
<section class="how" id="how">

<!-- CATEGORIES -->
<section id="categories" style="background: var(--bg);">
    <div class="reveal">
        <span class="section-label">Explore Topics</span>
        <h2 class="section-title">Quiz Categories</h2>
        <p class="section-sub">From rocket science to pop culture — we have a quiz for every curious mind.</p>
    </div>
    <div class="categories-grid reveal">
        <div class="cat-card" style="--card-color: #6c63ff;">
            <div class="cat-icon"></div>
            <h3>Pop Culture </h3>
            <span class="cat-count">120 quizzes</span>
        </div>
        <div class="cat-card" style="--card-color: #f7971e;">
            <div class="cat-icon"></div>
            <h3>Geography</h3>
            <span class="cat-count">95 quizzes</span>
        </div>
        <div class="cat-card" style="--card-color: #43e97b;">
            <div class="cat-icon"></div>
            <h3>Sports</h3>
            <span class="cat-count">80 quizzes</span>
        </div>
        <div class="cat-card" style="--card-color: #ff6584;">
            <div class="cat-icon"></div>
            <h3>Entertainment</h3>
            <span class="cat-count">110 quizzes</span>
        </div>
        
    </div>
</section>

<!-- COUNTERS -->

<!-- FEATURES -->
<section class="features" id="features">
    <div class="features-grid">
        <div class="reveal">
            <span class="section-label">Why FunMaster</span>
            <h2 class="section-title">Everything You Need<br>to Win</h2>
            <p class="section-sub" style="margin-bottom: 40px;">Built for students, competitive minds, and lifelong learners who take their knowledge seriously.</p>
            <div class="features-list">
                <div class="feature-item">
                    <div class="feature-icon" style="background: rgba(108,99,255,0.15);">⏱️</div>
                    <div>
                        <h4>Timed Challenges</h4>
                        <p>Every quiz is timed to sharpen your thinking speed and pressure performance.</p>
                    </div>
                </div>
                <div class="feature-item">
                    <div class="feature-icon" style="background: rgba(67,233,123,0.15);">📊</div>
                    <div>
                        <h4>Detailed Score Analytics</h4>
                        <p>See your accuracy, speed, and weak areas broken down after every quiz attempt.</p>
                    </div>
                </div>
                </div>
                <div class="feature-item">
                    <div class="feature-icon" style="background: rgba(247,151,30,0.15);">🔥</div>
                    <div>
                        <h4>Daily Streaks & XP</h4>
                        <p>Build streaks, earn experience points and unlock exclusive badges over time.</p>
                    </div>
                </div>
            </div>
        </div>
    <div>
    </div>
</section>

<!-- POPULAR QUIZZES -->

<!-- TESTIMONIALS -->

<!-- FAQ -->
<section class="faq" id="faq">
    <div class="reveal" style="text-align: center; margin-bottom: 0;">
        <span class="section-label">Got Questions?</span>
        <h2 class="section-title">Frequently Asked</h2>
    </div>
    <div class="faq-grid reveal">
        <div class="faq-item">
            <div class="faq-question">Is QuizMaster completely free to use? <span class="faq-icon">+</span></div>
            <div class="faq-answer">Yes! QuizMaster is 100% free. Create an account, pick any category and start playing instantly with no hidden charges.</div>
        </div>
        <div class="faq-item">
            <div class="faq-question">How are scores calculated? <span class="faq-icon">+</span></div>
            <div class="faq-answer">Scores are based on correctness and speed. The faster you answer correctly, the more points you earn. Streaks also give bonus multipliers.</div>
        </div>
        <div class="faq-item">
            <div class="faq-question">Can I retake a quiz? <span class="faq-icon">+</span></div>
            <div class="faq-answer">Yes, you can retake any quiz as many times as you want. Only your highest score counts towards the leaderboard.</div>
        </div>
        <div class="faq-item">
            <div class="faq-question">How often are new quizzes added? <span class="faq-icon">+</span></div>
            <div class="faq-answer">New quizzes are added weekly across all categories. Admin users can also create and publish new quizzes from the admin panel.</div>
        </div>
        <div class="faq-item">
            <div class="faq-question">Is there a mobile app? <span class="faq-icon">+</span></div>
            <div class="faq-answer">The website is fully responsive and works great on all mobile browsers. A dedicated app is on our roadmap for the future.</div>
        </div>
        <div class="faq-item">
            <div class="faq-question">How do I become an admin? <span class="faq-icon">+</span></div>
            <div class="faq-answer">Admin access is assigned manually. If you're a teacher or content creator interested in creating quizzes, contact us through the support form.</div>
        </div>
    </div>
</section>

<!-- CTA -->
<section class="cta-section">
    <div style="position: relative; z-index: 1;">
        <span class="section-label reveal">Ready to Play?</span>
        <h2 class="section-title reveal">Start Your Quiz Journey<br>Today. It's Free.</h2>
        <div class="cta-actions reveal">
            <a href="register.jsp" class="btn-hero btn-hero-main">Create Free Account →</a>
            <a href="login.jsp" class="btn-hero btn-hero-sec">I Already Have an Account</a>
        </div>
    </div>
</section>

<!-- FOOTER -->
<footer>
    <div class="footer-grid">
        <div class="footer-brand">
            <span class="nav-logo">Quiz<span style="-webkit-text-fill-color: unset; background: none; color: var(--accent2)">Master</span></span>
            <p>The smartest online quiz platform for students, professionals, and curious minds across India and beyond.</p>
                    </div>
        <div class="footer-col">
           <div class="footer-col">
            <h4>Categories</h4>
            <ul>
                <li><a href="login.jsp">POp Culture</a></li>
                <li><a href="login.jsp">Geography</a></li>
                <li><a href="login.jsp">Entertainment</a></li>
                <li><a href="login.jsp">Sports</a></li>
            </ul>
        </div>
    </div>
    <div class="footer-bottom">
        <p>© 2025 FunMaster. Built with ❤️ for knowledge seekers everywhere.</p>
        <p style="color: var(--text-muted);">Made in India 🇮🇳</p>
    </div>
</footer>

<script>
    // Custom Cursor
    const cursor = document.getElementById('cursor');
    const ring = document.getElementById('cursorRing');
    let mx = 0, my = 0, rx = 0, ry = 0;
    document.addEventListener('mousemove', e => { mx = e.clientX; my = e.clientY; cursor.style.left = mx + 'px'; cursor.style.top = my + 'px'; });
    function animateRing() { rx += (mx - rx) * 0.12; ry += (my - ry) * 0.12; ring.style.left = rx + 'px'; ring.style.top = ry + 'px'; requestAnimationFrame(animateRing); }
    animateRing();
    document.querySelectorAll('a, button, .cat-card, .quiz-card, .step, .faq-question').forEach(el => {
        el.addEventListener('mouseenter', () => { cursor.style.width = '18px'; cursor.style.height = '18px'; ring.style.width = '50px'; ring.style.height = '50px'; ring.style.opacity = '0.8'; });
        el.addEventListener('mouseleave', () => { cursor.style.width = '12px'; cursor.style.height = '12px'; ring.style.width = '36px'; ring.style.height = '36px'; ring.style.opacity = '0.5'; });
    });

    // Navbar scroll
    window.addEventListener('scroll', () => {
        document.getElementById('navbar').classList.toggle('scrolled', window.scrollY > 60);
    });

    // Scroll reveal
    const observer = new IntersectionObserver(entries => {
        entries.forEach(e => { if (e.isIntersecting) { e.target.classList.add('visible'); } });
    }, { threshold: 0.12 });
    document.querySelectorAll('.reveal').forEach(el => observer.observe(el));

    // Counter animation
    function animateCounter(el, target) {
        const duration = 2000;
        const start = performance.now();
        function update(now) {
            const progress = Math.min((now - start) / duration, 1);
            const eased = 1 - Math.pow(1 - progress, 3);
            const current = Math.floor(eased * target);
            el.textContent = current >= 1000000 ? (current / 1000000).toFixed(1) + 'M+' : current >= 1000 ? (current / 1000).toFixed(0) + 'K+' : current + (target === 99 || target === 98 ? '%' : '');
            if (progress < 1) requestAnimationFrame(update);
        }
        requestAnimationFrame(update);
    }

    const counterObserver = new IntersectionObserver(entries => {
        entries.forEach(e => {
            if (e.isIntersecting) {
                const els = e.target.querySelectorAll('[data-target]');
                els.forEach(el => animateCounter(el, parseInt(el.dataset.target)));
                counterObserver.unobserve(e.target);
            }
        });
    }, { threshold: 0.3 });
    document.querySelectorAll('.hero-stats, .counters-grid').forEach(el => counterObserver.observe(el));

    // FAQ accordion
    document.querySelectorAll('.faq-question').forEach(q => {
        q.addEventListener('click', () => {
            const item = q.parentElement;
            const isOpen = item.classList.contains('open');
            document.querySelectorAll('.faq-item').forEach(i => i.classList.remove('open'));
            if (!isOpen) item.classList.add('open');
        });
    });

    // Mock quiz option click animation
    document.querySelectorAll('.mock-option').forEach(opt => {
        opt.addEventListener('click', () => {
            document.querySelectorAll('.mock-option').forEach(o => o.classList.remove('selected'));
            opt.classList.add('selected');
        });
    });
</script>
</body>
</html>
