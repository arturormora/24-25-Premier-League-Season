-- ================================================
-- PREMIER LEAGUE 2024-25 SEASON - SQL QUERIES
-- ================================================

-- Estas queries asumen una base de datos relacional con las siguientes tablas:
--   - matches (partidos)
--   - teams (equipos)
--   - team_statistics (estadísticas por equipo)

-- ================================================
-- 1. ANÁLISIS BÁSICO
-- ================================================

-- 1.1 Obtener todos los partidos ordenados por fecha
SELECT 
    match_date,
    home_team,
    away_team,
    home_goals,
    away_goals,
    CASE 
        WHEN home_goals > away_goals THEN 'Home Win'
        WHEN home_goals < away_goals THEN 'Away Win'
        ELSE 'Draw'
    END AS result
FROM matches
ORDER BY match_date DESC;


-- 1.2 Contar partidos por resultado
SELECT 
    CASE 
        WHEN home_goals > away_goals THEN 'Home Win'
        WHEN home_goals < away_goals THEN 'Away Win'
        ELSE 'Draw'
    END AS result_type,
    COUNT(*) as total_matches,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM matches), 2) as percentage
FROM matches
GROUP BY result_type
ORDER BY total_matches DESC;


-- ================================================
-- 2. ESTADÍSTICAS POR EQUIPO
-- ================================================

-- 2.1 Tabla de posiciones (League Table)
WITH team_stats AS (
    -- Estadísticas como local
    SELECT 
        home_team AS team,
        COUNT(*) as games_played,
        SUM(CASE WHEN home_goals > away_goals THEN 1 ELSE 0 END) as wins,
        SUM(CASE WHEN home_goals = away_goals THEN 1 ELSE 0 END) as draws,
        SUM(CASE WHEN home_goals < away_goals THEN 1 ELSE 0 END) as losses,
        SUM(home_goals) as goals_for,
        SUM(away_goals) as goals_against
    FROM matches
    GROUP BY home_team
    
    UNION ALL
    
    -- Estadísticas como visitante
    SELECT 
        away_team AS team,
        COUNT(*) as games_played,
        SUM(CASE WHEN away_goals > home_goals THEN 1 ELSE 0 END) as wins,
        SUM(CASE WHEN away_goals = home_goals THEN 1 ELSE 0 END) as draws,
        SUM(CASE WHEN away_goals < home_goals THEN 1 ELSE 0 END) as losses,
        SUM(away_goals) as goals_for,
        SUM(home_goals) as goals_against
    FROM matches
    GROUP BY away_team
)
SELECT 
    team,
    SUM(games_played) as played,
    SUM(wins) as won,
    SUM(draws) as drawn,
    SUM(losses) as lost,
    SUM(goals_for) as goals_for,
    SUM(goals_against) as goals_against,
    SUM(goals_for) - SUM(goals_against) as goal_difference,
    (SUM(wins) * 3 + SUM(draws)) as points,
    ROUND(SUM(wins) * 100.0 / SUM(games_played), 2) as win_percentage
FROM team_stats
GROUP BY team
ORDER BY points DESC, goal_difference DESC;


-- 2.2 Top 10 goleadores (equipos)
SELECT 
    team,
    total_goals as goals_scored,
    games_played,
    ROUND(total_goals * 1.0 / games_played, 2) as goals_per_game
FROM (
    SELECT 
        home_team as team,
        COUNT(*) as games_played,
        SUM(home_goals) as home_goals_total,
        0 as away_goals_total
    FROM matches
    GROUP BY home_team
    
    UNION ALL
    
    SELECT 
        away_team as team,
        COUNT(*) as games_played,
        0 as home_goals_total,
        SUM(away_goals) as away_goals_total
    FROM matches
    GROUP BY away_team
) team_goals
JOIN (
    SELECT 
        team,
        SUM(home_goals_total + away_goals_total) as total_goals,
        SUM(games_played) as games_played
    FROM (
        SELECT home_team as team, SUM(home_goals) as home_goals_total, 
               0 as away_goals_total, COUNT(*) as games_played
        FROM matches GROUP BY home_team
        UNION ALL
        SELECT away_team as team, 0 as home_goals_total, 
               SUM(away_goals) as away_goals_total, COUNT(*) as games_played
        FROM matches GROUP BY away_team
    )
    GROUP BY team
) totals USING (team)
ORDER BY total_goals DESC
LIMIT 10;


-- ================================================
-- 3. ANÁLISIS DE VENTAJA LOCAL
-- ================================================

