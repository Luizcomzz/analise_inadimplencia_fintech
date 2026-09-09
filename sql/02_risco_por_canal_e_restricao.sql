-- ================================================================
-- 02_risco_por_canal_e_restricao.sql
-- Objetivo: Identificar se o canal de aquisição e a existência de
--           restrição de crédito influenciam a inadimplência.
-- Responde: Quais canais concentram mais risco? Clientes com restrição
--           são de fato mais propensos a inadimplir?
-- ================================================================

-- Inadimplência por canal de aquisição
SELECT
    canal_aquisicao,
    COUNT(*)                                                                        AS total_contratos,
    SUM(inadimplente_90d)                                                           AS total_inadimplentes,
    ROUND(SUM(CASE WHEN inadimplente_90d = 1 THEN 1.0 ELSE 0 END) / COUNT(*) * 100, 2) AS taxa_inadimplencia_pct
FROM contratos
GROUP BY canal_aquisicao
ORDER BY taxa_inadimplencia_pct DESC;

-- Inadimplência por presença de restrição de crédito no momento da concessão
SELECT
    CASE possui_restricao WHEN 1 THEN 'Com restrição' ELSE 'Sem restrição' END     AS perfil_restricao,
    COUNT(*)                                                                        AS total_contratos,
    SUM(inadimplente_90d)                                                           AS total_inadimplentes,
    ROUND(SUM(CASE WHEN inadimplente_90d = 1 THEN 1.0 ELSE 0 END) / COUNT(*) * 100, 2) AS taxa_inadimplencia_pct
FROM contratos
GROUP BY possui_restricao
ORDER BY taxa_inadimplencia_pct DESC;