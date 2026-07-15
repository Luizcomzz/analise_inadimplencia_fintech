-- Total de contratos
SELECT COUNT(*)
FROM contratos;

-- Total Inadimplencia
SELECT COUNT(*)
FROM contratos
WHERE inadimplente_90d = 1;

--taxa de inadimplencia
SELECT
    ((SELECT COUNT(*) FROM contratos WHERE inadimplente_90d = 1) * 1.0)
    / COUNT(*) AS taxa_inadimplencias
FROM contratos;

--comparar total por meio de comunicação
SELECT
    canal_aquisicao,
    COUNT(*) AS total_por_canal,
    SUM(inadimplente_90d) AS total_inadimplentes,
    ROUND(SUM(CASE WHEN inadimplente_90d = 1 THEN 1.0 ELSE 0 END) / COUNT(*) * 100, 2) AS percentual_inadimplencia
FROM contratos
GROUP BY canal_aquisicao
ORDER BY percentual_inadimplencia DESC;

--comparar total por haver restrição
SELECT
    possui_restricao,
    COUNT(*) AS total_por_canal,
    SUM(inadimplente_90d) AS total_inadimplentes,
    ROUND(SUM(CASE WHEN inadimplente_90d = 1 THEN 1.0 ELSE 0 END) / COUNT(*) * 100, 2) AS percentual_inadimplencia
FROM contratos
GROUP BY possui_restricao
ORDER BY percentual_inadimplencia DESC;

--comparar por tempo de relacionamento
SELECT
    CASE
        WHEN  tempo_relacionamento_dias < 150 THEN '1. com até até 149 dias de relacionamento'
        WHEN  tempo_relacionamento_dias < 300  THEN '2. entre 150 e 299 dias de relacionamento'
        WHEN  tempo_relacionamento_dias < 450 THEN '3. entre 300 e 449 dias de relacionamento'
        WHEN  tempo_relacionamento_dias < 600  THEN '4. entre 450 e 599 dias de relacionamento'
        WHEN  tempo_relacionamento_dias < 750  THEN '5. entre 600 e 749 dias de relacionamento'
        WHEN  tempo_relacionamento_dias < 900  THEN '6. entre 750 e 899 dias de relacionamento'
        ELSE '7. mais de 900 dias de relacionamento'
    END AS faixa_relacionamento,
    COUNT(*) AS total_clientes,
    SUM(inadimplente_90d) AS total_inadimplentes,
    ROUND(SUM(CASE WHEN inadimplente_90d = 1 THEN 1.0 ELSE 0 END) / COUNT(*) * 100, 2) AS percentual_inadimplencia
FROM contratos
GROUP BY faixa_relacionamento;

--comparar por score interno
SELECT
    CASE
        WHEN  score_interno < 150 THEN '1. clientes com escore até 149'
        WHEN  score_interno < 300  THEN '2. clientes com escore entre 150 e 299'
        WHEN  score_interno < 450 THEN '3. clientes  com escore entre 300 e 449'
        WHEN  score_interno < 600  THEN '4. clientes com escore entre 450 e 599'
        WHEN  score_interno < 750  THEN '5. clientes com escore entre 600 e 749'
        WHEN  score_interno < 900  THEN '6. clientes com escore entre 750 e 899'
        ELSE '7. clientes com score maior que 900'
    END AS faixa_score,
    COUNT(*) AS total_clientes,
    SUM(inadimplente_90d) AS total_inadimplentes,
    ROUND(SUM(CASE WHEN inadimplente_90d = 1 THEN 1.0 ELSE 0 END) / COUNT(*) * 100, 2) AS percentual_inadimplencia
FROM contratos
GROUP BY faixa_score
ORDER BY faixa_score;

--comparar por número de emprestimos anteriores
SELECT
    num_emprestimos_anteriores,
    COUNT(*) AS total_por_canal,
    SUM(inadimplente_90d) AS total_inadimplentes,
    ROUND(SUM(CASE WHEN inadimplente_90d = 1 THEN 1.0 ELSE 0 END) / COUNT(*) * 100, 2) AS percentual_inadimplencia
FROM contratos
GROUP BY num_emprestimos_anteriores;

--compara compartimento de renda
SELECT
    CASE
        WHEN  comprometimento_renda < 0.25 THEN '1. comprometimento até 0.25'
        WHEN  comprometimento_renda < 0.5  THEN '2. comprometimento entre 0.25 à 0.49'
        WHEN  comprometimento_renda < 0.75 THEN '3. comprometimento entre 0.5 à 0.74'
        WHEN  comprometimento_renda < 1.0  THEN '4. comprometimento entre 0.75 à 0.99'
        WHEN  comprometimento_renda < 1.25  THEN '5. comprometimento entre 1 à 1.24'
        WHEN  comprometimento_renda < 1.5  THEN '6. comprometimento entre 1.25 à 1.49'
        ELSE '7. comprometimento maior que 1.5'
    END AS faixa_comprometimento,
    COUNT(*) AS total_clientes,
    SUM(inadimplente_90d) AS total_inadimplentes,
    ROUND(SUM(CASE WHEN inadimplente_90d = 1 THEN 1.0 ELSE 0 END) / COUNT(*) * 100, 2) AS percentual_inadimplencia
FROM contratos
GROUP BY faixa_comprometimento
ORDER BY faixa_comprometimento;