-- 3.1 Comparación de rendimiento local vs visitante
SELECT 
    'Home' as location,
    COUNT(*) as total_games,
    AVG(home_goals) as avg_goals,
    SUM(CASE WHEN home_goals > away_goals THEN 1 ELSE 0 END) as wins,
    ROUND(SUM(CASE WHEN home_goals > away_goals THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as win_percentage
FROM matches

UNION ALL

SELECT 
    'Away' as location,
    COUNT(*) as total_games,
    AVG(away_goals) as avg_goals,
    SUM(CASE WHEN away_goals > home_goals THEN 1 ELSE 0 END) as wins,
    ROUND(SUM(CASE WHEN away_goals > home_goals THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as win_percentage
FROM matches;


-- 3.2 Equipos con mejor rendimiento como local
SELECT 
    home_team as team,
    COUNT(*) as home_games,
    SUM(CASE WHEN home_goals > away_goals THEN 1 ELSE 0 END) as home_wins,
    ROUND(SUM(CASE WHEN home_goals > away_goals THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as home_win_percentage,
    AVG(home_goals) as avg_home_goals
FROM matches
GROUP BY home_team
HAVING COUNT(*) >= 10
ORDER BY home_win_percentage DESC
LIMIT 10;


-- ================================================
-- 4. ANÁLISIS DE GOLES
-- ================================================

-- 4.1 Distribución de goles por partido
SELECT 
    (home_goals + away_goals) as total_goals,
    COUNT(*) as frequency,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM matches), 2) as percentage
FROM matches
GROUP BY total_goals
ORDER BY total_goals;


-- 4.2 Partidos de más goles
SELECT 
    match_date,
    home_team,
    away_team,
    home_goals,
    away_goals,
    (home_goals + away_goals) as total_goals
FROM matches
ORDER BY total_goals DESC
LIMIT 10;


-- 4.3 Promedio de goles por mes
SELECT 
    EXTRACT(MONTH FROM match_date) as month,
    TO_CHAR(match_date, 'Month') as month_name,
    COUNT(*) as matches,
    AVG(home_goals + away_goals) as avg_goals_per_match,
    SUM(home_goals + away_goals) as total_goals
FROM matches
GROUP BY EXTRACT(MONTH FROM match_date), TO_CHAR(match_date, 'Month')
ORDER BY month;


-- ================================================
-- 5. ANÁLISIS DE DISCIPLINA
-- ================================================

-- 5.1 Equipos con más tarjetas
SELECT 
    team,
    total_yellow_cards,
    total_red_cards,
    (total_yellow_cards + total_red_cards * 3) as discipline_points,
    ROUND(total_yellow_cards * 1.0 / games_played, 2) as yellow_cards_per_game
FROM (
    SELECT 
        home_team as team,
        COUNT(*) as games_played,
        SUM(home_yellow_cards) as home_yellows,
        SUM(home_red_cards) as home_reds,
        0 as away_yellows,
        0 as away_reds
    FROM matches
    GROUP BY home_team
    
    UNION ALL
    
    SELECT 
        away_team as team,
        COUNT(*) as games_played,
        0 as home_yellows,
        0 as home_reds,
        SUM(away_yellow_cards) as away_yellows,
        SUM(away_red_cards) as away_reds
    FROM matches
    GROUP BY away_team
) card_stats
JOIN (
    SELECT 
        team,
        SUM(home_yellows + away_yellows) as total_yellow_cards,
        SUM(home_reds + away_reds) as total_red_cards,
        SUM(games_played) as games_played
    FROM (
        SELECT home_team as team, COUNT(*) as games_played,
               SUM(home_yellow_cards) as home_yellows, SUM(home_red_cards) as home_reds,
               0 as away_yellows, 0 as away_reds
        FROM matches GROUP BY home_team
        UNION ALL
        SELECT away_team as team, COUNT(*) as games_played,
               0 as home_yellows, 0 as home_reds,
               SUM(away_yellow_cards) as away_yellows, SUM(away_red_cards) as away_reds
        FROM matches GROUP BY away_team
    )
    GROUP BY team
) totals USING (team)
ORDER BY discipline_points DESC
LIMIT 10;


-- ================================================
-- 6. ANÁLISIS DE ARBITRAJE
-- ================================================

-- 6.1 Estadísticas por árbitro
SELECT 
    referee,
    COUNT(*) as matches_officiated,
    AVG(home_goals + away_goals) as avg_goals_per_match,
    AVG(home_yellow_cards + away_yellow_cards) as avg_yellow_cards,
    AVG(home_red_cards + away_red_cards) as avg_red_cards,
    SUM(home_yellow_cards + away_yellow_cards + home_red_cards + away_red_cards) as total_cards
FROM matches
GROUP BY referee
HAVING COUNT(*) >= 10
ORDER BY matches_officiated DESC;


-- 6.2 Árbitros más estrictos (más tarjetas por partido)
SELECT 
    referee,
    COUNT(*) as matches,
    AVG(home_yellow_cards + away_yellow_cards + 
        (home_red_cards + away_red_cards) * 2) as avg_card_points
FROM matches
GROUP BY referee
HAVING COUNT(*) >= 10
ORDER BY avg_card_points DESC
LIMIT 10;


-- ================================================
-- 7. ANÁLISIS AVANZADO
-- ================================================

-- 7.1 Efectividad de tiro (Goals vs Shots)
WITH shot_stats AS (
    SELECT 
        home_team as team,
        SUM(home_goals) as goals,
        SUM(home_shots) as total_shots,
        SUM(home_shots_on_target) as shots_on_target
    FROM matches
    GROUP BY home_team
    
    UNION ALL
    
    SELECT 
        away_team as team,
        SUM(away_goals) as goals,
        SUM(away_shots) as total_shots,
        SUM(away_shots_on_target) as shots_on_target
    FROM matches
    GROUP BY away_team
)
SELECT 
    team,
    SUM(goals) as total_goals,
    SUM(total_shots) as total_shots,
    SUM(shots_on_target) as total_shots_on_target,
    ROUND(SUM(shots_on_target) * 100.0 / NULLIF(SUM(total_shots), 0), 2) as shot_accuracy_pct,
    ROUND(SUM(goals) * 100.0 / NULLIF(SUM(shots_on_target), 0), 2) as conversion_rate_pct
FROM shot_stats
GROUP BY team
ORDER BY conversion_rate_pct DESC;


-- 7.2 Rachas de victorias
WITH match_results AS (
    SELECT 
        match_date,
        home_team as team,
        CASE 
            WHEN home_goals > away_goals THEN 1
            WHEN home_goals < away_goals THEN 0
            ELSE NULL
        END as won
    FROM matches
    
    UNION ALL
    
    SELECT 
        match_date,
        away_team as team,
        CASE 
            WHEN away_goals > home_goals THEN 1
            WHEN away_goals < home_goals THEN 0
            ELSE NULL
        END as won
    FROM matches
),
streaks AS (
    SELECT 
        team,
        match_date,
        won,
        ROW_NUMBER() OVER (PARTITION BY team ORDER BY match_date) - 
        ROW_NUMBER() OVER (PARTITION BY team, won ORDER BY match_date) as streak_group
    FROM match_results
    WHERE won = 1
)
SELECT 
    team,
    COUNT(*) as consecutive_wins,
    MIN(match_date) as streak_start,
    MAX(match_date) as streak_end
FROM streaks
GROUP BY team, streak_group
HAVING COUNT(*) >= 3
ORDER BY consecutive_wins DESC, team;


-- 7.3 Head-to-Head: Rendimiento contra equipos específicos
SELECT 
    home_team,
    away_team,
    COUNT(*) as matches_played,
    SUM(CASE WHEN home_goals > away_goals THEN 1 ELSE 0 END) as home_wins,
    SUM(CASE WHEN home_goals = away_goals THEN 1 ELSE 0 END) as draws,
    SUM(CASE WHEN home_goals < away_goals THEN 1 ELSE 0 END) as away_wins,
    SUM(home_goals) as home_goals_total,
    SUM(away_goals) as away_goals_total
FROM matches
WHERE home_team IN ('Liverpool', 'Man City', 'Arsenal')
    AND away_team IN ('Liverpool', 'Man City', 'Arsenal')
    AND home_team != away_team
GROUP BY home_team, away_team
ORDER BY home_team, away_team;


-- ================================================
-- 8. MÉTRICAS DE RENDIMIENTO (KPIs)
-- ================================================

-- 8.1 Dashboard de KPIs generales
SELECT 
    COUNT(*) as total_matches,
    SUM(home_goals + away_goals) as total_goals,
    ROUND(AVG(home_goals + away_goals), 2) as avg_goals_per_match,
    MAX(home_goals + away_goals) as highest_scoring_match,
    SUM(home_yellow_cards + away_yellow_cards) as total_yellow_cards,
    SUM(home_red_cards + away_red_cards) as total_red_cards,
    COUNT(DISTINCT home_team) as total_teams,
    COUNT(DISTINCT referee) as total_referees
FROM matches;


-- 8.2 Rendimiento por día de la semana
SELECT 
    TO_CHAR(match_date, 'Day') as day_of_week,
    COUNT(*) as matches,
    AVG(home_goals + away_goals) as avg_goals,
    SUM(CASE WHEN home_goals > away_goals THEN 1 ELSE 0 END) * 100.0 / COUNT(*) as home_win_pct
FROM matches
GROUP BY TO_CHAR(match_date, 'Day'), EXTRACT(DOW FROM match_date)
ORDER BY EXTRACT(DOW FROM match_date);


-- ================================================
-- FIN DE SQL
-- ================================================
