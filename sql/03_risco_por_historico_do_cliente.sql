-- ================================================================
-- 03_risco_por_historico_do_cliente.sql
-- Objetivo: Avaliar se o tempo de relacionamento e o número de
--           empréstimos anteriores influenciam o risco de inadimplência.
-- Responde: Clientes novos são mais arriscados? Mais empréstimos
--           anteriores indicam maior ou menor risco?
-- ================================================================

-- Inadimplência por faixa de tempo de relacionamento (em dias)
SELECT
    CASE
        WHEN tempo_relacionamento_dias < 150  THEN '1. Até 149 dias'
        WHEN tempo_relacionamento_dias < 300  THEN '2. 150 a 299 dias'
        WHEN tempo_relacionamento_dias < 450  THEN '3. 300 a 449 dias'
        WHEN tempo_relacionamento_dias < 600  THEN '4. 450 a 599 dias'
        WHEN tempo_relacionamento_dias < 750  THEN '5. 600 a 749 dias'
        WHEN tempo_relacionamento_dias < 900  THEN '6. 750 a 899 dias'
        ELSE                                       '7. Mais de 900 dias'
    END                                                                             AS faixa_relacionamento,
    COUNT(*)                                                                        AS total_contratos,
    SUM(inadimplente_90d)                                                           AS total_inadimplentes,
    ROUND(SUM(CASE WHEN inadimplente_90d = 1 THEN 1.0 ELSE 0 END) / COUNT(*) * 100, 2) AS taxa_inadimplencia_pct
FROM contratos
GROUP BY faixa_relacionamento
ORDER BY faixa_relacionamento;

-- Inadimplência por número de empréstimos anteriores
SELECT
    num_emprestimos_anteriores,
    COUNT(*)                                                                        AS total_contratos,
    SUM(inadimplente_90d)                                                           AS total_inadimplentes,
    ROUND(SUM(CASE WHEN inadimplente_90d = 1 THEN 1.0 ELSE 0 END) / COUNT(*) * 100, 2) AS taxa_inadimplencia_pct
FROM contratos
GROUP BY num_emprestimos_anteriores
ORDER BY num_emprestimos_anteriores;