-- ================================================================
-- 04_risco_por_perfil_financeiro.sql
-- Objetivo: Avaliar se o score de crédito e o comprometimento de
--           renda do cliente estão associados à inadimplência.
-- Responde: Qual faixa de score concentra mais risco? Clientes com
--           renda mais comprometida inadimplem mais?
-- ================================================================

-- Inadimplência por faixa de score de crédito interno
SELECT
    CASE
        WHEN score_interno < 150  THEN '1. Até 149'
        WHEN score_interno < 300  THEN '2. 150 a 299'
        WHEN score_interno < 450  THEN '3. 300 a 449'
        WHEN score_interno < 600  THEN '4. 450 a 599'
        WHEN score_interno < 750  THEN '5. 600 a 749'
        WHEN score_interno < 900  THEN '6. 750 a 899'
        ELSE                           '7. Acima de 900'
    END                                                                             AS faixa_score,
    COUNT(*)                                                                        AS total_contratos,
    SUM(inadimplente_90d)                                                           AS total_inadimplentes,
    ROUND(SUM(CASE WHEN inadimplente_90d = 1 THEN 1.0 ELSE 0 END) / COUNT(*) * 100, 2) AS taxa_inadimplencia_pct
FROM contratos
GROUP BY faixa_score
ORDER BY faixa_score;

-- Inadimplência por faixa de comprometimento de renda
SELECT
    CASE
        WHEN comprometimento_renda < 0.25  THEN '1. Até 25%'
        WHEN comprometimento_renda < 0.50  THEN '2. 25% a 49%'
        WHEN comprometimento_renda < 0.75  THEN '3. 50% a 74%'
        WHEN comprometimento_renda < 1.00  THEN '4. 75% a 99%'
        WHEN comprometimento_renda < 1.25  THEN '5. 100% a 124%'
        WHEN comprometimento_renda < 1.50  THEN '6. 125% a 149%'
        ELSE                                    '7. Acima de 150%'
    END                                                                             AS faixa_comprometimento,
    COUNT(*)                                                                        AS total_contratos,
    SUM(inadimplente_90d)                                                           AS total_inadimplentes,
    ROUND(SUM(CASE WHEN inadimplente_90d = 1 THEN 1.0 ELSE 0 END) / COUNT(*) * 100, 2) AS taxa_inadimplencia_pct
FROM contratos
GROUP BY faixa_comprometimento
ORDER BY faixa_comprometimento;