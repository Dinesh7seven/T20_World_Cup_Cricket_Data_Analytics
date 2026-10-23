-- =====================================================
-- T20 WORLD CUP CRICKET ANALYTICS
-- SQL Analysis Queries
-- =====================================================

-- 1. View batting data
SELECT *
FROM batting_summary;

-- 2. Top 10 batters by total runs
SELECT
    batter,
    SUM(runs) AS total_runs
FROM batting_summary
GROUP BY batter
ORDER BY total_runs DESC
LIMIT 10;

-- 3. Top batters by strike rate
SELECT
    batter,
    ROUND(AVG(strike_rate), 2) AS average_strike_rate
FROM batting_summary
GROUP BY batter
HAVING COUNT(*) >= 3
ORDER BY average_strike_rate DESC
LIMIT 10;

-- 4. Total fours and sixes by batter
SELECT
    batter,
    SUM(fours) AS total_fours,
    SUM(sixes) AS total_sixes,
    SUM(fours) * 4 + SUM(sixes) * 6 AS boundary_runs
FROM batting_summary
GROUP BY batter
ORDER BY boundary_runs DESC
LIMIT 10;

-- 5. Overall batting statistics
SELECT
    COUNT(DISTINCT batter) AS total_batters,
    SUM(runs) AS total_runs,
    ROUND(AVG(strike_rate), 2) AS average_strike_rate,
    SUM(fours) AS total_fours,
    SUM(sixes) AS total_sixes
FROM batting_summary;

-- 6. Top 10 bowlers by wickets
SELECT
    bowler,
    SUM(wickets) AS total_wickets
FROM bowling_summary
GROUP BY bowler
ORDER BY total_wickets DESC
LIMIT 10;

-- 7. Bowling economy rate
-- Assumes legal_balls contains the number of legal deliveries.
SELECT
    bowler,
    SUM(runs_conceded) AS runs_conceded,
    SUM(legal_balls) AS legal_balls,
    ROUND(
        SUM(runs_conceded) * 6.0 / NULLIF(SUM(legal_balls), 0),
        2
    ) AS economy_rate
FROM bowling_summary
GROUP BY bowler
ORDER BY economy_rate ASC;

-- 8. Overall bowling statistics
SELECT
    COUNT(DISTINCT bowler) AS total_bowlers,
    SUM(wickets) AS total_wickets,
    SUM(runs_conceded) AS total_runs_conceded
FROM bowling_summary;

-- 9. Rank batters by runs
SELECT
    batter,
    SUM(runs) AS total_runs,
    RANK() OVER (ORDER BY SUM(runs) DESC) AS batting_rank
FROM batting_summary
GROUP BY batter;

-- 10. Rank bowlers by wickets
SELECT
    bowler,
    SUM(wickets) AS total_wickets,
    RANK() OVER (ORDER BY SUM(wickets) DESC) AS bowling_rank
FROM bowling_summary
GROUP BY bowler;
