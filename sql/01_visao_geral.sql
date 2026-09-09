-- ================================================================
-- 01_visao_geral.sql
-- Objetivo: Calcular os indicadores gerais da carteira de crédito.
-- Responde: Qual é o tamanho da carteira e a taxa geral de inadimplência?
-- ================================================================

-- Total de contratos na carteira
SELECT COUNT(*) AS total_contratos
FROM contratos;

-- Total de contratos inadimplentes (atraso >= 90 dias)
SELECT COUNT(*) AS total_inadimplentes
FROM contratos
WHERE inadimplente_90d = 1;

-- Taxa geral de inadimplência da carteira
SELECT
    COUNT(*)                                                        AS total_contratos,
    SUM(inadimplente_90d)                                           AS total_inadimplentes,
    ROUND(SUM(inadimplente_90d) * 100.0 / COUNT(*), 2)             AS taxa_inadimplencia_pct
FROM contratos;